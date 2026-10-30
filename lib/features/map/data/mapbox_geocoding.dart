import 'dart:convert';
import 'dart:io';
import 'dart:math' as math;

/// A single resolved place returned by the Mapbox Search Box API.
class GeocodedPlace {
  const GeocodedPlace({
    required this.latitude,
    required this.longitude,
    required this.title,
    required this.address,
    this.category,
  });

  final double latitude;
  final double longitude;

  /// Primary POI / place name — e.g. "BDO Power Plant Mall".
  final String title;

  /// Full, human-readable address as returned by Mapbox.
  final String address;

  /// Mapbox `feature_type` — one of `poi`, `address`, `place`, `street`,
  /// `neighborhood`, `locality`, `postcode`, etc. Used to pick a
  /// suggestion-row icon.
  final String? category;

  /// Backward-compatible alias used by existing flows.
  String get placeName => address;
}

/// Wrapper around Mapbox's **Search Box API v1** (`/search/searchbox/v1/forward`).
///
/// We deliberately use Search Box instead of the legacy v5 Geocoding API
/// (`/geocoding/v5/mapbox.places/*`) because Search Box uses Mapbox's newer
/// POI database, which has dramatically better coverage for international
/// addresses and landmarks (Philippines, Japan, Indonesia, etc.). Try
/// searching "The Gramercy Residences, Makati" on v5 vs v1 — v5 doesn't
/// know about it; v1 returns it at rank 1.
///
/// Tuned for typeahead search where the user's *intended* region is always
/// whatever they are currently looking at on the map:
/// - [longitude] / [latitude] (when both are provided) are sent as
///   `proximity={lng},{lat}` so Mapbox biases results.
/// - If either coordinate is `null`, no `proximity` parameter is sent and
///   the query runs unbiased. We deliberately do not fall back to
///   `proximity=ip` (it misfires on NAT'd mobile and emulator defaults).
/// - [types] limits the feature mix to useful-for-travel types. Empty =
///   let Mapbox use its default mix.
/// - [countryCodes] optionally restricts results to specific ISO 3166-1
///   alpha-2 country codes (e.g. `['ph']`).
/// - Results are additionally **re-sorted client-side by haversine
///   distance from the proximity point**. Mapbox's `proximity` parameter
///   is only a ranking nudge — a famous distant feature of the same name
///   can still out-rank the nearby one. Distance sort makes the bias a
///   guarantee within the returned candidate pool.
/// - [limit] defaults to the Search Box maximum of 10 so there's a healthy
///   candidate pool for the distance sort to work with.
class MapboxGeocoder {
  MapboxGeocoder(this._accessToken);

  final String _accessToken;

  /// Runs a forward search and returns up to [limit] matches. Returns an
  /// empty list on empty input, network failure, or malformed responses —
  /// callers just branch on `isEmpty`.
  Future<List<GeocodedPlace>> search(
    String query, {
    int limit = 10,
    double? longitude,
    double? latitude,
    List<String> types = const [
      'poi',
      'address',
      'place',
      'neighborhood',
      'street',
      'locality',
    ],
    List<String> countryCodes = const <String>[],
    String language = 'en',
  }) async {
    final trimmed = query.trim();
    if (trimmed.isEmpty) return const <GeocodedPlace>[];

    final params = <String, String>{
      'q': trimmed,
      'access_token': _accessToken,
      'limit': limit.toString(),
      'language': language,
      if (types.isNotEmpty) 'types': types.join(','),
    };

    // Explicit coordinate proximity is the *only* supported bias. If the
    // caller can't supply a camera center (e.g. the map controller isn't
    // ready yet), we simply send an unbiased query rather than guessing
    // wrong with IP-based geolocation.
    if (longitude != null && latitude != null) {
      params['proximity'] = '$longitude,$latitude';
    }

    if (countryCodes.isNotEmpty) {
      params['country'] = countryCodes
          .map((c) => c.trim().toLowerCase())
          .where((c) => c.isNotEmpty)
          .join(',');
    }

    final uri = Uri.https(
      'api.mapbox.com',
      '/search/searchbox/v1/forward',
      params,
    );

    final client = HttpClient();
    try {
      final request = await client.getUrl(uri);
      final response = await request.close();
      if (response.statusCode != 200) return const <GeocodedPlace>[];

      final body = await response.transform(utf8.decoder).join();
      final json = jsonDecode(body);
      if (json is! Map<String, dynamic>) return const <GeocodedPlace>[];

      final features = json['features'];
      if (features is! List) return const <GeocodedPlace>[];

      final results = <GeocodedPlace>[];
      for (final feature in features) {
        if (feature is! Map<String, dynamic>) continue;

        final geometry = feature['geometry'];
        if (geometry is! Map<String, dynamic>) continue;
        final coords = geometry['coordinates'];
        if (coords is! List || coords.length < 2) continue;
        final lng = (coords[0] as num).toDouble();
        final lat = (coords[1] as num).toDouble();

        // Search Box v1 puts the human-readable strings under `properties`.
        // `full_address` is the long form ("X Street, City, Region, Country")
        // and falls back to `name` for rough matches like places/regions.
        final props = feature['properties'];
        String? fullAddress;
        String? shortName;
        String? category;
        if (props is Map<String, dynamic>) {
          final rawFullAddress = props['full_address'];
          if (rawFullAddress is String && rawFullAddress.trim().isNotEmpty) {
            fullAddress = rawFullAddress.trim();
          }
          final rawName = props['name'];
          if (rawName is String && rawName.trim().isNotEmpty) {
            shortName = rawName.trim();
          }
          final rawCategory = props['feature_type'];
          if (rawCategory is String && rawCategory.trim().isNotEmpty) {
            category = rawCategory.trim();
          }
        }

        final displayAddress = fullAddress ?? (shortName ?? trimmed);
        final displayTitle = shortName ?? fullAddress ?? trimmed;

        results.add(
          GeocodedPlace(
            latitude: lat,
            longitude: lng,
            title: displayTitle,
            address: displayAddress,
            category: category,
          ),
        );
      }

      // Re-rank by actual distance from the proximity point. Mapbox's own
      // `proximity` bias is only a nudge — without this, a globally famous
      // distant feature of the same name can still out-rank the nearby one.
      if (longitude != null && latitude != null && results.length > 1) {
        results.sort((a, b) {
          final da = _haversineMeters(
            latitude,
            longitude,
            a.latitude,
            a.longitude,
          );
          final db = _haversineMeters(
            latitude,
            longitude,
            b.latitude,
            b.longitude,
          );
          return da.compareTo(db);
        });
      }

      return results;
    } catch (_) {
      return const <GeocodedPlace>[];
    } finally {
      client.close(force: true);
    }
  }

  /// Great-circle distance in meters between two lat/lng points.
  ///
  /// This is used strictly for ranking, so we don't bother with Vincenty
  /// or ellipsoid corrections — spherical-earth haversine is accurate to
  /// within ~0.5% and plenty for "sort nearest results first".
  static double _haversineMeters(
    double lat1,
    double lng1,
    double lat2,
    double lng2,
  ) {
    const earthRadiusMeters = 6371000.0;
    final phi1 = lat1 * math.pi / 180.0;
    final phi2 = lat2 * math.pi / 180.0;
    final dPhi = (lat2 - lat1) * math.pi / 180.0;
    final dLambda = (lng2 - lng1) * math.pi / 180.0;

    final a =
        math.sin(dPhi / 2) * math.sin(dPhi / 2) +
        math.cos(phi1) *
            math.cos(phi2) *
            math.sin(dLambda / 2) *
            math.sin(dLambda / 2);
    final c = 2 * math.atan2(math.sqrt(a), math.sqrt(1 - a));
    return earthRadiusMeters * c;
  }

  /// Convenience: returns the top match (or `null`). Uses the same
  /// proximity/types bias as [search].
  Future<GeocodedPlace?> forward(String query) async {
    final results = await search(query, limit: 1);
    return results.isEmpty ? null : results.first;
  }
}

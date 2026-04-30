import 'dart:convert';
import 'dart:io';

/// Travel profile passed to the Mapbox Directions API.
enum DirectionsProfile { driving, walking }

extension DirectionsProfileApi on DirectionsProfile {
  String get apiValue {
    switch (this) {
      case DirectionsProfile.driving:
        return 'driving';
      case DirectionsProfile.walking:
        return 'walking';
    }
  }

  String get label {
    switch (this) {
      case DirectionsProfile.driving:
        return 'Driving';
      case DirectionsProfile.walking:
        return 'Walking';
    }
  }
}

/// Parsed route geometry returned by [MapboxDirections.route].
///
/// `coordinates` is the GeoJSON LineString in lng/lat order.
class RouteGeometry {
  const RouteGeometry({
    required this.coordinates,
    this.distanceMeters,
    this.durationSeconds,
    this.steps = const <RouteStep>[],
  });

  final List<(double lng, double lat)> coordinates;
  final double? distanceMeters;
  final double? durationSeconds;
  final List<RouteStep> steps;
}

/// A single turn-by-turn instruction from the Directions API.
class RouteStep {
  const RouteStep({
    required this.instruction,
    this.distanceMeters,
    this.durationSeconds,
    this.maneuverType,
    this.maneuverModifier,
    this.maneuverLongitude,
    this.maneuverLatitude,
  });

  final String instruction;
  final double? distanceMeters;
  final double? durationSeconds;
  final String? maneuverType;
  final String? maneuverModifier;
  final double? maneuverLongitude;
  final double? maneuverLatitude;
}

/// Thin wrapper over Mapbox Directions v5 (geojson overview).
///
/// Keeps error handling permissive — callers receive `null` on any failure
/// and can just branch on presence.
class MapboxDirections {
  MapboxDirections(this._accessToken);

  final String _accessToken;

  Future<RouteGeometry?> route({
    required double startLng,
    required double startLat,
    required double endLng,
    required double endLat,
    required DirectionsProfile profile,
  }) async {
    final coords = '$startLng,$startLat;$endLng,$endLat';
    final uri = Uri.https(
      'api.mapbox.com',
      '/directions/v5/mapbox/${profile.apiValue}/$coords',
      {
        'access_token': _accessToken,
        'geometries': 'geojson',
        'overview': 'full',
        'steps': 'true',
      },
    );

    final client = HttpClient();
    try {
      final request = await client.getUrl(uri);
      final response = await request.close();
      if (response.statusCode != 200) return null;

      final body = await response.transform(utf8.decoder).join();
      final json = jsonDecode(body);
      if (json is! Map<String, dynamic>) return null;

      final routes = json['routes'];
      if (routes is! List || routes.isEmpty) return null;

      final route = routes.first;
      if (route is! Map<String, dynamic>) return null;

      final geometry = route['geometry'];
      if (geometry is! Map<String, dynamic>) return null;

      final coordList = geometry['coordinates'];
      if (coordList is! List || coordList.isEmpty) return null;

      final parsed = <(double, double)>[];
      for (final pair in coordList) {
        if (pair is! List || pair.length < 2) continue;
        parsed.add(((pair[0] as num).toDouble(), (pair[1] as num).toDouble()));
      }
      if (parsed.isEmpty) return null;

      final parsedSteps = <RouteStep>[];
      final legs = route['legs'];
      if (legs is List) {
        for (final leg in legs) {
          if (leg is! Map<String, dynamic>) continue;
          final steps = leg['steps'];
          if (steps is! List) continue;
          for (final step in steps) {
            if (step is! Map<String, dynamic>) continue;
            final maneuver = step['maneuver'];
            String? instruction;
            String? maneuverType;
            String? maneuverModifier;
            double? maneuverLongitude;
            double? maneuverLatitude;
            if (maneuver is Map<String, dynamic>) {
              final rawInstruction = maneuver['instruction'];
              if (rawInstruction is String &&
                  rawInstruction.trim().isNotEmpty) {
                instruction = rawInstruction.trim();
              }
              final rawType = maneuver['type'];
              if (rawType is String && rawType.trim().isNotEmpty) {
                maneuverType = rawType.trim();
              }
              final rawModifier = maneuver['modifier'];
              if (rawModifier is String && rawModifier.trim().isNotEmpty) {
                maneuverModifier = rawModifier.trim();
              }
              final rawLocation = maneuver['location'];
              if (rawLocation is List && rawLocation.length >= 2) {
                final rawLng = rawLocation[0];
                final rawLat = rawLocation[1];
                if (rawLng is num && rawLat is num) {
                  maneuverLongitude = rawLng.toDouble();
                  maneuverLatitude = rawLat.toDouble();
                }
              }
            }
            // Driving often omits `maneuver.instruction` but fills banner / voice.
            if (instruction == null || instruction.isEmpty) {
              final banners =
                  step['banner_instructions'] ?? step['bannerInstructions'];
              if (banners is List && banners.isNotEmpty) {
                final first = banners.first;
                if (first is Map<String, dynamic>) {
                  final primary = first['primary'];
                  if (primary is Map<String, dynamic>) {
                    final text = primary['text'];
                    if (text is String && text.trim().isNotEmpty) {
                      instruction = text.trim();
                    }
                  }
                }
              }
            }
            if (instruction == null || instruction.isEmpty) {
              final voice =
                  step['voice_instructions'] ?? step['voiceInstructions'];
              if (voice is List && voice.isNotEmpty) {
                final first = voice.first;
                if (first is Map<String, dynamic>) {
                  final ann = first['announcement'];
                  if (ann is String && ann.trim().isNotEmpty) {
                    instruction = ann.trim();
                  }
                }
              }
            }
            if (instruction == null || instruction.isEmpty) {
              final wayName = step['name'];
              if (wayName is String && wayName.trim().isNotEmpty) {
                instruction = 'Continue on ${wayName.trim()}';
              } else if (maneuverType != null && maneuverType.isNotEmpty) {
                final mod =
                    maneuverModifier != null && maneuverModifier.isNotEmpty
                    ? ' ($maneuverModifier)'
                    : '';
                instruction = '${maneuverType.replaceAll('_', ' ')}$mod';
              } else {
                instruction = 'Continue';
              }
            }
            parsedSteps.add(
              RouteStep(
                instruction: instruction,
                distanceMeters: (step['distance'] as num?)?.toDouble(),
                durationSeconds: (step['duration'] as num?)?.toDouble(),
                maneuverType: maneuverType,
                maneuverModifier: maneuverModifier,
                maneuverLongitude: maneuverLongitude,
                maneuverLatitude: maneuverLatitude,
              ),
            );
          }
        }
      }

      return RouteGeometry(
        coordinates: parsed,
        distanceMeters: (route['distance'] as num?)?.toDouble(),
        durationSeconds: (route['duration'] as num?)?.toDouble(),
        steps: parsedSteps,
      );
    } catch (_) {
      return null;
    } finally {
      client.close(force: true);
    }
  }
}

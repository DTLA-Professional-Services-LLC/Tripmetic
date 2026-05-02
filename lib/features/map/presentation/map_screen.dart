import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
// Prefixed: geolocator exports `Position` and `LocationSettings` that collide
// with mapbox_maps_flutter's own types of the same name.
import 'package:geolocator/geolocator.dart' as geo;
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';

import '../../../core/theme/app_colors.dart';
import '../../../l10n/l10n_helpers.dart';
import '../../trip/application/trip_providers.dart';
import '../../trip/domain/itinerary_event.dart';
import '../../trip/presentation/widgets/add_itinerary_event_sheet.dart';
import '../application/map_focus_provider.dart';
import '../data/mapbox_directions.dart';
import '../data/mapbox_geocoding.dart';
import '../domain/saved_location.dart';

/// Offline map tab (Tripmetic Pro).
///
/// Renders a full-bleed Mapbox map with a draggable bottom sheet that hosts
/// three sections:
///
/// 1. "Offline maps" header + primary CTA to download the current viewport.
/// 2. "Downloaded regions" — existing regions with size + delete actions.
/// 3. "From your itinerary" — per-destination geocode + download, plus a
///    one-tap "Download all" shortcut.
class OfflineMapScreen extends ConsumerStatefulWidget {
  const OfflineMapScreen({super.key});

  @override
  ConsumerState<OfflineMapScreen> createState() => _OfflineMapScreenState();
}

class _OfflineMapScreenState extends ConsumerState<OfflineMapScreen> {
  // REPLACE THIS BEFORE RUNNING
  String publicToken =
      "pk.eyJ1IjoiZHRsYXBybyIsImEiOiJjbW84YmNoMXkwZnBzMm9uNTM1djkzcXpnIn0.Nt002rr9FLmn6eMEbqGPzA";

  // Kept in one place so the live map and the offline tileset stay in sync.
  static const String _styleUri = MapboxStyles.DARK;

  // Stable id + prefix so re-downloading the same region updates rather than
  // duplicates, and trip-destination regions don't collide with each other.
  static const String _currentRegionId = 'tripmetic-current-region';
  static const String _itineraryRegionPrefix = 'tripmetic-itinerary-';

  // Tile zoom range to persist for offline use. 16 is a reasonable ceiling
  // for walking/driving navigation without blowing up storage.
  static const int _minZoom = 0;
  static const int _maxZoom = 16;

  // ~5 km half-extent around a geocoded itinerary point (degrees).
  static const double _itineraryBoxHalfWidthDeg = 0.045;

  bool _mapboxReady = false;
  MapboxMap? _mapboxMap;
  late final MapboxGeocoder _geocoder = MapboxGeocoder(publicToken);
  late final MapboxDirections _directions = MapboxDirections(publicToken);

  /// Filled once `Geolocator.getCurrentPosition()` resolves. Kept around so
  /// the camera centering can happen regardless of which resolves first:
  /// the map controller or the device location.
  geo.Position? _pendingDeviceLocation;

  /// One-shot guard — we only auto-center on the device location once per
  /// screen lifetime. Any subsequent user pan / search flyTo is respected.
  bool _cameraCenteredOnDevice = false;

  // Search-bar state.
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocus = FocusNode();
  bool _isSearching = false;

  /// Typeahead results shown in the dropdown below the search bar.
  List<GeocodedPlace> _suggestions = const <GeocodedPlace>[];
  Timer? _searchDebounce;

  /// Last successful search result — drives the contextual action strip that
  /// offers "Save offline" / "Add to trip" after a flyTo.
  GeocodedPlace? _lastSearchedPlace;

  // Routing state.
  DirectionsProfile _travelProfile = DirectionsProfile.driving;
  PolylineAnnotationManager? _polylineManager;
  PointAnnotationManager? _pointAnnotationManager;
  bool _isRouting = false;
  List<RouteStep> _routeSteps = const <RouteStep>[];
  double? _routeDistanceMeters;
  double? _routeDurationSeconds;
  int? _selectedRouteStepIndex;
  bool _isNavigationMode = false;
  bool _isNavigationBooting = false;
  StreamSubscription<geo.Position>? _navigationSubscription;

  // Route polyline styling — Tripmetic uses gold for brand, so the route
  // itself uses a high-contrast Mapbox-style blue for route visibility.
  static const int _routeLineColor = 0xFF1E88E5; // Material Blue 600
  static const int _routeLineBorderColor = 0xFF0D47A1; // Material Blue 900

  // Stable prefix for search-driven offline regions.
  static const String _searchRegionPrefix = 'tripmetic-search-';

  // Single job at a time — itinerary "download all" runs jobs sequentially.
  bool _isDownloading = false;
  double _downloadProgress = 0.0;
  String _downloadLabel = '';

  // Region inventory state.
  bool _regionsLoading = false;
  List<TileRegion> _regions = const <TileRegion>[];
  final Set<String> _deletingRegionIds = <String>{};

  // Cached offline infrastructure — initialized lazily on first use and
  // reused across downloads so we don't reopen the native handles each time.
  OfflineManager? _offlineManager;
  TileStore? _tileStore;

  // ---------------------------------------------------------------------------
  // Lifecycle
  // ---------------------------------------------------------------------------

  @override
  void initState() {
    super.initState();
    _initializeMapbox();
    // Fire device-location acquisition in parallel with Mapbox init so
    // neither blocks the other. Whichever finishes last applies the
    // camera move in `_applyDeviceLocationToCamera()`.
    _acquireDeviceLocation();
  }

  @override
  void dispose() {
    _searchDebounce?.cancel();
    _navigationSubscription?.cancel();
    _searchController.dispose();
    _searchFocus.dispose();
    super.dispose();
  }

  Future<void> _initializeMapbox() async {
    // The access token must be set before the first MapWidget frame is built.
    MapboxOptions.setAccessToken(publicToken);
    if (!mounted) return;
    setState(() => _mapboxReady = true);

    // Seed the inventory on entry so the sheet is never empty on first paint.
    await _refreshRegions();
  }

  void _onMapCreated(MapboxMap mapboxMap) {
    _mapboxMap = mapboxMap;
    // If the device location already resolved before the map was ready,
    // apply it now. Otherwise `_acquireDeviceLocation()` will do it when
    // `Geolocator.getCurrentPosition()` returns.
    if (_pendingDeviceLocation != null && !_cameraCenteredOnDevice) {
      _applyDeviceLocationToCamera();
    }
    unawaited(_loadStoredMarkers());
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) _tryConsumePendingMapFocus();
    });
  }

  /// Checks services + permissions, fetches the user's current GPS fix,
  /// and schedules a camera centering on it. All failure modes (service
  /// off, permission denied, timeout, device has no GPS) silently fall
  /// through — the map keeps its default view.
  Future<void> _acquireDeviceLocation() async {
    try {
      if (!await geo.Geolocator.isLocationServiceEnabled()) return;

      var permission = await geo.Geolocator.checkPermission();
      if (permission == geo.LocationPermission.denied) {
        permission = await geo.Geolocator.requestPermission();
      }
      if (permission != geo.LocationPermission.whileInUse &&
          permission != geo.LocationPermission.always) {
        return;
      }

      final position = await geo.Geolocator.getCurrentPosition(
        locationSettings: const geo.LocationSettings(
          // Medium accuracy is plenty for a city-scale initial centering
          // and returns faster than `high`. The Mapbox proximity bias
          // only needs a few-km precision to work correctly.
          accuracy: geo.LocationAccuracy.medium,
          timeLimit: Duration(seconds: 8),
        ),
      );

      if (!mounted) return;
      _pendingDeviceLocation = position;

      // Map controller might not be ready yet; `_onMapCreated` will pick
      // this up on first callback in that case.
      if (_mapboxMap != null && !_cameraCenteredOnDevice) {
        await _applyDeviceLocationToCamera();
      }
    } catch (_) {
      // Opportunistic — stay on the default view on any failure.
    }
  }

  /// Instantly moves the camera to the user's resolved position at a
  /// city-scale zoom. Uses `flyTo` with a quick animation so the transition
  /// is still perceptible to the user but feels immediate.
  Future<void> _applyDeviceLocationToCamera() async {
    final mapboxMap = _mapboxMap;
    final position = _pendingDeviceLocation;
    if (mapboxMap == null || position == null || _cameraCenteredOnDevice) {
      return;
    }
    _cameraCenteredOnDevice = true;

    try {
      await mapboxMap.flyTo(
        CameraOptions(
          center: Point(
            coordinates: Position(position.longitude, position.latitude),
          ),
          zoom: 13,
        ),
        MapAnimationOptions(duration: 600),
      );
    } catch (_) {
      // Camera move can fail on hot-restart boundary; keep quiet.
    }
  }

  Future<(OfflineManager, TileStore)> _ensureOfflineHandles() async {
    _offlineManager ??= await OfflineManager.create();
    _tileStore ??= await TileStore.createDefault();
    return (_offlineManager!, _tileStore!);
  }

  // ---------------------------------------------------------------------------
  // Region inventory
  // ---------------------------------------------------------------------------

  Future<void> _refreshRegions() async {
    if (!mounted) return;
    setState(() => _regionsLoading = true);
    try {
      final (_, tileStore) = await _ensureOfflineHandles();
      final regions = await tileStore.allTileRegions();
      if (!mounted) return;
      setState(() {
        _regions = regions;
        _regionsLoading = false;
      });
    } catch (error) {
      if (!mounted) return;
      setState(() => _regionsLoading = false);
      _showSnack(context.l10n.mapSnackLoadRegionsFailed('$error'));
    }
  }

  Future<void> _deleteRegion(TileRegion region) async {
    if (_deletingRegionIds.contains(region.id)) return;
    setState(() => _deletingRegionIds.add(region.id));
    try {
      final (_, tileStore) = await _ensureOfflineHandles();
      await tileStore.removeRegion(region.id);
      if (!mounted) return;
      final l10n = context.l10n;
      _showSnack(l10n.mapSnackRemovedRegion(_displayName(l10n, region)));
      await _refreshRegions();
    } catch (error) {
      if (!mounted) return;
      _showSnack(context.l10n.mapSnackDeleteFailed('$error'));
    } finally {
      if (mounted) {
        setState(() => _deletingRegionIds.remove(region.id));
      }
    }
  }

  // ---------------------------------------------------------------------------
  // Downloads
  // ---------------------------------------------------------------------------

  /// Downloads the tile region for whatever the camera is currently framing.
  Future<void> _downloadCurrentRegion() async {
    if (_isDownloading) return;
    final mapboxMap = _mapboxMap;
    if (mapboxMap == null) {
      _showSnack(context.l10n.mapSnackMapNotReady);
      return;
    }

    setState(() {
      _isDownloading = true;
      _downloadProgress = 0.0;
      _downloadLabel = context.l10n.mapDownloadingRegion;
    });

    try {
      final cameraState = await mapboxMap.getCameraState();
      final bounds = await mapboxMap.coordinateBoundsForCamera(
        CameraOptions(
          center: cameraState.center,
          zoom: cameraState.zoom,
          bearing: cameraState.bearing,
          pitch: cameraState.pitch,
        ),
      );

      final sw = bounds.southwest.coordinates;
      final ne = bounds.northeast.coordinates;

      await _downloadRegionInternal(
        regionId: _currentRegionId,
        displayName: context.l10n.mapDisplayCurrentViewport,
        swLng: sw.lng.toDouble(),
        swLat: sw.lat.toDouble(),
        neLng: ne.lng.toDouble(),
        neLat: ne.lat.toDouble(),
      );

      if (!mounted) return;
      _showSnack(context.l10n.mapSnackRegionDownloaded);
      await _refreshRegions();
    } catch (error) {
      if (!mounted) return;
      _showSnack(context.l10n.mapSnackDownloadFailed('$error'));
    } finally {
      if (mounted) setState(() => _isDownloading = false);
    }
  }

  /// Geocodes an itinerary event's location string, pans the map, and
  /// downloads a ~5 km box around the resolved point.
  Future<void> _downloadItineraryEvent(ItineraryEvent event) async {
    if (_isDownloading) return;
    final query = event.displayLocation;
    final hasCoords = event.latitude != null && event.longitude != null;
    if (query.isEmpty && !hasCoords) {
      _showSnack(
        context.l10n.mapSnackEventNoLocation(event.displayTitle),
      );
      return;
    }

    final l10n = context.l10n;
    setState(() {
      _isDownloading = true;
      _downloadProgress = 0.0;
      _downloadLabel = hasCoords
          ? l10n.mapDownloadingTitle(_shorten(event.displayTitle))
          : l10n.mapLocatingQuery(_shorten(query));
    });

    try {
      double lat;
      double lng;

      if (hasCoords) {
        lat = event.latitude!;
        lng = event.longitude!;
      } else {
        final place = await _geocoder.forward(query);
        if (!mounted) return;

        if (place == null) {
          _showSnack(context.l10n.mapSnackCouldNotFind(query));
          return;
        }
        lat = place.latitude;
        lng = place.longitude;
      }

      if (!mounted) return;

      setState(() {
        _downloadLabel = context.l10n.mapDownloadingTitle(
          _shorten(event.displayTitle),
        );
      });

      // Pan the live map so the user sees what's being saved.
      final fly = _mapboxMap?.flyTo(
        CameraOptions(
          center: Point(coordinates: Position(lng, lat)),
          zoom: 11,
        ),
        MapAnimationOptions(duration: 800),
      );
      if (fly != null) unawaited(fly);

      await _downloadRegionInternal(
        regionId: _itineraryRegionId(event),
        displayName: event.displayTitle,
        swLng: lng - _itineraryBoxHalfWidthDeg,
        swLat: lat - _itineraryBoxHalfWidthDeg,
        neLng: lng + _itineraryBoxHalfWidthDeg,
        neLat: lat + _itineraryBoxHalfWidthDeg,
      );

      if (!mounted) return;
      _showSnack(context.l10n.mapSnackDownloadedEvent(event.displayTitle));
      await _refreshRegions();
    } catch (error) {
      if (!mounted) return;
      _showSnack(context.l10n.mapSnackDownloadFailed('$error'));
    } finally {
      if (mounted) setState(() => _isDownloading = false);
    }
  }

  /// Downloads every itinerary event that has a non-empty location, one at a
  /// time. Individual failures surface via per-call snackbars but don't halt
  /// the batch — we try to save as much as possible.
  Future<void> _downloadAllItinerary(List<ItineraryEvent> events) async {
    if (_isDownloading) return;
    final candidates = events
        .where(
          (e) =>
              e.displayLocation.isNotEmpty ||
              (e.latitude != null && e.longitude != null),
        )
        .toList(growable: false);
    if (candidates.isEmpty) {
      _showSnack(context.l10n.mapSnackNoItineraryLocations);
      return;
    }

    for (var i = 0; i < candidates.length; i++) {
      await _downloadItineraryEvent(candidates[i]);
      if (!mounted) return;
    }

    if (!mounted) return;
    _showSnack(
      context.l10n.mapSnackFinishedBatch('${candidates.length}'),
    );
  }

  /// Core download routine: style pack + tile region for the given bounding
  /// box. Does **not** touch [_isDownloading] — that's the caller's
  /// responsibility so geocoding + batching UX stays coherent.
  Future<void> _downloadRegionInternal({
    required String regionId,
    required String displayName,
    required double swLng,
    required double swLat,
    required double neLng,
    required double neLat,
  }) async {
    final (offlineManager, tileStore) = await _ensureOfflineHandles();

    final regionPolygon = Polygon(
      coordinates: [
        [
          Position(swLng, swLat),
          Position(neLng, swLat),
          Position(neLng, neLat),
          Position(swLng, neLat),
          Position(swLng, swLat),
        ],
      ],
    );

    // Style pack — sprites + fonts + style JSON. Small vs. tiles.
    await offlineManager.loadStylePack(
      _styleUri,
      StylePackLoadOptions(
        glyphsRasterizationMode:
            GlyphsRasterizationMode.IDEOGRAPHS_RASTERIZED_LOCALLY,
        metadata: {'tag': 'tripmetic.style'},
        acceptExpired: true,
      ),
      (_) {},
    );

    // Tile region — the actual basemap tiles.
    final tilesetDescriptorOptions = TilesetDescriptorOptions(
      styleURI: _styleUri,
      minZoom: _minZoom,
      maxZoom: _maxZoom,
    );

    await tileStore.loadTileRegion(
      regionId,
      TileRegionLoadOptions(
        geometry: regionPolygon.toJson(),
        descriptorsOptions: [tilesetDescriptorOptions],
        metadata: {'tripmetic.name': displayName},
        acceptExpired: true,
        networkRestriction: NetworkRestriction.NONE,
      ),
      (progress) {
        if (!mounted) return;
        final total = progress.requiredResourceCount;
        final done = progress.completedResourceCount;
        if (total > 0) {
          setState(() {
            _downloadProgress = (done / total).clamp(0.0, 1.0).toDouble();
          });
        }
      },
    );
  }

  // ---------------------------------------------------------------------------
  // Search
  // ---------------------------------------------------------------------------

  /// Called on every keystroke. Debounces by 300 ms before firing a geocode,
  /// which populates the dropdown via [_fetchSuggestions].
  void _onSearchChanged(String raw) {
    final query = raw.trim();
    _searchDebounce?.cancel();

    // Too short to be worth a round-trip; clear any stale dropdown.
    if (query.length < 2) {
      if (_suggestions.isNotEmpty || _isSearching) {
        setState(() {
          _suggestions = const <GeocodedPlace>[];
          _isSearching = false;
        });
      }
      return;
    }

    _searchDebounce = Timer(const Duration(milliseconds: 300), () {
      _fetchSuggestions(query);
    });
  }

  Future<void> _fetchSuggestions(String query) async {
    if (!mounted) return;
    setState(() => _isSearching = true);
    try {
      // Bias every request to whatever the user is currently looking at on
      // the map — if they've panned to Tokyo, Tokyo wins; panned to Manila,
      // Manila wins. Phone GPS / IP are deliberately NOT used.
      final (lng, lat) = await _currentCameraCenter();
      final results = await _geocoder.search(
        query,
        longitude: lng,
        latitude: lat,
      );
      if (!mounted) return;
      setState(() {
        _suggestions = results;
        _isSearching = false;
      });
    } catch (_) {
      if (!mounted) return;
      setState(() => _isSearching = false);
    }
  }

  /// Snapshots the map's current camera center for use as geocoding
  /// proximity. Returns `(null, null)` only if the controller isn't ready
  /// yet — in which case the search runs unbiased.
  Future<(double?, double?)> _currentCameraCenter() async {
    final mapboxMap = _mapboxMap;
    if (mapboxMap == null) return (null, null);
    try {
      final cameraState = await mapboxMap.getCameraState();
      final center = cameraState.center.coordinates;
      return (center.lng.toDouble(), center.lat.toDouble());
    } catch (_) {
      return (null, null);
    }
  }

  /// Enter-key submission from the keyboard. If the dropdown already has
  /// results, select the top one; otherwise run a synchronous search first.
  Future<void> _onSearchSubmitted(String raw) async {
    final query = raw.trim();
    if (query.isEmpty) return;

    _searchDebounce?.cancel();
    _searchFocus.unfocus();

    if (_suggestions.isNotEmpty) {
      await _selectPlace(_suggestions.first);
      return;
    }

    setState(() => _isSearching = true);
    try {
      final (lng, lat) = await _currentCameraCenter();
      final results = await _geocoder.search(
        query,
        limit: 10,
        longitude: lng,
        latitude: lat,
      );
      if (!mounted) return;

      if (results.isEmpty) {
        setState(() => _isSearching = false);
        _showSnack(context.l10n.mapSnackCouldNotFind(query));
        return;
      }

      setState(() => _isSearching = false);
      await _selectPlace(results.first);
    } catch (error) {
      if (!mounted) return;
      setState(() => _isSearching = false);
      _showSnack(context.l10n.mapSnackSearchFailed('$error'));
    }
  }

  /// Called when the user taps a row in the dropdown.
  Future<void> _pickSuggestion(GeocodedPlace place) async {
    _searchDebounce?.cancel();
    _searchFocus.unfocus();
    await _selectPlace(place);
  }

  /// Central selection flow: pin the place, fill the search field with the
  /// full address, clear any previous route, fetch the new route, draw it,
  /// and fit the camera to its bounds. Falls back to a plain flyTo when the
  /// Directions API returns nothing routable.
  Future<void> _selectPlace(GeocodedPlace place) async {
    final mapboxMap = _mapboxMap;
    if (mapboxMap == null) {
      _showSnack(context.l10n.mapSnackMapNotReady);
      return;
    }

    setState(() {
      _lastSearchedPlace = place;
      _suggestions = const <GeocodedPlace>[];
      _isRouting = true;
    });
    await _stopNavigationMode(silent: true);

    // Put the full address into the input so the user can see what was
    // selected and edit it for a refined search.
    _searchController.value = TextEditingValue(
      text: place.title,
      selection: TextSelection.collapsed(offset: place.title.length),
    );

    try {
      final cameraState = await mapboxMap.getCameraState();
      final center = cameraState.center.coordinates;
      final startLng = center.lng.toDouble();
      final startLat = center.lat.toDouble();

      // Always clear the previous route before drawing the new one.
      await _clearRoute();

      final route = await _directions.route(
        startLng: startLng,
        startLat: startLat,
        endLng: place.longitude,
        endLat: place.latitude,
        profile: _travelProfile,
      );

      if (!mounted) return;

      if (route == null || route.coordinates.length < 2) {
        // No route found — just fly to the destination so the user still
        // sees where the place is.
        setState(() {
          _routeSteps = const <RouteStep>[];
          _routeDistanceMeters = null;
          _routeDurationSeconds = null;
          _selectedRouteStepIndex = null;
        });
        await mapboxMap.flyTo(
          CameraOptions(
            center: Point(
              coordinates: Position(place.longitude, place.latitude),
            ),
            zoom: 11,
          ),
          MapAnimationOptions(duration: 1200),
        );
        _showSnack(context.l10n.mapSnackNoRoute);
        return;
      }

      setState(() {
        _routeSteps = route.steps;
        _routeDistanceMeters = route.distanceMeters;
        _routeDurationSeconds = route.durationSeconds;
        _selectedRouteStepIndex = null;
      });
      await _drawRoute(route);
      await _fitCameraToRoute(route);
    } catch (error) {
      if (!mounted) return;
      _showSnack(context.l10n.mapSnackRoutingFailed('$error'));
    } finally {
      if (mounted) setState(() => _isRouting = false);
    }
  }

  void _onProfileChanged(DirectionsProfile profile) {
    if (profile == _travelProfile) return;
    setState(() => _travelProfile = profile);
    // If we already have a selected destination, re-route under the new
    // profile so the user sees the change take effect immediately.
    final place = _lastSearchedPlace;
    if (place != null) _selectPlace(place);
  }

  Future<void> _clearRoute() async {
    await _stopNavigationMode(silent: true);
    if (mounted) {
      setState(() {
        _routeSteps = const <RouteStep>[];
        _routeDistanceMeters = null;
        _routeDurationSeconds = null;
        _selectedRouteStepIndex = null;
      });
    }
    final manager = _polylineManager;
    if (manager == null) return;
    try {
      await manager.deleteAll();
    } catch (_) {
      // Manager might have been torn down; ignore.
    }
  }

  /// User-facing reset: removes polyline, turn-by-turn, and live navigation.
  Future<void> _clearRouteAndGuidance() async {
    await _clearRoute();
    if (mounted) {
      _showSnack(context.l10n.mapSnackRouteCleared);
    }
  }

  Future<void> _drawRoute(RouteGeometry route) async {
    final mapboxMap = _mapboxMap;
    if (mapboxMap == null) return;

    _polylineManager ??= await mapboxMap.annotations
        .createPolylineAnnotationManager();

    final manager = _polylineManager!;
    final positions = [
      for (final (lng, lat) in route.coordinates) Position(lng, lat),
    ];

    await manager.create(
      PolylineAnnotationOptions(
        geometry: LineString(coordinates: positions),
        lineColor: _routeLineColor,
        lineBorderColor: _routeLineBorderColor,
        lineBorderWidth: 1.5,
        lineWidth: 6.0,
        lineJoin: LineJoin.ROUND,
        lineOpacity: 0.95,
      ),
    );
  }

  Future<void> _fitCameraToRoute(RouteGeometry route) async {
    final mapboxMap = _mapboxMap;
    if (mapboxMap == null || route.coordinates.isEmpty) return;

    var minLng = double.infinity;
    var maxLng = double.negativeInfinity;
    var minLat = double.infinity;
    var maxLat = double.negativeInfinity;
    for (final (lng, lat) in route.coordinates) {
      if (lng < minLng) minLng = lng;
      if (lng > maxLng) maxLng = lng;
      if (lat < minLat) minLat = lat;
      if (lat > maxLat) maxLat = lat;
    }

    final bounds = CoordinateBounds(
      southwest: Point(coordinates: Position(minLng, minLat)),
      northeast: Point(coordinates: Position(maxLng, maxLat)),
      infiniteBounds: false,
    );

    // Leave room at top for the search bar and at bottom for the sheet
    // handle so the route is fully visible.
    final camera = await mapboxMap.cameraForCoordinateBounds(
      bounds,
      MbxEdgeInsets(top: 150, left: 50, bottom: 120, right: 50),
      null,
      null,
      null,
      null,
    );

    await mapboxMap.flyTo(camera, MapAnimationOptions(duration: 1200));
  }

  Future<void> _focusRouteStep(int index, RouteStep step) async {
    final mapboxMap = _mapboxMap;
    if (mapboxMap == null) return;
    final lng = step.maneuverLongitude;
    final lat = step.maneuverLatitude;
    if (lng == null || lat == null) {
      _showSnack(context.l10n.mapSnackNoManeuver);
      return;
    }
    setState(() => _selectedRouteStepIndex = index);
    try {
      await mapboxMap.flyTo(
        CameraOptions(center: Point(coordinates: Position(lng, lat)), zoom: 16),
        MapAnimationOptions(duration: 650),
      );
    } catch (_) {
      // Best-effort focus only.
    }
  }

  Future<void> _startNavigationMode() async {
    if (_isNavigationMode || _isNavigationBooting || _routeSteps.isEmpty) {
      return;
    }
    setState(() => _isNavigationBooting = true);
    try {
      if (!await geo.Geolocator.isLocationServiceEnabled()) {
        _showSnack(context.l10n.mapSnackLocationOff);
        return;
      }
      var permission = await geo.Geolocator.checkPermission();
      if (permission == geo.LocationPermission.denied) {
        permission = await geo.Geolocator.requestPermission();
      }
      if (permission != geo.LocationPermission.whileInUse &&
          permission != geo.LocationPermission.always) {
        _showSnack(context.l10n.mapSnackLocationPermission);
        return;
      }

      await _navigationSubscription?.cancel();
      _navigationSubscription = geo.Geolocator.getPositionStream(
        locationSettings: const geo.LocationSettings(
          accuracy: geo.LocationAccuracy.best,
          distanceFilter: 5,
        ),
      ).listen(_onNavigationPosition);

      if (!mounted) return;
      setState(() {
        _isNavigationMode = true;
        _selectedRouteStepIndex ??= 0;
      });

      // Prime with one immediate fix so navigation starts instantly.
      final current = await geo.Geolocator.getCurrentPosition(
        locationSettings: const geo.LocationSettings(
          accuracy: geo.LocationAccuracy.best,
          timeLimit: Duration(seconds: 8),
        ),
      );
      await _onNavigationPosition(current);
    } catch (_) {
      _showSnack(context.l10n.mapSnackNavStartFail);
    } finally {
      if (mounted) setState(() => _isNavigationBooting = false);
    }
  }

  Future<void> _stopNavigationMode({bool silent = false}) async {
    await _navigationSubscription?.cancel();
    _navigationSubscription = null;
    if (!mounted) return;
    setState(() {
      _isNavigationMode = false;
      _isNavigationBooting = false;
    });
    if (!silent) {
      _showSnack(context.l10n.mapSnackNavStopped);
    }
  }

  Future<void> _onNavigationPosition(geo.Position position) async {
    if (!_isNavigationMode) return;

    if (_routeSteps.isEmpty) return;
    final idx = _selectedRouteStepIndex ?? 0;
    if (idx < 0 || idx >= _routeSteps.length) return;
    final currentStep = _routeSteps[idx];
    final lng = currentStep.maneuverLongitude;
    final lat = currentStep.maneuverLatitude;
    if (lng == null || lat == null) return;

    final metersAway = _haversineMeters(
      position.latitude,
      position.longitude,
      lat,
      lng,
    );
    // Advance when user reaches the maneuver vicinity.
    if (metersAway <= 35) {
      final next = idx + 1;
      if (next >= _routeSteps.length) {
        if (mounted) {
          setState(() => _selectedRouteStepIndex = _routeSteps.length - 1);
          _showSnack(context.l10n.mapSnackArrived);
        }
        await _stopNavigationMode(silent: true);
        return;
      }
      if (mounted) {
        setState(() => _selectedRouteStepIndex = next);
      }
    }
  }

  /// Downloads a ~5 km box around the last search result.
  Future<void> _downloadSearchedArea() async {
    final place = _lastSearchedPlace;
    if (place == null || _isDownloading) return;

    setState(() {
      _isDownloading = true;
      _downloadProgress = 0.0;
      _downloadLabel = context.l10n.mapDownloadingTitle(_shorten(place.title));
    });

    try {
      await _downloadRegionInternal(
        regionId: _searchRegionId(place),
        displayName: place.title,
        swLng: place.longitude - _itineraryBoxHalfWidthDeg,
        swLat: place.latitude - _itineraryBoxHalfWidthDeg,
        neLng: place.longitude + _itineraryBoxHalfWidthDeg,
        neLat: place.latitude + _itineraryBoxHalfWidthDeg,
      );

      if (!mounted) return;
      _showSnack(context.l10n.mapSnackDownloadedEvent(_shorten(place.title)));
      await _refreshRegions();
    } catch (error) {
      if (!mounted) return;
      _showSnack(context.l10n.mapSnackDownloadFailed('$error'));
    } finally {
      if (mounted) setState(() => _isDownloading = false);
    }
  }

  /// Saves the current search pin to Hive and refreshes Mapbox point markers.
  Future<void> _saveSearchToOfflineMarks() async {
    final place = _lastSearchedPlace;
    if (place == null) return;

    final category = await _pickCategoryForOfflineMark();
    if (!mounted || category == null) return;

    final id =
        '${place.longitude}_${place.latitude}_${DateTime.now().millisecondsSinceEpoch}';
    final loc = SavedLocation(
      id: id,
      name: place.title,
      latitude: place.latitude,
      longitude: place.longitude,
      category: category,
    );

    final box = Hive.box<SavedLocation>(kSavedLocationsBoxName);
    await box.put(id, loc);

    if (!mounted) return;
    _showSnack(context.l10n.mapSnackAddedOfflineMark(place.title));
    await _loadStoredMarkers();
  }

  Future<void> _addSearchToItinerary() async {
    final place = _lastSearchedPlace;
    if (place == null) return;
    await showAddItineraryEventSheet(
      context,
      ref,
      initialTitle: place.title,
      initialLocation:
          place.address.isNotEmpty ? place.address : place.title,
      initialLatitude: place.latitude,
      initialLongitude: place.longitude,
    );
  }

  Future<void> _deleteSavedMark(String id) async {
    if (!Hive.isBoxOpen(kSavedLocationsBoxName)) return;
    final box = Hive.box<SavedLocation>(kSavedLocationsBoxName);
    await box.delete(id);
    if (!mounted) return;
    _showSnack(context.l10n.mapSnackRemovedPin);
    await _loadStoredMarkers();
  }

  void _tryConsumePendingMapFocus() {
    final intent = ref.read(mapFocusIntentProvider);
    if (intent == null || _mapboxMap == null) return;
    unawaited(_flyToAndClearFocus(intent));
  }

  Future<void> _flyToAndClearFocus(MapFocusIntent intent) async {
    final map = _mapboxMap;
    if (map == null) return;
    try {
      await map.flyTo(
        CameraOptions(
          center: Point(
            coordinates: Position(intent.longitude, intent.latitude),
          ),
          zoom: 15,
        ),
        MapAnimationOptions(duration: 1000),
      );
    } catch (_) {}
    if (!mounted) return;
    ref.read(mapFocusIntentProvider.notifier).state = null;
  }

  Future<String?> _pickCategoryForOfflineMark() {
    final l10n = context.l10n;
    final choices = <(String, String)>[
      ('Hotel', l10n.mapMarkHotel),
      ('Food', l10n.mapMarkFood),
      ('Landmark', l10n.mapMarkLandmark),
      ('Other', l10n.mapMarkOther),
    ];
    return showModalBottomSheet<String>(
      context: context,
      backgroundColor: AppColors.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (ctx) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 14, 16, 8),
              child: Text(
                l10n.mapMarkCategoryTitle,
                style: const TextStyle(
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
              child: Text(
                l10n.mapMarkCategoryBody,
                style: const TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: 12.5,
                ),
              ),
            ),
            for (final c in choices)
              ListTile(
                title: Text(
                  c.$2,
                  style: const TextStyle(color: AppColors.textPrimary),
                ),
                onTap: () => Navigator.pop(ctx, c.$1),
              ),
          ],
        ),
      ),
    );
  }

  /// Loads [SavedLocation]s from Hive and draws them with the point annotation API.
  Future<void> _loadStoredMarkers() async {
    final mapboxMap = _mapboxMap;
    if (mapboxMap == null) return;
    if (!Hive.isBoxOpen(kSavedLocationsBoxName)) return;

    final box = Hive.box<SavedLocation>(kSavedLocationsBoxName);

    try {
      _pointAnnotationManager ??= await mapboxMap.annotations
          .createPointAnnotationManager();
      final mgr = _pointAnnotationManager!;
      await mgr.deleteAll();
      await mgr.setTextAllowOverlap(true);
      await mgr.setIconAllowOverlap(true);

      final options = <PointAnnotationOptions>[];
      for (final loc in box.values) {
        options.add(
          PointAnnotationOptions(
            geometry: Point(coordinates: Position(loc.longitude, loc.latitude)),
            textField: _offlineMarkLabel(loc),
            textSize: 11,
            textAnchor: TextAnchor.CENTER,
            textColor: 0xFFD4AF37,
            textHaloColor: 0xFF0B132B,
            textHaloWidth: 1.5,
          ),
        );
      }
      if (options.isEmpty) return;
      await mgr.createMulti(options);
    } catch (_) {
      // Map style or annotation layer not ready; ignore for robustness.
    }
  }

  String _offlineMarkLabel(SavedLocation loc) {
    final n = loc.name.trim();
    if (n.isEmpty) return loc.category;
    if (n.length > 24) return '${n.substring(0, 23)}…';
    return n;
  }

  /// Deterministic ID for search-driven regions so re-downloading the same
  /// place updates the existing region rather than creating a new one.
  /// Rounds to ~100 m to absorb tiny float noise in repeated geocodes.
  String _searchRegionId(GeocodedPlace place) {
    String fmt(double v) =>
        v.toStringAsFixed(3).replaceAll('-', 'n').replaceAll('.', 'p');
    return '$_searchRegionPrefix${fmt(place.latitude)}_${fmt(place.longitude)}';
  }

  // ---------------------------------------------------------------------------
  // Helpers
  // ---------------------------------------------------------------------------

  String _itineraryRegionId(ItineraryEvent event) =>
      '$_itineraryRegionPrefix${event.id}';

  String _displayName(AppLocalizations l10n, TileRegion region) {
    if (region.id == _currentRegionId) return l10n.mapDisplayCurrentViewport;
    if (region.id.startsWith(_itineraryRegionPrefix)) {
      final suffix = region.id.substring(_itineraryRegionPrefix.length);
      final events = ref.read(itineraryProvider);
      for (final e in events) {
        if (e.id == suffix) return e.displayTitle;
      }
      return l10n.mapDisplayTripDestination;
    }
    if (region.id.startsWith(_searchRegionPrefix)) {
      // If this region corresponds to the currently-pinned search, prefer its
      // human-readable place name; otherwise fall back to a generic label.
      final place = _lastSearchedPlace;
      if (place != null && _searchRegionId(place) == region.id) {
        return place.title;
      }
      return l10n.mapDisplaySavedSearch;
    }
    return region.id;
  }

  String _shorten(String s, {int max = 28}) {
    if (s.length <= max) return s;
    return '${s.substring(0, max - 1).trimRight()}…';
  }

  String _formatBytes(int bytes) {
    if (bytes <= 0) return '0 B';
    const units = ['B', 'KB', 'MB', 'GB'];
    final i = (math.log(bytes) / math.log(1024)).floor().clamp(0, 3);
    final value = bytes / math.pow(1024, i);
    return '${value.toStringAsFixed(value >= 10 || i == 0 ? 0 : 1)} ${units[i]}';
  }

  double _haversineMeters(double lat1, double lng1, double lat2, double lng2) {
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

  String _formatStepDistance(double? meters) {
    if (meters == null) return '—';
    if (meters >= 1000) return '${(meters / 1000).toStringAsFixed(1)} km';
    return '${meters.round()} m';
  }

  void _showSnack(String message) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          backgroundColor: AppColors.surfaceContainer,
          content: Text(
            message,
            style: const TextStyle(color: AppColors.textPrimary),
          ),
        ),
      );
  }

  List<ItineraryEvent> _dedupeByLocation(List<ItineraryEvent> events) {
    final seen = <String>{};
    final out = <ItineraryEvent>[];
    for (final e in events) {
      final key = e.displayLocation.toLowerCase();
      if (key.isEmpty) continue;
      if (seen.add(key)) out.add(e);
    }
    return out;
  }

  // ---------------------------------------------------------------------------
  // Build
  // ---------------------------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    ref.listen<MapFocusIntent?>(mapFocusIntentProvider, (prev, next) {
      if (next != null) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (mounted) _tryConsumePendingMapFocus();
        });
      }
    });

    final itinerary = ref.watch(itineraryProvider);
    final uniqueItinerary = _dedupeByLocation(itinerary);
    final hasRouteSteps = _routeSteps.isNotEmpty;
    final nextStepIndex = hasRouteSteps
        ? math.min(
            math.max(_selectedRouteStepIndex ?? 0, 0),
            _routeSteps.length - 1,
          )
        : 0;
    final nextStep = (_isNavigationMode && hasRouteSteps)
        ? _routeSteps[nextStepIndex]
        : null;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          Positioned.fill(
            child: _mapboxReady
                ? MapWidget(
                    key: const ValueKey('offline_map_widget'),
                    styleUri: _styleUri,
                    cameraOptions: CameraOptions(
                      center: Point(coordinates: Position(-73.9857, 40.7484)),
                      zoom: 11,
                    ),
                    onMapCreated: _onMapCreated,
                  )
                : const ColoredBox(color: AppColors.background),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: SafeArea(
              bottom: false,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(12, 12, 12, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _MapSearchBar(
                      controller: _searchController,
                      focusNode: _searchFocus,
                      searchHint: context.l10n.mapSearchHint,
                      clearTooltip: context.l10n.mapClearTooltip,
                      isSearching: _isSearching || _isRouting,
                      onSubmitted: _onSearchSubmitted,
                      onChanged: (text) {
                        // Keep the clear button in sync, then debounce the
                        // actual geocode call.
                        setState(() {});
                        _onSearchChanged(text);
                      },
                      onCleared: () => setState(() {
                        _lastSearchedPlace = null;
                        _suggestions = const <GeocodedPlace>[];
                      }),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: _TravelModeToggle(
                        profile: _travelProfile,
                        isBusy: _isRouting,
                        drivingLabel: context.l10n.mapTravelDriving,
                        walkingLabel: context.l10n.mapTravelWalking,
                        onChanged: _onProfileChanged,
                      ),
                    ),
                    if (_suggestions.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: _SearchSuggestions(
                          suggestions: _suggestions,
                          onPick: _pickSuggestion,
                        ),
                      ),
                    if (_lastSearchedPlace != null &&
                        _suggestions.isEmpty &&
                        !_isSearching)
                      Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: _SearchActionsBar(
                          place: _lastSearchedPlace!,
                          isDownloading: _isDownloading,
                          onDownload: _downloadSearchedArea,
                          onAddToItinerary: _addSearchToItinerary,
                          onSavePin: _saveSearchToOfflineMarks,
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
          DraggableScrollableSheet(
            initialChildSize: 0.2,
            minChildSize: 0.1,
            maxChildSize: 0.86,
            snap: true,
            snapSizes: const [0.1, 0.2, 0.86],
            builder: (context, scrollController) {
              return _OfflineSheet(
                scrollController: scrollController,
                isDownloading: _isDownloading,
                downloadProgress: _downloadProgress,
                downloadLabel: _downloadLabel,
                regions: _regions,
                regionsLoading: _regionsLoading,
                deletingRegionIds: _deletingRegionIds,
                onDownloadCurrent: _downloadCurrentRegion,
                onDeleteRegion: _deleteRegion,
                onRefreshRegions: _refreshRegions,
                regionDisplayName: (r) => _displayName(context.l10n, r),
                formatBytes: _formatBytes,
                itinerary: uniqueItinerary,
                onDownloadItineraryEvent: _downloadItineraryEvent,
                onDownloadAllItinerary: () =>
                    _downloadAllItinerary(uniqueItinerary),
                routeSteps: _routeSteps,
                routeDistanceMeters: _routeDistanceMeters,
                routeDurationSeconds: _routeDurationSeconds,
                travelProfile: _travelProfile,
                selectedRouteStepIndex: _selectedRouteStepIndex,
                onTapRouteStep: _focusRouteStep,
                isNavigationMode: _isNavigationMode,
                isNavigationBooting: _isNavigationBooting,
                onStartNavigation: _startNavigationMode,
                onStopNavigation: _stopNavigationMode,
                onClearRoute: _clearRouteAndGuidance,
                onDeleteSavedMark: _deleteSavedMark,
              );
            },
          ),
          if (nextStep != null)
            Positioned(
              left: 12,
              right: 12,
              bottom: 90,
              child: SafeArea(
                top: false,
                child: _NextInstructionChip(
                  instruction: nextStep.instruction,
                  headerLine: context.l10n.mapNextInstruction(
                    '${nextStepIndex + 1}',
                    '${_routeSteps.length}',
                  ),
                  distanceLabel: _formatStepDistance(nextStep.distanceMeters),
                  onTap: () => _focusRouteStep(nextStepIndex, nextStep),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Presentational bottom sheet
// ---------------------------------------------------------------------------

class _OfflineSheet extends StatelessWidget {
  const _OfflineSheet({
    required this.scrollController,
    required this.isDownloading,
    required this.downloadProgress,
    required this.downloadLabel,
    required this.regions,
    required this.regionsLoading,
    required this.deletingRegionIds,
    required this.onDownloadCurrent,
    required this.onDeleteRegion,
    required this.onRefreshRegions,
    required this.regionDisplayName,
    required this.formatBytes,
    required this.itinerary,
    required this.onDownloadItineraryEvent,
    required this.onDownloadAllItinerary,
    required this.routeSteps,
    required this.routeDistanceMeters,
    required this.routeDurationSeconds,
    required this.travelProfile,
    required this.selectedRouteStepIndex,
    required this.onTapRouteStep,
    required this.isNavigationMode,
    required this.isNavigationBooting,
    required this.onStartNavigation,
    required this.onStopNavigation,
    required this.onClearRoute,
    required this.onDeleteSavedMark,
  });

  final ScrollController scrollController;
  final bool isDownloading;
  final double downloadProgress;
  final String downloadLabel;
  final List<TileRegion> regions;
  final bool regionsLoading;
  final Set<String> deletingRegionIds;
  final VoidCallback onDownloadCurrent;
  final Future<void> Function(TileRegion region) onDeleteRegion;
  final Future<void> Function() onRefreshRegions;
  final String Function(TileRegion region) regionDisplayName;
  final String Function(int bytes) formatBytes;
  final List<ItineraryEvent> itinerary;
  final Future<void> Function(ItineraryEvent event) onDownloadItineraryEvent;
  final VoidCallback onDownloadAllItinerary;
  final List<RouteStep> routeSteps;
  final double? routeDistanceMeters;
  final double? routeDurationSeconds;
  final DirectionsProfile travelProfile;
  final int? selectedRouteStepIndex;
  final Future<void> Function(int index, RouteStep step) onTapRouteStep;
  final bool isNavigationMode;
  final bool isNavigationBooting;
  final Future<void> Function() onStartNavigation;
  final Future<void> Function() onStopNavigation;
  final Future<void> Function() onClearRoute;
  final Future<void> Function(String id) onDeleteSavedMark;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final travelModeLabel = travelProfile == DirectionsProfile.driving
        ? l10n.mapTravelDriving
        : l10n.mapTravelWalking;
    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        border: Border.all(color: AppColors.borderSubtle),
        boxShadow: const [
          BoxShadow(
            color: Color(0x66000000),
            blurRadius: 28,
            offset: Offset(0, -8),
          ),
        ],
      ),
      child: ListView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        controller: scrollController,
        padding: const EdgeInsets.fromLTRB(16, 10, 16, 24),
        children: [
          const _DragHandle(),
          const SizedBox(height: 8),
          _Header(
            icon: Icons.cloud_download_outlined,
            title: l10n.mapOfflineMapsTitle,
            action: IconButton(
              tooltip: l10n.mapRefreshTooltip,
              onPressed: regionsLoading ? null : onRefreshRegions,
              icon: const Icon(
                Icons.refresh_rounded,
                color: AppColors.textSecondary,
                size: 20,
              ),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            l10n.mapOfflineIntro,
            style: const TextStyle(
              color: AppColors.textSecondary,
              fontSize: 12.5,
              height: 1.4,
            ),
          ),
          if (routeSteps.isNotEmpty) ...[
            const SizedBox(height: 18),
            _SectionTitle(
              l10n.mapTurnByTurn(travelModeLabel),
              action: Text(
                '${_formatDistance(routeDistanceMeters)} · ${_formatDuration(routeDurationSeconds)}',
                style: const TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: 11.5,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(height: 8),
            SizedBox(
              width: double.infinity,
              child: FilledButton.icon(
                onPressed: isNavigationBooting
                    ? null
                    : (isNavigationMode ? onStopNavigation : onStartNavigation),
                icon: Icon(
                  isNavigationMode
                      ? Icons.stop_circle_outlined
                      : Icons.navigation_rounded,
                ),
                label: Text(
                  isNavigationBooting
                      ? l10n.mapStartingNav
                      : (isNavigationMode
                            ? l10n.mapStopNavigation
                            : l10n.mapStartNavigation),
                ),
                style: FilledButton.styleFrom(
                  backgroundColor: isNavigationMode
                      ? AppColors.surfaceContainer
                      : AppColors.accent,
                  foregroundColor: isNavigationMode
                      ? AppColors.textPrimary
                      : AppColors.onAccent,
                ),
              ),
            ),
            const SizedBox(height: 8),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: isNavigationBooting ? null : onClearRoute,
                icon: const Icon(Icons.clear_all_rounded, size: 18),
                label: Text(l10n.mapClearRoute),
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppColors.textSecondary,
                  side: const BorderSide(color: AppColors.borderSubtle),
                ),
              ),
            ),
            const SizedBox(height: 8),
            for (var i = 0; i < routeSteps.length; i++)
              _RouteStepRow(
                index: i + 1,
                step: routeSteps[i],
                stepIcon: _stepIcon(routeSteps[i]),
                distanceLabel: _formatDistance(routeSteps[i].distanceMeters),
                isSelected: selectedRouteStepIndex == i,
                onTap: () => onTapRouteStep(i, routeSteps[i]),
              ),
          ],
          const SizedBox(height: 14),
          SizedBox(
            width: double.infinity,
            child: FilledButton(
              onPressed: isDownloading ? null : onDownloadCurrent,
              style: _primaryButtonStyle(),
              child: isDownloading
                  ? _DownloadingLabel(
                      label: downloadLabel,
                      progress: downloadProgress,
                    )
                  : _IdleLabel(
                      label: l10n.mapDownloadCurrentRegion,
                    ),
            ),
          ),
          if (isDownloading && downloadProgress > 0) ...[
            const SizedBox(height: 10),
            ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: LinearProgressIndicator(
                value: downloadProgress,
                minHeight: 4,
                backgroundColor: AppColors.surfaceContainer,
                valueColor: const AlwaysStoppedAnimation<Color>(
                  AppColors.accent,
                ),
              ),
            ),
          ],
          const SizedBox(height: 22),
          _SectionTitle(l10n.mapDownloadedRegions),
          const SizedBox(height: 8),
          _RegionList(
            regions: regions,
            regionsLoading: regionsLoading,
            deletingRegionIds: deletingRegionIds,
            onDelete: onDeleteRegion,
            regionDisplayName: regionDisplayName,
            formatBytes: formatBytes,
          ),
          _SavedOfflineMarksSection(onDelete: onDeleteSavedMark),
          const SizedBox(height: 22),
          _SectionTitle(
            l10n.mapFromItinerary,
            action: itinerary.isEmpty
                ? null
                : TextButton.icon(
                    onPressed: isDownloading ? null : onDownloadAllItinerary,
                    icon: const Icon(Icons.download_done_rounded, size: 16),
                    label: Text(l10n.mapDownloadAll),
                    style: TextButton.styleFrom(
                      foregroundColor: AppColors.accent,
                      textStyle: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 12.5,
                      ),
                    ),
                  ),
          ),
          const SizedBox(height: 8),
          _ItineraryList(
            events: itinerary,
            isDownloading: isDownloading,
            onDownload: onDownloadItineraryEvent,
          ),
        ],
      ),
    );
  }

  ButtonStyle _primaryButtonStyle() {
    return FilledButton.styleFrom(
      backgroundColor: AppColors.accent,
      foregroundColor: AppColors.onAccent,
      disabledBackgroundColor: AppColors.accent.withValues(alpha: 0.85),
      disabledForegroundColor: AppColors.onAccent,
      padding: const EdgeInsets.symmetric(vertical: 14),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      textStyle: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w700,
        letterSpacing: 0.2,
      ),
    );
  }

  String _formatDistance(double? meters) {
    if (meters == null || meters <= 0) return '--';
    if (meters >= 1000) {
      return '${(meters / 1000).toStringAsFixed(1)} km';
    }
    return '${meters.round()} m';
  }

  String _formatDuration(double? seconds) {
    if (seconds == null || seconds <= 0) return '--';
    final mins = (seconds / 60).round();
    if (mins < 60) return '$mins min';
    final hours = mins ~/ 60;
    final rem = mins % 60;
    if (rem == 0) return '${hours}h';
    return '${hours}h ${rem}m';
  }

  IconData _stepIcon(RouteStep step) {
    final t = step.maneuverType?.toLowerCase() ?? '';
    final m = step.maneuverModifier?.toLowerCase() ?? '';
    if (t == 'arrive') return Icons.flag_outlined;
    if (t == 'depart') return Icons.play_arrow_rounded;
    if (m.contains('left')) return Icons.turn_left_rounded;
    if (m.contains('right')) return Icons.turn_right_rounded;
    if (m.contains('uturn')) return Icons.u_turn_left_rounded;
    if (t == 'roundabout') return Icons.roundabout_right_rounded;
    if (t == 'continue') return Icons.straight_rounded;
    return Icons.subdirectory_arrow_right_rounded;
  }
}

class _DragHandle extends StatelessWidget {
  const _DragHandle();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 42,
        height: 4,
        decoration: BoxDecoration(
          color: AppColors.borderSubtle,
          borderRadius: BorderRadius.circular(2),
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({required this.icon, required this.title, this.action});

  final IconData icon;
  final String title;
  final Widget? action;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            color: AppColors.surfaceContainer,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: AppColors.borderSubtle),
          ),
          child: Icon(icon, color: AppColors.accent, size: 20),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            title,
            style: const TextStyle(
              color: AppColors.textPrimary,
              fontSize: 15,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.2,
            ),
          ),
        ),
        ?action,
      ],
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle(this.title, {this.action});

  final String title;
  final Widget? action;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Text(
            title.toUpperCase(),
            style: const TextStyle(
              color: AppColors.textSecondary,
              fontSize: 11,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.8,
            ),
          ),
        ),
        ?action,
      ],
    );
  }
}

class _IdleLabel extends StatelessWidget {
  const _IdleLabel({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(Icons.download_rounded, size: 18),
        const SizedBox(width: 8),
        Flexible(child: Text(label, overflow: TextOverflow.ellipsis)),
      ],
    );
  }
}

class _DownloadingLabel extends StatelessWidget {
  const _DownloadingLabel({required this.label, required this.progress});

  final String label;
  final double progress;

  @override
  Widget build(BuildContext context) {
    final pctLabel = progress > 0
        ? '$label ${(progress * 100).toStringAsFixed(0)}%'
        : label;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(
          width: 18,
          height: 18,
          child: CircularProgressIndicator(
            strokeWidth: 2.4,
            valueColor: AlwaysStoppedAnimation<Color>(AppColors.onAccent),
            backgroundColor: Color(0x33000000),
          ),
        ),
        const SizedBox(width: 10),
        Flexible(child: Text(pctLabel, overflow: TextOverflow.ellipsis)),
      ],
    );
  }
}

class _RegionList extends StatelessWidget {
  const _RegionList({
    required this.regions,
    required this.regionsLoading,
    required this.deletingRegionIds,
    required this.onDelete,
    required this.regionDisplayName,
    required this.formatBytes,
  });

  final List<TileRegion> regions;
  final bool regionsLoading;
  final Set<String> deletingRegionIds;
  final Future<void> Function(TileRegion region) onDelete;
  final String Function(TileRegion region) regionDisplayName;
  final String Function(int bytes) formatBytes;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    if (regionsLoading && regions.isEmpty) {
      return _EmptyRow(
        icon: Icons.hourglass_empty_rounded,
        text: l10n.mapLoadingRegions,
      );
    }
    if (regions.isEmpty) {
      return _EmptyRow(
        icon: Icons.map_outlined,
        text: l10n.mapNoRegionsYet,
      );
    }

    return Column(
      children: [
        for (final region in regions)
          _RegionRow(
            region: region,
            displayName: regionDisplayName(region),
            sizeLabel: formatBytes(region.completedResourceSize),
            isDeleting: deletingRegionIds.contains(region.id),
            onDelete: () => onDelete(region),
          ),
      ],
    );
  }
}

class _RegionRow extends StatelessWidget {
  const _RegionRow({
    required this.region,
    required this.displayName,
    required this.sizeLabel,
    required this.isDeleting,
    required this.onDelete,
  });

  final TileRegion region;
  final String displayName;
  final String sizeLabel;
  final bool isDeleting;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    final complete =
        region.requiredResourceCount > 0 &&
        region.completedResourceCount >= region.requiredResourceCount;

    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.fromLTRB(12, 10, 6, 10),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainer,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.borderSubtle),
      ),
      child: Row(
        children: [
          Icon(
            complete ? Icons.cloud_done_rounded : Icons.cloud_sync_rounded,
            color: complete ? AppColors.accent : AppColors.textSecondary,
            size: 20,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  displayName,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 13.5,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  complete
                      ? sizeLabel
                      : '$sizeLabel · ${region.completedResourceCount}/${region.requiredResourceCount}',
                  style: const TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 11.5,
                  ),
                ),
              ],
            ),
          ),
          isDeleting
              ? const Padding(
                  padding: EdgeInsets.all(10),
                  child: SizedBox(
                    width: 16,
                    height: 16,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        AppColors.textSecondary,
                      ),
                    ),
                  ),
                )
              : IconButton(
                  tooltip: context.l10n.commonRemove,
                  onPressed: onDelete,
                  icon: const Icon(
                    Icons.delete_outline_rounded,
                    color: AppColors.textSecondary,
                    size: 20,
                  ),
                ),
        ],
      ),
    );
  }
}

class _ItineraryList extends StatelessWidget {
  const _ItineraryList({
    required this.events,
    required this.isDownloading,
    required this.onDownload,
  });

  final List<ItineraryEvent> events;
  final bool isDownloading;
  final Future<void> Function(ItineraryEvent event) onDownload;

  @override
  Widget build(BuildContext context) {
    if (events.isEmpty) {
      return _EmptyRow(
        icon: Icons.flight_takeoff_rounded,
        text: context.l10n.mapItineraryEmptyHint,
      );
    }

    return Column(
      children: [
        for (final event in events)
          _ItineraryRow(
            event: event,
            isDisabled: isDownloading,
            onDownload: () => onDownload(event),
          ),
      ],
    );
  }
}

class _ItineraryRow extends StatelessWidget {
  const _ItineraryRow({
    required this.event,
    required this.isDisabled,
    required this.onDownload,
  });

  final ItineraryEvent event;
  final bool isDisabled;
  final VoidCallback onDownload;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.fromLTRB(12, 10, 6, 10),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainer,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.borderSubtle),
      ),
      child: Row(
        children: [
          const Icon(Icons.place_outlined, color: AppColors.accent, size: 20),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  event.displayTitle,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 13.5,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  event.displayLocation.isEmpty
                      ? l10n.mapNoLocationSet
                      : event.displayLocation,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 11.5,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            tooltip: l10n.mapDownloadThisDestination,
            onPressed: isDisabled ? null : onDownload,
            icon: const Icon(
              Icons.download_for_offline_rounded,
              color: AppColors.accent,
              size: 22,
            ),
          ),
        ],
      ),
    );
  }
}

class _RouteStepRow extends StatelessWidget {
  const _RouteStepRow({
    required this.index,
    required this.step,
    required this.stepIcon,
    required this.distanceLabel,
    required this.isSelected,
    required this.onTap,
  });

  final int index;
  final RouteStep step;
  final IconData stepIcon;
  final String distanceLabel;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: isSelected
            ? AppColors.accent.withValues(alpha: 0.12)
            : AppColors.surfaceContainer,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isSelected ? AppColors.accent : AppColors.borderSubtle,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(12),
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 24,
                  height: 24,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: AppColors.accent.withValues(alpha: 0.18),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    '$index',
                    style: const TextStyle(
                      color: AppColors.accent,
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Icon(stepIcon, color: AppColors.accent, size: 18),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        step.instruction,
                        style: const TextStyle(
                          color: AppColors.textPrimary,
                          fontSize: 12.8,
                          height: 1.3,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        distanceLabel,
                        style: const TextStyle(
                          color: AppColors.textSecondary,
                          fontSize: 11.2,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _EmptyRow extends StatelessWidget {
  const _EmptyRow({required this.icon, required this.text});

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainer,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.borderSubtle),
      ),
      child: Row(
        children: [
          Icon(icon, color: AppColors.textSecondary, size: 18),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                color: AppColors.textSecondary,
                fontSize: 12.5,
                height: 1.35,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _NextInstructionChip extends StatelessWidget {
  const _NextInstructionChip({
    required this.instruction,
    required this.headerLine,
    required this.distanceLabel,
    required this.onTap,
  });

  final String instruction;
  final String headerLine;
  final String distanceLabel;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: const Color(0xF2141A2B),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.accent.withValues(alpha: 0.35)),
        boxShadow: const [
          BoxShadow(
            color: Color(0x66000000),
            blurRadius: 18,
            offset: Offset(0, 6),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(14),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(12, 10, 12, 10),
            child: Row(
              children: [
                const Icon(
                  Icons.navigation_rounded,
                  color: AppColors.accent,
                  size: 18,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        headerLine,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: AppColors.textSecondary,
                          fontSize: 11.5,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        instruction,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: AppColors.textPrimary,
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                          height: 1.25,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 10),
                Text(
                  distanceLabel,
                  style: const TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 11.5,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Floating search bar — city → Mapbox flyTo
// ---------------------------------------------------------------------------

class _MapSearchBar extends StatelessWidget {
  const _MapSearchBar({
    required this.controller,
    required this.focusNode,
    required this.searchHint,
    required this.clearTooltip,
    required this.isSearching,
    required this.onSubmitted,
    required this.onChanged,
    required this.onCleared,
  });

  final TextEditingController controller;
  final FocusNode focusNode;
  final String searchHint;
  final String clearTooltip;
  final bool isSearching;
  final ValueChanged<String> onSubmitted;

  /// Fires on every keystroke with the current text. The parent is
  /// responsible for debouncing and for triggering a rebuild to reflect
  /// the current `controller.text` (e.g. showing/hiding the clear button).
  final ValueChanged<String> onChanged;

  /// Called when the user taps the clear (×) button — lets the parent also
  /// drop any pinned search result (e.g. the flyTo action strip).
  final VoidCallback onCleared;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      elevation: 0,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: AppColors.borderSubtle),
          boxShadow: const [
            BoxShadow(
              color: Color(0x66000000),
              blurRadius: 18,
              offset: Offset(0, 6),
            ),
          ],
        ),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
        child: Row(
          children: [
            const Icon(
              Icons.search_rounded,
              color: AppColors.textSecondary,
              size: 20,
            ),
            const SizedBox(width: 10),
            Expanded(
              child: TextField(
                controller: controller,
                focusNode: focusNode,
                // Do NOT disable the field while a geocode/routing call is
                // in flight. Disabling drops focus, which dismisses the
                // keyboard mid-typing. The trailing spinner is enough
                // feedback that a request is pending.
                cursorColor: AppColors.accent,
                style: const TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 14,
                ),
                decoration: InputDecoration(
                  isCollapsed: true,
                  contentPadding: const EdgeInsets.symmetric(vertical: 14),
                  border: InputBorder.none,
                  hintText: searchHint,
                  hintStyle: const TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 14,
                  ),
                ),
                textInputAction: TextInputAction.search,
                onChanged: onChanged,
                onSubmitted: onSubmitted,
              ),
            ),
            if (isSearching)
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 4),
                child: SizedBox(
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(AppColors.accent),
                  ),
                ),
              )
            else if (controller.text.isNotEmpty)
              IconButton(
                tooltip: clearTooltip,
                iconSize: 18,
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
                onPressed: () {
                  controller.clear();
                  onChanged('');
                  onCleared();
                },
                icon: const Icon(
                  Icons.close_rounded,
                  color: AppColors.textSecondary,
                ),
              ),
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Saved offline pins (Hive) — list + delete
// ---------------------------------------------------------------------------

class _SavedOfflineMarksSection extends StatelessWidget {
  const _SavedOfflineMarksSection({required this.onDelete});

  final Future<void> Function(String id) onDelete;

  @override
  Widget build(BuildContext context) {
    if (!Hive.isBoxOpen(kSavedLocationsBoxName)) {
      return const SizedBox.shrink();
    }
    return ValueListenableBuilder<Box<SavedLocation>>(
      valueListenable:
          Hive.box<SavedLocation>(kSavedLocationsBoxName).listenable(),
      builder: (context, Box<SavedLocation> box, _) {
        final marks = box.values.toList(growable: false)
          ..sort((a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));
        if (marks.isEmpty) return const SizedBox.shrink();
        final l10n = context.l10n;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 22),
            _SectionTitle(l10n.mapSavedPinsTitle),
            const SizedBox(height: 6),
            Text(
              l10n.mapSavedPinsBody,
              style: const TextStyle(
                color: AppColors.textSecondary,
                fontSize: 12.5,
                height: 1.4,
              ),
            ),
            const SizedBox(height: 8),
            for (final m in marks)
              Container(
                margin: const EdgeInsets.only(bottom: 8),
                decoration: BoxDecoration(
                  color: AppColors.surfaceContainer,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.borderSubtle),
                ),
                child: ListTile(
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 4,
                  ),
                  title: Text(
                    m.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: AppColors.textPrimary,
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                  ),
                  subtitle: Text(
                    mapSavedPinCategory(l10n, m.category),
                    style: const TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 12,
                    ),
                  ),
                  trailing: IconButton(
                    tooltip: l10n.mapRemovePinTooltip,
                    onPressed: () => onDelete(m.id),
                    icon: const Icon(
                      Icons.delete_outline_rounded,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}

// ---------------------------------------------------------------------------
// Contextual actions that appear after a successful search
// ---------------------------------------------------------------------------

class _SearchActionsBar extends StatelessWidget {
  const _SearchActionsBar({
    required this.place,
    required this.isDownloading,
    required this.onDownload,
    required this.onAddToItinerary,
    required this.onSavePin,
  });

  final GeocodedPlace place;
  final bool isDownloading;
  final VoidCallback onDownload;
  final VoidCallback onAddToItinerary;
  final VoidCallback onSavePin;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.borderSubtle),
        boxShadow: const [
          BoxShadow(
            color: Color(0x66000000),
            blurRadius: 18,
            offset: Offset(0, 6),
          ),
        ],
      ),
      padding: const EdgeInsets.fromLTRB(12, 10, 12, 12),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              const Icon(
                Icons.place_rounded,
                color: AppColors.accent,
                size: 18,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      place.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: AppColors.textPrimary,
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      place.address,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 11.5,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: isDownloading ? null : onDownload,
                  icon: const Icon(Icons.cloud_download_outlined, size: 16),
                  label: Text(l10n.mapSaveOffline),
                  style: _pillStyle(gold: true),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: onAddToItinerary,
                  icon: const Icon(Icons.event_note_outlined, size: 16),
                  label: Text(l10n.mapAddToTrip),
                  style: _pillStyle(gold: false),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              onPressed: onSavePin,
              icon: const Icon(Icons.push_pin_outlined, size: 16),
              label: Text(l10n.mapSavePinToMap),
              style: _pillStyle(gold: false),
            ),
          ),
        ],
      ),
    );
  }

  ButtonStyle _pillStyle({required bool gold}) {
    final border = BorderSide(
      color: gold ? AppColors.accent : AppColors.borderSubtle,
      width: 1,
    );
    return OutlinedButton.styleFrom(
      foregroundColor: gold ? AppColors.accent : AppColors.textPrimary,
      disabledForegroundColor: AppColors.textSecondary,
      backgroundColor: AppColors.surfaceContainer,
      side: border,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      padding: const EdgeInsets.symmetric(vertical: 10),
      textStyle: const TextStyle(
        fontSize: 12.5,
        fontWeight: FontWeight.w700,
        letterSpacing: 0.2,
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Typeahead suggestions dropdown
// ---------------------------------------------------------------------------

class _SearchSuggestions extends StatelessWidget {
  const _SearchSuggestions({required this.suggestions, required this.onPick});

  final List<GeocodedPlace> suggestions;
  final ValueChanged<GeocodedPlace> onPick;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxHeight: 280),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.borderSubtle),
        boxShadow: const [
          BoxShadow(
            color: Color(0x66000000),
            blurRadius: 18,
            offset: Offset(0, 6),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(14),
        clipBehavior: Clip.antiAlias,
        child: ListView.separated(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          shrinkWrap: true,
          padding: const EdgeInsets.symmetric(vertical: 4),
          itemCount: suggestions.length,
          separatorBuilder: (context, index) => Container(
            height: 1,
            color: AppColors.borderSubtle,
            margin: const EdgeInsets.symmetric(horizontal: 10),
          ),
          itemBuilder: (context, index) {
            final place = suggestions[index];
            return InkWell(
              onTap: () => onPick(place),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(12, 10, 12, 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      _iconFor(place.category),
                      size: 18,
                      color: AppColors.textSecondary,
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            place.title,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              color: AppColors.textPrimary,
                              fontSize: 13.5,
                              fontWeight: FontWeight.w600,
                              height: 1.2,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            place.address,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              color: AppColors.textSecondary,
                              fontSize: 12,
                              height: 1.3,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Icon(
                      Icons.north_east_rounded,
                      size: 14,
                      color: AppColors.textSecondary,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  IconData _iconFor(String? category) {
    switch (category) {
      case 'poi':
        return Icons.location_on_outlined;
      case 'address':
        return Icons.alternate_email_rounded;
      case 'place':
        return Icons.location_city_rounded;
      case 'neighborhood':
        return Icons.home_work_outlined;
      default:
        return Icons.place_outlined;
    }
  }
}

// ---------------------------------------------------------------------------
// Driving / Walking toggle
// ---------------------------------------------------------------------------

class _TravelModeToggle extends StatelessWidget {
  const _TravelModeToggle({
    required this.profile,
    required this.isBusy,
    required this.drivingLabel,
    required this.walkingLabel,
    required this.onChanged,
  });

  final DirectionsProfile profile;
  final bool isBusy;
  final String drivingLabel;
  final String walkingLabel;
  final ValueChanged<DirectionsProfile> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.borderSubtle),
        boxShadow: const [
          BoxShadow(
            color: Color(0x66000000),
            blurRadius: 18,
            offset: Offset(0, 6),
          ),
        ],
      ),
      padding: const EdgeInsets.all(4),
      child: Row(
        children: [
          Expanded(
            child: _ProfileButton(
              profile: DirectionsProfile.driving,
              selected: profile == DirectionsProfile.driving,
              icon: Icons.directions_car_rounded,
              label: drivingLabel,
              onTap: isBusy ? null : () => onChanged(DirectionsProfile.driving),
            ),
          ),
          Expanded(
            child: _ProfileButton(
              profile: DirectionsProfile.walking,
              selected: profile == DirectionsProfile.walking,
              icon: Icons.directions_walk_rounded,
              label: walkingLabel,
              onTap: isBusy ? null : () => onChanged(DirectionsProfile.walking),
            ),
          ),
        ],
      ),
    );
  }
}

class _ProfileButton extends StatelessWidget {
  const _ProfileButton({
    required this.profile,
    required this.selected,
    required this.icon,
    required this.label,
    required this.onTap,
  });

  final DirectionsProfile profile;
  final bool selected;
  final IconData icon;
  final String label;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final fg = selected ? AppColors.accent : AppColors.textSecondary;
    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(10),
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: selected
                ? AppColors.accent.withValues(alpha: 0.18)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: selected ? AppColors.accent : Colors.transparent,
              width: 1,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 16, color: fg),
              const SizedBox(width: 8),
              Text(
                label,
                style: TextStyle(
                  color: fg,
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.2,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

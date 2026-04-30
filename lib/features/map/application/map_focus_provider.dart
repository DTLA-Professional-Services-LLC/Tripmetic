import 'package:flutter_riverpod/flutter_riverpod.dart';

/// When set, [OfflineMapScreen] flies the camera here once the map is ready,
/// then clears this provider.
class MapFocusIntent {
  const MapFocusIntent({
    required this.latitude,
    required this.longitude,
    this.label,
  });

  final double latitude;
  final double longitude;
  final String? label;
}

final mapFocusIntentProvider = StateProvider<MapFocusIntent?>((ref) => null);

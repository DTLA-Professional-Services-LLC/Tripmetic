import 'dart:convert';

import 'package:hive_flutter/hive_flutter.dart';

import '../domain/travel_destination.dart';

const _kBoxName = 'tripmetic_bucket_list';
const _kDestinationsKey = 'bucket_destinations_v1';
const _kBucketDemoSeed = 'tripmetic_bucket_demo_v1';

/// Local-first persistence for bucket list entries (works offline, no account).
class BucketListHiveStore {
  Box<dynamic>? _box;

  Future<void> open() async {
    _box = await Hive.openBox<dynamic>(_kBoxName);
  }

  Box<dynamic> get _requireBox {
    final b = _box;
    if (b == null) {
      throw StateError('BucketListHiveStore.open() must be called before use');
    }
    return b;
  }

  List<TravelDestination> loadDestinations() {
    final raw = _requireBox.get(_kDestinationsKey);
    if (raw is String && raw.isNotEmpty) {
      try {
        final list = jsonDecode(raw) as List<dynamic>;
        return list
            .map((dynamic e) {
              if (e is! Map) return null;
              final m = Map<String, dynamic>.from(e);
              return TravelDestination.fromJson(m);
            })
            .whereType<TravelDestination>()
            .toList();
      } catch (_) {
        return [];
      }
    }
    if (raw is List) {
      return raw
          .map((dynamic e) {
            if (e is! Map) return null;
            final m = Map<String, dynamic>.from(e);
            return TravelDestination.fromJson(m);
          })
          .whereType<TravelDestination>()
          .toList();
    }
    return [];
  }

  Future<void> saveDestinations(List<TravelDestination> destinations) async {
    final encoded = jsonEncode(destinations.map((e) => e.toJson()).toList());
    await _requireBox.put(_kDestinationsKey, encoded);
    await _requireBox.flush();
  }

  /// First install only: [TravelDestination.seedList] illustrates the bucket list.
  Future<void> applyDemoSeedsIfNeeded() async {
    if (_requireBox.get(_kBucketDemoSeed) == true) return;
    try {
      if (!_requireBox.containsKey(_kDestinationsKey)) {
        await saveDestinations(
          List<TravelDestination>.from(TravelDestination.seedList),
        );
      }
    } finally {
      await _requireBox.put(_kBucketDemoSeed, true);
    }
  }
}

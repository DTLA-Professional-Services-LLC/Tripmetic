import 'dart:convert';

import 'package:hive_flutter/hive_flutter.dart';

import '../../packing/domain/packing_item.dart';
import '../domain/itinerary_event.dart';
import '../domain/trip_budget.dart';

const _kBoxName = 'tripmetic_trip';
const _kBudgetKey = 'trip_budget_v1';
const _kItineraryKey = 'itinerary_events_v1';
const _kPackingKey = 'packing_list_v1';

class TripHiveStore {
  Box<dynamic>? _box;

  Future<void> open() async {
    _box = await Hive.openBox<dynamic>(_kBoxName);
  }

  Box<dynamic> get _requireBox {
    final b = _box;
    if (b == null) {
      throw StateError('TripHiveStore.open() must be called before use');
    }
    return b;
  }

  TripBudget loadBudget() {
    final raw = _requireBox.get(_kBudgetKey);
    if (raw is String && raw.isNotEmpty) {
      try {
        final map = jsonDecode(raw) as Map<dynamic, dynamic>;
        return TripBudget.fromJson(map);
      } catch (_) {
        /* fall through */
      }
    }
    if (raw is Map) {
      try {
        return TripBudget.fromJson(raw);
      } catch (_) {
        /* fall through */
      }
    }
    return TripBudget.initial();
  }

  Future<void> saveBudget(TripBudget budget) async {
    await _requireBox.put(_kBudgetKey, jsonEncode(budget.toJson()));
  }

  List<ItineraryEvent> loadItinerary() {
    final raw = _requireBox.get(_kItineraryKey);
    if (raw is String && raw.isNotEmpty) {
      try {
        final list = jsonDecode(raw) as List<dynamic>;
        return list
            .map((dynamic e) {
              if (e is! Map) return null;
              return ItineraryEvent.fromJson(Map<dynamic, dynamic>.from(e));
            })
            .whereType<ItineraryEvent>()
            .toList();
      } catch (_) {
        return [];
      }
    }
    if (raw is List) {
      return raw
          .map((dynamic e) {
            if (e is! Map) return null;
            return ItineraryEvent.fromJson(Map<dynamic, dynamic>.from(e));
          })
          .whereType<ItineraryEvent>()
          .toList();
    }
    return [];
  }

  Future<void> saveItinerary(List<ItineraryEvent> events) async {
    await _requireBox.put(
      _kItineraryKey,
      jsonEncode(events.map((e) => e.toJson()).toList()),
    );
    await _requireBox.flush();
  }

  /// Whether any packing list has ever been persisted (even if empty).
  bool hasPackingListKey() => _requireBox.containsKey(_kPackingKey);

  List<PackingItem> loadPackingList() {
    final raw = _requireBox.get(_kPackingKey);
    if (raw is String && raw.isNotEmpty) {
      try {
        final list = jsonDecode(raw) as List<dynamic>;
        return list
            .map((dynamic e) {
              if (e is! Map) return null;
              return PackingItem.fromJson(Map<dynamic, dynamic>.from(e));
            })
            .whereType<PackingItem>()
            .toList();
      } catch (_) {
        return [];
      }
    }
    if (raw is List) {
      return raw
          .map((dynamic e) {
            if (e is! Map) return null;
            return PackingItem.fromJson(Map<dynamic, dynamic>.from(e));
          })
          .whereType<PackingItem>()
          .toList();
    }
    return [];
  }

  Future<void> savePackingList(List<PackingItem> items) async {
    await _requireBox.put(
      _kPackingKey,
      jsonEncode(items.map((e) => e.toJson()).toList()),
    );
    await _requireBox.flush();
  }
}

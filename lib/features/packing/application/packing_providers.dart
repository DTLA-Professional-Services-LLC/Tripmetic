import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../domain/packing_item.dart';
import '../../trip/application/trip_providers.dart';
import '../../trip/data/trip_hive_store.dart';

/// When true, completed items are hidden from the packing list UI.
final hideCompletedPackingProvider = StateProvider<bool>((ref) => false);

final packingListProvider = NotifierProvider<PackingListNotifier, List<PackingItem>>(PackingListNotifier.new);

class PackingListNotifier extends Notifier<List<PackingItem>> {
  TripHiveStore get _store => ref.read(tripHiveStoreProvider);

  @override
  List<PackingItem> build() {
    try {
      if (!_store.hasPackingListKey()) {
        final starter = PackingItem.starterItems();
        Future.microtask(() async {
          await _store.savePackingList(starter);
        });
        return starter;
      }
      final list = List<PackingItem>.from(_store.loadPackingList());
      return list;
    } catch (_) {
      return [];
    }
  }

  Future<void> _persist() async {
    await _store.savePackingList(state);
  }

  Future<void> addItem(PackingItem item) async {
    state = [...state, item];
    await _persist();
  }

  Future<void> deleteItem(String id) async {
    state = [for (final e in state) if (e.id != id) e];
    await _persist();
  }

  Future<void> toggleCompleted(String id) async {
    state = [
      for (final e in state)
        if (e.id == id) e.copyWith(isCompleted: !e.isCompleted) else e,
    ];
    await _persist();
  }

  Future<void> setQuantity(String id, int quantity) async {
    final q = quantity.clamp(1, 999);
    state = [
      for (final e in state) if (e.id == id) e.copyWith(quantity: q) else e,
    ];
    await _persist();
  }
}

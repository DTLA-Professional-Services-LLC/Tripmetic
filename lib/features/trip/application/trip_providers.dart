import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/trip_hive_store.dart';
import '../domain/itinerary_event.dart';
import '../domain/trip_budget.dart';

final tripHiveStoreProvider = Provider<TripHiveStore>((ref) {
  return TripHiveStore();
});

final tripHiveStoreReadyProvider = FutureProvider<void>((ref) async {
  await ref.read(tripHiveStoreProvider).open();
});

final tripBudgetProvider = NotifierProvider<TripBudgetNotifier, TripBudget>(TripBudgetNotifier.new);

class TripBudgetNotifier extends Notifier<TripBudget> {
  TripHiveStore get _store => ref.read(tripHiveStoreProvider);

  @override
  TripBudget build() {
    final ready = ref.watch(tripHiveStoreReadyProvider);
    return ready.when(
      data: (_) => ref.read(tripHiveStoreProvider).loadBudget(),
      loading: () => TripBudget.initial(),
      error: (Object error, StackTrace stackTrace) => TripBudget.initial(),
    );
  }

  Future<void> _persist() async {
    await _store.saveBudget(state);
  }

  Future<void> setTotalBudget(double value) async {
    final v = (value.isFinite ? value.clamp(0, 1e12) : 0.0).toDouble();
    state = state.copyWith(totalBudget: v);
    await _persist();
  }

  Future<void> setExpense(String category, double value) async {
    final next = Map<String, double>.from(state.expenses);
    next[category] = (value.isFinite ? value.clamp(0, 1e12) : 0).toDouble();
    state = state.copyWith(expenses: next);
    await _persist();
  }

  /// Adds a new custom expense category with an initial amount of 0.
  Future<void> addCategory(String name) async {
    final trimmed = name.trim();
    if (trimmed.isEmpty) return;
    if (state.expenses.containsKey(trimmed)) return;
    final next = Map<String, double>.from(state.expenses);
    next[trimmed] = 0;
    state = state.copyWith(expenses: next);
    await _persist();
  }

  /// Removes a category entirely from the expense map.
  Future<void> removeCategory(String name) async {
    if (!state.expenses.containsKey(name)) return;
    final next = Map<String, double>.from(state.expenses);
    next.remove(name);
    state = state.copyWith(expenses: next);
    await _persist();
  }

  /// Renames a category, preserving its amount.
  Future<void> renameCategory(String oldName, String newName) async {
    final trimmed = newName.trim();
    if (trimmed.isEmpty || trimmed == oldName) return;
    if (state.expenses.containsKey(trimmed)) return;
    if (!state.expenses.containsKey(oldName)) return;
    final next = Map<String, double>.from(state.expenses);
    final amount = next.remove(oldName) ?? 0;
    next[trimmed] = amount;
    state = state.copyWith(expenses: next);
    await _persist();
  }

  Future<void> setDestinationCurrencies(List<String> codes) async {
    final normalized = codes
        .map((c) => c.trim().toUpperCase())
        .where((c) => c.length == 3)
        .toSet()
        .toList();
    state = state.copyWith(destinationCurrencies: normalized);
    await _persist();
  }

  Future<void> addDestinationCurrency(String code) async {
    final c = code.trim().toUpperCase();
    if (c.length != 3) return;
    if (state.destinationCurrencies.contains(c)) return;
    state = state.copyWith(destinationCurrencies: [...state.destinationCurrencies, c]);
    await _persist();
  }

  Future<void> removeDestinationCurrency(String code) async {
    final c = code.trim().toUpperCase();
    final next = state.destinationCurrencies.where((e) => e != c).toList();
    if (next.isEmpty) return;
    state = state.copyWith(destinationCurrencies: next);
    await _persist();
  }

  Future<void> setBaseCurrency(String code) async {
    final c = code.trim().toUpperCase();
    if (c.length != 3) return;
    var dest = List<String>.from(state.destinationCurrencies);
    dest = dest.where((e) => e != c).toList();
    if (dest.isEmpty) {
      dest = ['EUR', 'PHP', 'GBP', 'JPY'].where((e) => e != c).take(2).toList();
    }
    state = state.copyWith(baseCurrency: c, destinationCurrencies: dest);
    await _persist();
  }

  Future<void> setTripDays(int days) async {
    final d = days.clamp(1, 3650);
    state = state.copyWith(tripDays: d);
    await _persist();
  }
}

final itineraryProvider = NotifierProvider<ItineraryNotifier, List<ItineraryEvent>>(ItineraryNotifier.new);

class ItineraryNotifier extends Notifier<List<ItineraryEvent>> {
  static final _rand = Random();

  TripHiveStore get _store => ref.read(tripHiveStoreProvider);

  @override
  List<ItineraryEvent> build() {
    // Hive is opened in `main()` before `runApp`. Do not `watch` the ready
    // future here: when its AsyncValue transitions (e.g. hot restart), Riverpod
    // re-runs `build()` and would replace in-memory itinerary with a stale disk
    // read before async persist finishes, clearing events and saving empty data.
    try {
      final list = List<ItineraryEvent>.from(_store.loadItinerary());
      list.sort((a, b) => a.startDateTime.compareTo(b.startDateTime));
      return list;
    } catch (_) {
      return const <ItineraryEvent>[];
    }
  }

  Future<void> _persist() async {
    await _store.saveItinerary(state);
  }

  Future<void> addEvent(ItineraryEvent event) async {
    state = [...state, event]..sort((a, b) => a.startDateTime.compareTo(b.startDateTime));
    await _persist();
  }

  Future<void> updateEvent(ItineraryEvent event) async {
    state = [
      for (final e in state)
        if (e.id == event.id) event else e,
    ]..sort((a, b) => a.startDateTime.compareTo(b.startDateTime));
    await _persist();
  }

  Future<void> removeEvent(String id) async {
    state = [for (final e in state) if (e.id != id) e];
    await _persist();
  }

  String newId() => '${DateTime.now().microsecondsSinceEpoch}_${_rand.nextInt(1 << 30)}';
}

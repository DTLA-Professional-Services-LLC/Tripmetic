import '../../features/trip/domain/itinerary_event.dart';
import '../../features/trip/domain/trip_budget.dart';

/// Sample itinerary events (local times) — shown on first install only.
List<ItineraryEvent> tripmeticDemoItineraryEvents() {
  final base = DateTime.now();
  final d0 = DateTime(base.year, base.month, base.day);
  final d1 = d0.add(const Duration(days: 1));
  final d2 = d0.add(const Duration(days: 3));
  return [
    ItineraryEvent(
      id: 'demo_itin_flight',
      startDateTime: d0.add(const Duration(hours: 6, minutes: 30)),
      title: 'Flight to Lisbon',
      location: 'SFO · Terminal I',
      notes: 'TP 236 · Check in opens 3h before departure. Seat 12A.',
      latitude: 37.6213,
      longitude: -122.3790,
    ),
    ItineraryEvent(
      id: 'demo_itin_checkin',
      startDateTime: d1.add(const Duration(hours: 15)),
      title: 'Hotel check-in',
      location: 'Pousada de Lisboa',
      notes: 'Confirmation #48291. Ask for quiet room facing the courtyard.',
      latitude: 38.7078,
      longitude: -9.1366,
    ),
    ItineraryEvent(
      id: 'demo_itin_food',
      startDateTime: d1.add(const Duration(hours: 20)),
      title: 'Dinner reservation',
      location: 'Ramiro · Marisqueira',
      notes: 'Table for 2 at 20:00. Cash preferred for small plates.',
      latitude: 38.7201,
      longitude: -9.1319,
    ),
    ItineraryEvent(
      id: 'demo_itin_tour',
      startDateTime: d2.add(const Duration(hours: 10)),
      title: 'Belém walking tour',
      location: 'Meet at Jerónimos Monastery west gate',
      notes: '2.5h tour · bring sunscreen and a water bottle.',
      latitude: 38.6979,
      longitude: -9.2067,
    ),
  ];
}

/// Sample budget — first install only (no persisted budget key yet).
TripBudget tripmeticDemoTripBudget() {
  final exp = {for (final k in TripBudgetExpenseKeys.all) k: 0.0};
  exp['Flights'] = 920;
  exp['Hotels'] = 1180;
  exp['Transportation'] = 185;
  exp[TripBudgetExpenseKeys.dailyFood] = 280;
  exp['Eating Out'] = 340;
  exp['Shopping'] = 120;
  exp['Grocery'] = 95;
  exp['Entertainment'] = 160;
  exp['Tourism'] = 210;
  exp['Phone Service'] = 35;
  exp['Travel Insurance'] = 89;
  exp['Misc'] = 75;
  return TripBudget(
    totalBudget: 4800,
    baseCurrency: 'USD',
    tripDays: 10,
    destinationCurrencies: const ['EUR', 'GBP'],
    expenses: exp,
  );
}

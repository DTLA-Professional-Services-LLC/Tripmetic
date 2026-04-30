import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tripmetic/features/trip/application/trip_providers.dart';
import 'package:tripmetic/features/trip/domain/itinerary_event.dart';
import 'package:hive/hive.dart';

void main() {
  test('ItineraryEvent.fromJson accepts int or double startMs', () {
    final fromInt = ItineraryEvent.fromJson(
      jsonDecode(
        '{"id":"1","startMs":1730000000000,"title":"A","location":"","notes":""}',
      ) as Map<dynamic, dynamic>,
    );
    expect(fromInt, isNotNull);
    final fromDouble = ItineraryEvent.fromJson(
      jsonDecode(
        '{"id":"2","startMs":1730000000000.0,"title":"B","location":"","notes":""}',
      ) as Map<dynamic, dynamic>,
    );
    expect(fromDouble, isNotNull);
  });

  test('itinerary persists across provider containers', () async {
    TestWidgetsFlutterBinding.ensureInitialized();
    final dir = Directory.systemTemp.createTempSync('tripmetic_itin_');
    Hive.init(dir.path);
    addTearDown(() async {
      if (Hive.isBoxOpen('tripmetic_trip')) {
        await Hive.box<dynamic>('tripmetic_trip').close();
      }
      await Hive.close();
      dir.deleteSync(recursive: true);
    });

    final c1 = ProviderContainer();
    addTearDown(c1.dispose);
    await c1.read(tripHiveStoreReadyProvider.future);
    expect(c1.read(itineraryProvider), isEmpty);

    await c1.read(itineraryProvider.notifier).addEvent(
          ItineraryEvent(
            id: 'a',
            startDateTime: DateTime(2026, 6, 15, 14, 30),
            title: 'Museum',
            location: 'Paris',
            notes: '',
          ),
        );
    expect(c1.read(itineraryProvider).length, 1);
    expect(c1.read(itineraryProvider).first.title, 'Museum');

    final c2 = ProviderContainer();
    addTearDown(c2.dispose);
    await c2.read(tripHiveStoreReadyProvider.future);
    expect(c2.read(itineraryProvider).length, 1);
    expect(c2.read(itineraryProvider).first.title, 'Museum');
  });
}

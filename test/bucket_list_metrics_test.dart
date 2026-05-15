import 'package:flutter_test/flutter_test.dart';
import 'package:tripmetic/features/bucket_list/domain/travel_destination.dart';
import 'package:tripmetic/features/bucket_list/domain/travel_metrics.dart';
import 'package:tripmetic/features/bucket_list/domain/us_state_from_coordinates.dart';

void main() {
  test('inferUsStateFromCoordinates maps Chicago to Illinois', () {
    expect(
      inferUsStateFromCoordinates(41.8781, -87.6298),
      'Illinois',
    );
  });

  test('US been without state still counts toward state metrics via coordinates',
      () {
    final metrics = TravelExplorationMetrics.fromDestinations([
      TravelDestination(
        id: '1',
        city: 'Chicago',
        country: 'United States',
        latitude: 41.8781,
        longitude: -87.6298,
        category: TravelDestinationCategory.been,
      ),
      TravelDestination(
        id: '2',
        city: 'Miami',
        country: 'United States',
        latitude: 25.7617,
        longitude: -80.1918,
        category: TravelDestinationCategory.been,
      ),
    ]);
    expect(metrics.uniqueUsStatesVisited, greaterThanOrEqualTo(2));
    expect(metrics.usExploredPercent, greaterThan(0));
  });

  test('want category does not affect exploration metrics', () {
    final metrics = TravelExplorationMetrics.fromDestinations([
      TravelDestination(
        id: '1',
        city: 'Chicago',
        country: 'United States',
        latitude: 41.8781,
        longitude: -87.6298,
        category: TravelDestinationCategory.want,
      ),
    ]);
    expect(metrics.uniqueUsStatesVisited, 0);
  });
}

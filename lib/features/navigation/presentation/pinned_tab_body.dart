import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/navigation/nav_feature_ids.dart';
import '../../bucket_list/presentation/bucket_list_screen.dart';
import '../../crypto/presentation/crypto_tab.dart';
import '../../currency/presentation/currency_tab.dart';
import '../../dual_clock/presentation/widget_instruction_screen.dart';
import '../../group_planner/presentation/group_planner_landing_screen.dart';
import '../../map/presentation/map_screen.dart';
import '../../mindmap/presentation/mind_map_screen.dart';
import '../../packing/presentation/packing_screen.dart';
import '../../scheduler/presentation/scheduler_tab.dart';
import '../../settings/presentation/settings_screen.dart';
import '../../sizes/presentation/size_converter_screen.dart';
import '../../tip/presentation/tip_calculator_screen.dart';
import '../../trip/presentation/budget_screen.dart';
import '../../trip/presentation/itinerary_screen.dart';
import '../../units/presentation/units_tab.dart';
import '../../vault/presentation/vault_screen.dart';
import 'dashboard_screen.dart';

/// Content for a bottom-nav pin. Must match tools opened from the More menu / router.
class PinnedTabBody extends ConsumerWidget {
  const PinnedTabBody({super.key, required this.featureId});

  final String featureId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return switch (featureId) {
      NavFeatureIds.dashboard => const DashboardScreen(),
      NavFeatureIds.settings => const SettingsScreen(),
      NavFeatureIds.units => const UnitsTab(),
      NavFeatureIds.dualClock => const WidgetInstructionScreen(),
      NavFeatureIds.itinerary => const ItineraryScreen(),
      NavFeatureIds.currency => const CurrencyTab(),
      NavFeatureIds.offlineMap => const OfflineMapScreen(),
      NavFeatureIds.bucketList => const BucketListScreen(),
      NavFeatureIds.groupPlanner => const GroupPlannerLandingScreen(),
      NavFeatureIds.budget => const BudgetScreen(),
      NavFeatureIds.vault => const VaultScreen(),
      NavFeatureIds.scheduler => const SchedulerTab(),
      NavFeatureIds.packing => const PackingScreen(),
      NavFeatureIds.crypto => const CryptoTab(),
      NavFeatureIds.tipCalculator => const TipCalculatorScreen(),
      NavFeatureIds.sizeConverter => const SizeConverterScreen(),
      NavFeatureIds.mindMap => const MindMapScreen(),
      _ => Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Text(
              featureId,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
        ),
    };
  }
}

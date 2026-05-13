import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:purchases_ui_flutter/purchases_ui_flutter.dart';

import '../../../core/navigation/nav_feature_ids.dart';
import '../../../core/navigation/tripmetic_home_navigation.dart';
import '../../../core/subscription/revenue_cat_sdk_state.dart';
import '../../../core/subscription/subscription_providers.dart';
import '../../../l10n/l10n_helpers.dart';

/// Full-screen RevenueCat paywall (dashboard → Paywalls). Shown on route `/paywall`.
class PaywallScreen extends ConsumerWidget {
  const PaywallScreen({super.key});

  void _afterAccessChange(WidgetRef ref, BuildContext context) {
    ref.read(customerInfoProvider.notifier).sync();
    if (!context.mounted) return;
    if (context.canPop()) {
      context.pop();
    } else {
      goTripmeticHome(context, ref, selectFeatureId: NavFeatureIds.currency);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (!revenueCatSdkConfigured) {
      return _PaywallUnavailable(
        onClose: () => goTripmeticHome(context, ref, selectFeatureId: NavFeatureIds.currency),
      );
    }
    return Scaffold(
      body: PaywallView(
        displayCloseButton: true,
        onPurchaseCompleted:
            (CustomerInfo customerInfo, StoreTransaction storeTransaction) {
          _afterAccessChange(ref, context);
        },
        onRestoreCompleted: (CustomerInfo customerInfo) {
          _afterAccessChange(ref, context);
        },
        onDismiss: () {
          if (!context.mounted) return;
          if (context.canPop()) {
            context.pop();
          } else {
            goTripmeticHome(context, ref, selectFeatureId: NavFeatureIds.currency);
          }
        },
      ),
    );
  }
}

class _PaywallUnavailable extends StatelessWidget {
  const _PaywallUnavailable({required this.onClose});

  final VoidCallback onClose;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.info_outline_rounded, size: 36),
              const SizedBox(height: 12),
              Text(
                l10n.paywallDisabledTitle,
                style: Theme.of(context).textTheme.titleMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                l10n.paywallDisabledBody,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 18),
              FilledButton(
                onPressed: onClose,
                child: const Text('OK'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

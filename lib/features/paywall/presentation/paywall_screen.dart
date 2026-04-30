import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:purchases_ui_flutter/purchases_ui_flutter.dart';

import '../../../core/subscription/subscription_providers.dart';

/// Full-screen RevenueCat paywall (dashboard → Paywalls). Shown on route `/paywall`.
class PaywallScreen extends ConsumerWidget {
  const PaywallScreen({super.key});

  void _afterAccessChange(WidgetRef ref, BuildContext context) {
    ref.read(customerInfoProvider.notifier).sync();
    if (!context.mounted) return;
    if (context.canPop()) {
      context.pop();
    } else {
      context.go('/currency');
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
            context.go('/currency');
          }
        },
      ),
    );
  }
}

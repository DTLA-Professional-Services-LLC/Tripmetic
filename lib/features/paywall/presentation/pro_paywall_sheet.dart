import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:purchases_ui_flutter/purchases_ui_flutter.dart';

import '../../../core/subscription/revenue_cat_sdk_state.dart';
import '../../../core/subscription/revenue_cat_ui_actions.dart';
import '../../../core/subscription/subscription_providers.dart';
import '../../../core/subscription/tripmetic_pro_entitlement.dart';
import '../../../l10n/l10n_helpers.dart';

/// In-place premium upsell (does not replace full-screen [/paywall] route).
class ProPaywallSheet extends ConsumerWidget {
  const ProPaywallSheet({super.key});

  static Future<void> show(BuildContext context) {
    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (ctx) => const ProPaywallSheet(),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    final l10n = context.l10n;

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24, 8, 24, 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              '👑',
              textAlign: TextAlign.center,
              style: theme.textTheme.displaySmall,
            ),
            const SizedBox(height: 8),
            Text(
              l10n.proPaywallTitle,
              textAlign: TextAlign.center,
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              l10n.proPaywallSubtitle,
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: cs.onSurfaceVariant,
                height: 1.4,
              ),
            ),
            const SizedBox(height: 20),
            ...l10n.proPaywallBullets
                .split('|')
                .where((line) => line.trim().isNotEmpty)
                .map(
                  (line) => Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(Icons.check_circle_rounded, color: cs.primary, size: 20),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            line.trim(),
                            style: theme.textTheme.bodyMedium,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
            const SizedBox(height: 16),
            FilledButton(
              onPressed: () async {
                if (!revenueCatSdkConfigured) {
                  final messenger = ScaffoldMessenger.maybeOf(context);
                  Navigator.pop(context);
                  messenger?.showSnackBar(
                    SnackBar(content: Text(l10n.proPaywallNotConfigured)),
                  );
                  return;
                }
                try {
                  final info =
                      await Purchases.getCustomerInfo().timeout(const Duration(seconds: 10));
                  if (!context.mounted) return;
                  if (TripmeticProEntitlement.isUnlocked(info)) {
                    ref.invalidate(customerInfoProvider);
                    Navigator.pop(context);
                    return;
                  }
                } catch (_) {}
                final result = await presentTripmeticPaywall();
                if (!context.mounted) return;
                await ref.read(customerInfoProvider.notifier).sync();
                if (context.mounted) Navigator.pop(context);
                if (result == PaywallResult.error && context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(l10n.proPaywallError)),
                  );
                }
              },
              child: Text(l10n.proPaywallUpgradeRevenueCat),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(l10n.commonCancel),
            ),
          ],
        ),
      ),
    );
  }
}

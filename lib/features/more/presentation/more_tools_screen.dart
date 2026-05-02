import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:purchases_ui_flutter/purchases_ui_flutter.dart';

import '../../../core/subscription/revenue_cat_ui_actions.dart';
import '../../../core/subscription/subscription_nav.dart';
import '../../../core/subscription/subscription_providers.dart';
import '../../../core/theme/app_colors.dart';
import '../../../l10n/l10n_helpers.dart';

/// Hub for additional travel utilities (opened from the app bar More icon).
class MoreToolsScreen extends ConsumerWidget {
  const MoreToolsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    final l10n = context.l10n;

    return SafeArea(
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: ListView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          padding: const EdgeInsets.fromLTRB(12, 8, 12, 16),
          children: [
          const _TripmeticProSubscriptionCard(),
          const SizedBox(height: 14),
          Text(
            l10n.moreToolsHeader,
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w700,
              letterSpacing: 1.2,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            l10n.moreToolsSubtitle,
            style: theme.textTheme.labelSmall?.copyWith(
              color: cs.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 14),
          _ToolCard(
            icon: Icons.route_outlined,
            title: l10n.toolItineraryTitle,
            subtitle: l10n.toolItinerarySubtitle,
            onTap: () => navigateIfProRoute(context, '/itinerary'),
          ),
          const SizedBox(height: 10),
          _ToolCard(
            icon: Icons.account_balance_wallet_outlined,
            title: l10n.toolBudgetTitle,
            subtitle: l10n.toolBudgetSubtitle,
            onTap: () => navigateIfProRoute(context, '/budget'),
          ),
          const SizedBox(height: 10),
          _ToolCard(
            icon: Icons.folder_shared_outlined,
            title: l10n.toolVaultTitle,
            subtitle: l10n.toolVaultSubtitle,
            onTap: () => navigateIfProRoute(context, '/vault'),
          ),
          const SizedBox(height: 10),
          _ToolCard(
            icon: Icons.schedule_rounded,
            title: l10n.toolSchedulerTitle,
            subtitle: l10n.toolSchedulerSubtitle,
            onTap: () => navigateIfProRoute(context, '/scheduler'),
          ),
          const SizedBox(height: 10),
          _ToolCard(
            icon: Icons.luggage_outlined,
            title: l10n.toolPackingTitle,
            subtitle: l10n.toolPackingSubtitle,
            onTap: () => navigateIfProRoute(context, '/packing'),
          ),
          const SizedBox(height: 10),
          _ToolCard(
            icon: Icons.straighten_outlined,
            title: l10n.toolUnitsTitle,
            subtitle: l10n.toolUnitsSubtitle,
            onTap: () => navigateIfProRoute(context, '/units'),
          ),
          const SizedBox(height: 10),
          _ToolCard(
            icon: Icons.currency_bitcoin_outlined,
            title: l10n.toolCryptoTitle,
            subtitle: l10n.toolCryptoSubtitle,
            onTap: () => navigateIfProRoute(context, '/crypto'),
          ),
          const SizedBox(height: 10),
          _ToolCard(
            icon: Icons.restaurant_rounded,
            title: l10n.toolTipTitle,
            subtitle: l10n.toolTipSubtitle,
            onTap: () => navigateIfProRoute(context, '/tip-calculator'),
          ),
          const SizedBox(height: 10),
          _ToolCard(
            icon: Icons.checkroom_outlined,
            title: l10n.toolSizeTitle,
            subtitle: l10n.toolSizeSubtitle,
            onTap: () => navigateIfProRoute(context, '/size-converter'),
          ),
          const SizedBox(height: 10),
          _ToolCard(
            icon: Icons.account_tree_outlined,
            title: l10n.toolMindMapTitle,
            subtitle: l10n.toolMindMapSubtitle,
            onTap: () => navigateIfProRoute(context, '/mind-map'),
          ),
          const SizedBox(height: 18),
          _ToolCard(
            icon: Icons.settings_outlined,
            title: l10n.toolSettingsAboutTitle,
            subtitle: l10n.toolSettingsAboutSubtitle,
            onTap: () => navigateIfProRoute(context, '/settings'),
          ),
        ],
        ),
      ),
    );
  }
}

class _ToolCard extends StatelessWidget {
  const _ToolCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;

    return Material(
      color: cs.surface,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: cs.primary.withValues(alpha: 0.45)),
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: cs.primary.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(icon, color: cs.primary, size: 26),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: theme.textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: theme.textTheme.labelMedium?.copyWith(
                        color: cs.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(Icons.chevron_right_rounded, color: cs.primary),
            ],
          ),
        ),
      ),
    );
  }
}

class _TripmeticProSubscriptionCard extends ConsumerWidget {
  const _TripmeticProSubscriptionCard();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    final isPro = ref.watch(isTripmeticProProvider);
    final l10n = context.l10n;

    Future<void> openPaywall() async {
      final messenger = ScaffoldMessenger.of(context);
      final result = await presentTripmeticPaywallIfNeeded();
      if (!context.mounted) return;
      if (result == PaywallResult.purchased ||
          result == PaywallResult.restored) {
        await ref.read(customerInfoProvider.notifier).sync();
        messenger.showSnackBar(
          SnackBar(content: Text(l10n.proWelcome)),
        );
      } else if (result == PaywallResult.error) {
        messenger.showSnackBar(
          SnackBar(
            content: Text(l10n.proPaywallError),
          ),
        );
      }
    }

    Future<void> openCustomerCenter() async {
      await presentTripmeticCustomerCenter(
        onRestoreFailed: (err) {
          if (!context.mounted) return;
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(l10n.proRestoreFailed(err.message))),
          );
        },
      );
      if (!context.mounted) return;
      await ref.read(customerInfoProvider.notifier).sync();
    }

    return Material(
      color: cs.surface,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.accent.withValues(alpha: 0.55)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.workspace_premium_outlined,
                  color: AppColors.accent,
                  size: 28,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    l10n.proName,
                    style: theme.textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                if (isPro)
                  Chip(
                    label: Text(l10n.proActive),
                    backgroundColor: AppColors.accent.withValues(alpha: 0.2),
                    labelStyle: TextStyle(
                      color: AppColors.accent,
                      fontSize: 12,
                    ),
                    side: BorderSide.none,
                  ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              isPro ? l10n.proManageHintPro : l10n.proManageHintFree,
              style: theme.textTheme.labelMedium?.copyWith(
                color: cs.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                if (!isPro)
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton(
                      onPressed: openPaywall,
                      style: FilledButton.styleFrom(
                        backgroundColor: AppColors.accent,
                        foregroundColor: AppColors.onAccent,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 12,
                        ),
                        alignment: Alignment.center,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.lock_open_rounded, size: 18),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              l10n.proTrialCta,
                              textAlign: TextAlign.center,
                              softWrap: true,
                              maxLines: 3,
                              style: theme.textTheme.labelLarge?.copyWith(
                                color: AppColors.onAccent,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                OutlinedButton.icon(
                  onPressed: openCustomerCenter,
                  icon: const Icon(Icons.manage_accounts_outlined, size: 18),
                  label: Text(l10n.proManageSubscription),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

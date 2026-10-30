import 'dart:ui' show ImageFilter;

import 'package:flutter/material.dart';

import '../../core/navigation/nav_feature_ids.dart';
import '../../core/theme/app_colors.dart';
import '../../features/paywall/presentation/pro_paywall_sheet.dart';
import '../../l10n/l10n_helpers.dart';

/// Soft paywall: real UI stays visible underneath; blur + full-screen pointer shield.
///
/// [isPro] must reflect RevenueCat / Tripmetic Pro (e.g. `ref.watch(isTripmeticProProvider)`).
///
/// The frosted layer is wrapped in [AbsorbPointer] so gestures do not reach [child].
/// A second full-screen [AbsorbPointer] catches “ghost” hits; the lock/teaser is wrapped in
/// [IgnorePointer] so those taps fall through to that shield, while [FilledButton] stays
/// interactive above it.
class ProGlassOverlay extends StatelessWidget {
  const ProGlassOverlay({
    super.key,
    required this.featureId,
    required this.isPro,
    required this.child,
  });

  final String featureId;

  /// Tripmetic Pro entitlement (pass `ref.watch(isTripmeticProProvider)` from the parent).
  final bool isPro;

  final Widget child;

  bool get _gateActive {
    if (featureId.isEmpty) return false;
    if (!NavFeatureRoutes.isPro(featureId)) return false;
    return !isPro;
  }

  @override
  Widget build(BuildContext context) {
    if (!_gateActive) return child;

    final theme = Theme.of(context);
    final l10n = context.l10n;

    return Stack(
      fit: StackFit.expand,
      clipBehavior: Clip.hardEdge,
      children: [
        child,
        Positioned.fill(
          child: AbsorbPointer(
            absorbing: true,
            child: ClipRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
                child: SizedBox.expand(
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.3),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        Positioned.fill(
          child: AbsorbPointer(
            absorbing: true,
            child: const SizedBox.expand(),
          ),
        ),
        Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 28),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                IgnorePointer(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.lock_rounded, size: 52, color: AppColors.accent),
                      const SizedBox(height: 14),
                      Text(
                        l10n.proGlassTeaserTitle,
                        textAlign: TextAlign.center,
                        style: theme.textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w800,
                          letterSpacing: 0.2,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 22),
                FilledButton(
                  onPressed: () => ProPaywallSheet.show(context),
                  style: FilledButton.styleFrom(
                    backgroundColor: AppColors.accent,
                    foregroundColor: AppColors.onAccent,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 28,
                      vertical: 14,
                    ),
                  ),
                  child: Text(l10n.upgradeNow),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

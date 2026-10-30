import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/theme/app_colors.dart';
import '../../../l10n/l10n_helpers.dart';
import '../domain/portfolio_apps.dart';

/// Portfolio of apps from the p1.do team (see https://p1.do/our-apps).
class OurAppsScreen extends StatelessWidget {
  const OurAppsScreen({super.key});

  Future<void> _openUrl(BuildContext context, String url) async {
    final uri = Uri.parse(url);
    try {
      final ok = await launchUrl(uri, mode: LaunchMode.externalApplication);
      if (!ok && context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(context.l10n.settingsCouldNotOpenLink)),
        );
      }
    } catch (_) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(context.l10n.settingsCouldNotOpenLink)),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    final l10n = context.l10n;

    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 28),
      children: [
        Text(
          l10n.ourAppsIntro,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: cs.onSurfaceVariant,
            height: 1.35,
          ),
        ),
        const SizedBox(height: 16),
        for (final app in kPortfolioApps) ...[
          _PortfolioAppCard(
            app: app,
            onOpen: app.url == null || app.comingSoon || app.isCurrentApp
                ? null
                : () => _openUrl(context, app.url!),
          ),
          const SizedBox(height: 10),
        ],
        const SizedBox(height: 8),
        OutlinedButton.icon(
          onPressed: () => _openUrl(context, kPortfolioAppsPageUrl),
          icon: const Icon(Icons.open_in_new_rounded, size: 18),
          label: Text(l10n.ourAppsViewOnline),
        ),
      ],
    );
  }
}

class _PortfolioAppCard extends StatelessWidget {
  const _PortfolioAppCard({
    required this.app,
    required this.onOpen,
  });

  final PortfolioApp app;
  final VoidCallback? onOpen;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    final l10n = context.l10n;
    final soon = app.comingSoon;
    final current = app.isCurrentApp;
    final freeColor = AppColors.freeTierOnSurface(theme.brightness);
    final badgeColor = soon
        ? cs.onSurfaceVariant
        : (current ? AppColors.accentOnSurface(theme.brightness) : freeColor);
    final badgeLabel = soon
        ? l10n.ourAppsBadgeSoon
        : (current ? l10n.ourAppsBadgeThisApp : l10n.ourAppsBadgeLive);

    return Material(
      color: cs.surface,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: onOpen,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: soon
                  ? cs.outline.withValues(alpha: 0.55)
                  : badgeColor.withValues(alpha: 0.45),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      app.name,
                      style: theme.textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: badgeColor.withValues(alpha: 0.14),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      badgeLabel,
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: badgeColor,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 0.4,
                      ),
                    ),
                  ),
                  if (onOpen != null) ...[
                    const SizedBox(width: 4),
                    Icon(Icons.open_in_new_rounded, size: 16, color: cs.onSurfaceVariant),
                  ],
                ],
              ),
              const SizedBox(height: 4),
              Text(
                app.tagline(l10n),
                style: theme.textTheme.bodySmall?.copyWith(
                  color: cs.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                app.summary(l10n),
                style: theme.textTheme.bodySmall?.copyWith(
                  color: cs.onSurfaceVariant,
                  height: 1.3,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                app.platforms(l10n),
                style: theme.textTheme.labelSmall?.copyWith(
                  color: cs.onSurfaceVariant,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

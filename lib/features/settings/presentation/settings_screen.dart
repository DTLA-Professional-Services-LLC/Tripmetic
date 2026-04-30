import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../l10n/l10n_helpers.dart';
import '../application/announcements_provider.dart';

/// Support, legal links, and announcements (HTML).
class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  static Future<void> _launch(BuildContext context, String url) async {
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

    final htmlStyle = {
      'body': Style(
        margin: Margins.zero,
        color: cs.onSurface,
        fontSize: FontSize(15),
      ),
      'p': Style(
        margin: Margins.only(bottom: 8),
        lineHeight: LineHeight.number(1.2),
      ),
      'a': Style(
        color: cs.primary,
        textDecoration: TextDecoration.underline,
        fontWeight: FontWeight.w600,
      ),
      'b': Style(fontWeight: FontWeight.w700),
      'i': Style(fontStyle: FontStyle.italic),
    };

    return SafeArea(
      child: CustomScrollView(
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(12, 8, 12, 0),
            sliver: SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _AnnouncementsCard(
                    htmlStyle: htmlStyle,
                    onLinkTap: (url) {
                      if (url != null && url.isNotEmpty) {
                        _launch(context, url);
                      }
                    },
                  ),
                  const SizedBox(height: 16),
                  Text(
                    l10n.settingsSupportLegal,
                    style: theme.textTheme.labelSmall?.copyWith(
                      color: cs.onSurfaceVariant,
                      letterSpacing: 0.8,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Card(
                    elevation: 0,
                    color: cs.surface,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                      side: BorderSide(color: cs.primary.withValues(alpha: 0.28)),
                    ),
                    child: Column(
                      children: [
                        _LinkTile(
                          icon: Icons.help_outline_rounded,
                          title: l10n.settingsHelpFaq,
                          url: 'https://tripmetic.app/support.html',
                          onLaunch: _launch,
                        ),
                        const Divider(height: 1),
                        _LinkTile(
                          icon: Icons.mail_outline_rounded,
                          title: l10n.settingsContact,
                          url: 'https://tripmetic.app/contact.html',
                          onLaunch: _launch,
                        ),
                        const Divider(height: 1),
                        _LinkTile(
                          icon: Icons.privacy_tip_outlined,
                          title: l10n.settingsPrivacy,
                          url: 'https://tripmetic.app/privacy.html',
                          onLaunch: _launch,
                        ),
                        const Divider(height: 1),
                        _LinkTile(
                          icon: Icons.gavel_outlined,
                          title: l10n.settingsTerms,
                          url: 'https://tripmetic.app/terms.html',
                          onLaunch: _launch,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverFillRemaining(
            hasScrollBody: false,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(12, 24, 12, 16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const Spacer(),
                  Center(
                    child: InkWell(
                      onTap: () => _launch(context, 'https://tripmetic.app'),
                      borderRadius: BorderRadius.circular(8),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        child: Text(
                          l10n.settingsCopyright,
                          style: theme.textTheme.labelLarge?.copyWith(
                            color: cs.primary,
                            fontWeight: FontWeight.w600,
                            decoration: TextDecoration.underline,
                            decorationColor: cs.primary.withValues(alpha: 0.6),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

typedef _LaunchFn = Future<void> Function(BuildContext context, String url);

class _AnnouncementsCard extends ConsumerWidget {
  const _AnnouncementsCard({
    required this.htmlStyle,
    required this.onLinkTap,
  });

  final Map<String, Style> htmlStyle;
  final void Function(String? url) onLinkTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    final l10n = context.l10n;
    final async = ref.watch(announcementsHtmlProvider);

    return Card(
      elevation: 2,
      color: cs.primaryContainer.withValues(alpha: 0.35),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
        side: BorderSide(color: cs.primary.withValues(alpha: 0.45)),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(14, 14, 14, 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Icon(Icons.campaign_outlined, color: cs.primary, size: 22),
                const SizedBox(width: 8),
                Text(
                  l10n.announcementsLatest,
                  style: theme.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w800,
                    letterSpacing: 0.4,
                    color: cs.primary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            async.when(
              data: (html) => Html(
                data: html,
                shrinkWrap: true,
                style: htmlStyle,
                onLinkTap: (url, attributes, element) => onLinkTap(url),
              ),
              loading: () => const Padding(
                padding: EdgeInsets.symmetric(vertical: 20),
                child: Center(
                  child: SizedBox(
                    width: 28,
                    height: 28,
                    child: CircularProgressIndicator.adaptive(strokeWidth: 2.5),
                  ),
                ),
              ),
              error: (Object err, StackTrace stackTrace) {
                return Html(
                  data: kFallbackAnnouncementsHtml,
                  shrinkWrap: true,
                  style: htmlStyle,
                  onLinkTap: (url, attributes, element) => onLinkTap(url),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _LinkTile extends StatelessWidget {
  const _LinkTile({
    required this.icon,
    required this.title,
    required this.url,
    required this.onLaunch,
  });

  final IconData icon;
  final String title;
  final String url;
  final _LaunchFn onLaunch;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return ListTile(
      leading: Icon(icon, color: cs.primary),
      title: Text(title),
      trailing: Icon(Icons.open_in_new_rounded, size: 18, color: cs.onSurfaceVariant),
      onTap: () => onLaunch(context, url),
    );
  }
}

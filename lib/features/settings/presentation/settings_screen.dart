import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/locale/app_locale_provider.dart';
import '../../../core/subscription/pro_test_override_provider.dart';
import '../../../core/subscription/revenue_cat_sdk_state.dart';
import '../../../core/subscription/revenue_cat_ui_actions.dart';
import '../../../core/subscription/subscription_nav.dart';
import '../../../core/subscription/subscription_providers.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/theme_mode_provider.dart';
import '../../bucket_list/presentation/bucket_list_backup_sheet.dart';
import '../../../l10n/l10n_helpers.dart';
import '../application/announcements_provider.dart';

/// Grouped settings: app, Tripmetic Pro, account, support & announcements.
class SettingsScreen extends ConsumerWidget {
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
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    final l10n = context.l10n;
    final isPro = ref.watch(isTripmeticProProvider);
    final themeMode = ref.watch(themeModeProvider);
    final localeAsync = ref.watch(appLocaleProvider);

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

    Future<void> pickLanguage() async {
      final current = localeAsync.maybeWhen(data: (v) => v, orElse: () => null);
      await showModalBottomSheet<void>(
        context: context,
        showDragHandle: true,
        builder: (ctx) {
          return SafeArea(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                RadioListTile<Locale?>(
                  title: Text(l10n.settingsLanguageSystem),
                  value: null,
                  groupValue: current,
                  onChanged: (v) async {
                    await ref.read(appLocaleProvider.notifier).setLocale(v);
                    if (ctx.mounted) Navigator.pop(ctx);
                  },
                ),
                RadioListTile<Locale?>(
                  title: Text(l10n.settingsLanguageEnglish),
                  value: const Locale('en'),
                  groupValue: current,
                  onChanged: (v) async {
                    await ref.read(appLocaleProvider.notifier).setLocale(v);
                    if (ctx.mounted) Navigator.pop(ctx);
                  },
                ),
                RadioListTile<Locale?>(
                  title: Text(l10n.settingsLanguageSpanish),
                  value: const Locale('es'),
                  groupValue: current,
                  onChanged: (v) async {
                    await ref.read(appLocaleProvider.notifier).setLocale(v);
                    if (ctx.mounted) Navigator.pop(ctx);
                  },
                ),
              ],
            ),
          );
        },
      );
    }

    Future<void> pickTheme() async {
      await showModalBottomSheet<void>(
        context: context,
        showDragHandle: true,
        builder: (ctx) {
          return SafeArea(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                RadioListTile<ThemeMode>(
                  title: Text(l10n.settingsThemeSystem),
                  value: ThemeMode.system,
                  groupValue: themeMode,
                  onChanged: (v) {
                    if (v == null) return;
                    ref.read(themeModeProvider.notifier).setTheme(v);
                    Navigator.pop(ctx);
                  },
                ),
                RadioListTile<ThemeMode>(
                  title: Text(l10n.settingsThemeLight),
                  value: ThemeMode.light,
                  groupValue: themeMode,
                  onChanged: (v) {
                    if (v == null) return;
                    ref.read(themeModeProvider.notifier).setTheme(v);
                    Navigator.pop(ctx);
                  },
                ),
                RadioListTile<ThemeMode>(
                  title: Text(l10n.settingsThemeDark),
                  value: ThemeMode.dark,
                  groupValue: themeMode,
                  onChanged: (v) {
                    if (v == null) return;
                    ref.read(themeModeProvider.notifier).setTheme(v);
                    Navigator.pop(ctx);
                  },
                ),
              ],
            ),
          );
        },
      );
    }

    String themeLabel() => switch (themeMode) {
          ThemeMode.system => l10n.settingsThemeSystem,
          ThemeMode.light => l10n.settingsThemeLight,
          ThemeMode.dark => l10n.settingsThemeDark,
        };

    String languageLabel() => localeAsync.maybeWhen(
          data: (loc) => switch (loc?.languageCode) {
            'en' => l10n.settingsLanguageEnglish,
            'es' => l10n.settingsLanguageSpanish,
            _ => l10n.settingsLanguageSystem,
          },
          orElse: () => l10n.settingsLanguageSystem,
        );

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
                  const SizedBox(height: 20),
                  Text(
                    l10n.appSettings,
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
                        ListTile(
                          leading: Icon(Icons.straighten_outlined, color: cs.primary),
                          title: Text(l10n.settingsUnitsTitle),
                          trailing: const Icon(Icons.chevron_right_rounded),
                          onTap: () => openNavFeatureFromPath(context, ref, '/units'),
                        ),
                        const Divider(height: 1),
                        ListTile(
                          leading: Icon(Icons.watch_later_outlined, color: cs.primary),
                          title: Text(l10n.settingsClockWidgetTitle),
                          subtitle: Text(l10n.moreToolsDualClockBannerSubtitle),
                          trailing: const Icon(Icons.chevron_right_rounded),
                          onTap: () => context.push('/dual-clock-widget/configure'),
                        ),
                        const Divider(height: 1),
                        ListTile(
                          leading: Icon(Icons.language_outlined, color: cs.primary),
                          title: Text(l10n.settingsLanguageTitle),
                          subtitle: Text(languageLabel()),
                          trailing: const Icon(Icons.chevron_right_rounded),
                          onTap: pickLanguage,
                        ),
                        const Divider(height: 1),
                        ListTile(
                          leading: Icon(Icons.palette_outlined, color: cs.primary),
                          title: Text(l10n.settingsThemeTitle),
                          subtitle: Text(themeLabel()),
                          trailing: const Icon(Icons.chevron_right_rounded),
                          onTap: pickTheme,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    l10n.settingsSectionTripmeticPro,
                    style: theme.textTheme.labelSmall?.copyWith(
                      color: AppColors.accent,
                      letterSpacing: 0.8,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Card(
                    elevation: 0,
                    color: cs.surfaceContainerHighest.withValues(alpha: 0.25),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                      side: BorderSide(color: AppColors.accent.withValues(alpha: 0.55)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.workspace_premium_outlined, color: AppColors.accent),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  isPro ? l10n.settingsSubscriptionActive : l10n.settingsSubscriptionFree,
                                  style: theme.textTheme.titleSmall?.copyWith(
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          if (revenueCatSdkConfigured)
                            ListTile(
                              contentPadding: EdgeInsets.zero,
                              leading: const Icon(Icons.payment_outlined),
                              title: Text(l10n.settingsManageBilling),
                              trailing: const Icon(Icons.open_in_new_rounded, size: 18),
                              onTap: () async {
                                await presentTripmeticCustomerCenter();
                                await ref.read(customerInfoProvider.notifier).sync();
                              },
                            ),
                          if (!isPro && revenueCatSdkConfigured)
                            FilledButton.icon(
                              onPressed: () => context.push('/paywall'),
                              icon: const Icon(Icons.lock_open_rounded, size: 18),
                              label: Text(l10n.upgradeNow),
                            ),
                          if (!kReleaseMode)
                            Consumer(
                              builder: (context, ref, _) {
                                final proOverrideAsync =
                                    ref.watch(proTestOverrideProvider);
                                final proOverride =
                                    proOverrideAsync.valueOrNull ?? false;
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  children: [
                                    const Divider(height: 20),
                                    Text(
                                      l10n.settingsTestModeSectionTitle,
                                      style: theme.textTheme.labelSmall?.copyWith(
                                        color: cs.onSurfaceVariant,
                                        letterSpacing: 0.8,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    SwitchListTile(
                                      contentPadding: EdgeInsets.zero,
                                      value: proOverride,
                                      onChanged: proOverrideAsync.isLoading
                                          ? null
                                          : (v) {
                                              ref
                                                  .read(
                                                    proTestOverrideProvider
                                                        .notifier,
                                                  )
                                                  .setOverride(v);
                                            },
                                      title: Text(l10n.settingsTestModeProTitle),
                                      subtitle:
                                          Text(l10n.settingsTestModeProSubtitle),
                                      secondary: Icon(
                                        Icons.science_outlined,
                                        color: cs.primary,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 4),
                                      child: Text(
                                        l10n.settingsTestModeProCaption,
                                        style: theme.textTheme.bodySmall?.copyWith(
                                          color: cs.onSurfaceVariant,
                                          height: 1.35,
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    l10n.settingsSectionAccount,
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
                        ListTile(
                          leading: Icon(Icons.manage_accounts_outlined, color: cs.primary),
                          title: Text(l10n.accountManagementListTitle),
                          subtitle: Text(l10n.accountManagementListSubtitle),
                          trailing: const Icon(Icons.chevron_right_rounded),
                          onTap: () => context.push('/account'),
                        ),
                        const Divider(height: 1),
                        ListTile(
                          leading: Icon(Icons.person_outline_rounded, color: cs.primary),
                          title: Text(l10n.settingsProfileTitle),
                          trailing: const Icon(Icons.chevron_right_rounded),
                          onTap: () => showBucketListBackupSheet(context),
                        ),
                        const Divider(height: 1),
                        ListTile(
                          leading: Icon(Icons.logout_rounded, color: cs.primary),
                          title: Text(l10n.settingsLogout),
                          onTap: () async {
                            final ok = await showDialog<bool>(
                              context: context,
                              builder: (ctx) => AlertDialog(
                                title: Text(l10n.settingsLogout),
                                content: Text(l10n.settingsLogoutConfirm),
                                actions: [
                                  TextButton(
                                    onPressed: () => Navigator.pop(ctx, false),
                                    child: Text(l10n.commonCancel),
                                  ),
                                  FilledButton(
                                    onPressed: () => Navigator.pop(ctx, true),
                                    child: Text(l10n.settingsLogout),
                                  ),
                                ],
                              ),
                            );
                            if (ok == true && context.mounted) {
                              await FirebaseAuth.instance.signOut();
                              if (context.mounted) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text(l10n.settingsLogout)),
                                );
                              }
                            }
                          },
                        ),
                        const Divider(height: 1),
                        ListTile(
                          leading: Icon(Icons.delete_forever_outlined, color: cs.error),
                          title: Text(
                            l10n.settingsDeleteAccount,
                            style: TextStyle(color: cs.error),
                          ),
                          onTap: () async {
                            await showDialog<void>(
                              context: context,
                              builder: (ctx) => AlertDialog(
                                title: Text(l10n.settingsDeleteAccount),
                                content: Text(l10n.settingsDeleteAccountBody),
                                actions: [
                                  TextButton(
                                    onPressed: () => Navigator.pop(ctx),
                                    child: Text(l10n.commonOk),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
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
                        const Divider(height: 1),
                        ListTile(
                          leading: Icon(Icons.map_outlined, color: cs.primary),
                          title: Text(l10n.settingsMapboxAttributionTitle),
                          subtitle: Text(l10n.settingsMapboxAttributionBody),
                          isThreeLine: true,
                        ),
                        const Divider(height: 1),
                        _LinkTile(
                          icon: Icons.open_in_new_rounded,
                          title: l10n.settingsMapboxAttributionMapboxLink,
                          url: 'https://www.mapbox.com/about/maps/',
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

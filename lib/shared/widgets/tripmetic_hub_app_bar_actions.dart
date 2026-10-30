import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/navigation/tripmetic_home_navigation.dart';
import '../../core/theme/theme_mode_provider.dart';
import '../../features/bucket_list/application/bucket_list_auth_providers.dart';
import '../../features/bucket_list/presentation/bucket_list_backup_sheet.dart';
import '../../l10n/l10n_helpers.dart';

Future<void> _openSettingsRoute(BuildContext context) async {
  if (!context.mounted) return;
  context.push('/settings');
}

/// Same hub actions as [MainScreen] (account/backup, theme, settings).
List<Widget> tripmeticHubAppBarActions(BuildContext context, WidgetRef ref) {
  final l10n = context.l10n;
  final themeMode = ref.watch(themeModeProvider).valueOrNull ?? ThemeMode.dark;
  final authAsync = ref.watch(firebaseAuthUserProvider);
  return [
    IconButton(
      tooltip: l10n.navMoreMenu,
      icon: const Icon(Icons.apps_rounded),
      onPressed: () => openTripmeticMoreMenu(context, ref),
    ),
    IconButton(
      tooltip: authAsync.when(
        data: (u) => u != null
            ? l10n.globalNavAccountCloudSyncTooltip
            : l10n.bucketListBackupTooltip,
        loading: () => l10n.bucketListBackupTooltip,
        error: (_, _) => l10n.bucketListBackupTooltip,
      ),
      icon: authAsync.maybeWhen(
        data: (u) => Icon(
          u != null
              ? Icons.account_circle_outlined
              : Icons.cloud_upload_outlined,
        ),
        loading: () => const SizedBox(
          width: 22,
          height: 22,
          child: CircularProgressIndicator(strokeWidth: 2),
        ),
        error: (_, _) => const Icon(Icons.cloud_upload_outlined),
        orElse: () => const Icon(Icons.cloud_upload_outlined),
      ),
      onPressed: () => showBucketListBackupSheet(context),
    ),
    IconButton(
      tooltip: themeMode == ThemeMode.dark ? 'Light mode' : 'Dark mode',
      icon: Icon(
        themeMode == ThemeMode.dark
            ? Icons.light_mode_outlined
            : Icons.dark_mode_outlined,
      ),
      onPressed: () => ref.read(themeModeProvider.notifier).toggle(),
    ),
    IconButton(
      tooltip: l10n.settingsAndInfo,
      icon: const Icon(Icons.settings_outlined),
      onPressed: () => _openSettingsRoute(context),
    ),
  ];
}
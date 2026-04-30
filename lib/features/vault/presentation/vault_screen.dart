import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/app_colors.dart';
import '../../../l10n/l10n_helpers.dart';
import '../application/vault_providers.dart';
import 'presentation_mode_screen.dart';
import 'vault_tile.dart';

class VaultScreen extends ConsumerWidget {
  const VaultScreen({super.key});

  // The predefined categories
  static const List<Map<String, dynamic>> _categories = [
    {'name': 'Visa', 'icon': Icons.fact_check_outlined},
    {'name': 'Return Flight', 'icon': Icons.flight_takeoff_rounded},
    {'name': 'Arrival Card', 'icon': Icons.assignment_ind_outlined},
    {'name': 'Passport Copy', 'icon': Icons.perm_identity_rounded},
    {'name': 'Hotel Reservation', 'icon': Icons.hotel_rounded},
    {'name': 'Other', 'icon': Icons.folder_open_rounded},
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final documents = ref.watch(vaultProvider);
    final theme = Theme.of(context);
    final l10n = context.l10n;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_rounded, color: AppColors.textPrimary),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 4),
              child: Row(
                children: [
                  Container(
                    width: 4,
                    height: 22,
                    decoration: BoxDecoration(
                      color: AppColors.accent,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    l10n.vaultDocumentTitle,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w800,
                      letterSpacing: 0.4,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(width: 6),
                  Text(
                    l10n.vaultVaultWord,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w500,
                      color: AppColors.accent.withValues(alpha: 0.95),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Text(
                l10n.vaultIntro,
                style: theme.textTheme.bodyMedium?.copyWith(color: AppColors.textSecondary),
              ),
            ),
            Expanded(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final crossAxisCount = constraints.maxWidth > 600 ? 3 : 2;
                  return GridView.builder(
                    padding: const EdgeInsets.all(16),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: crossAxisCount,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                      childAspectRatio: 0.85,
                    ),
                    itemCount: _categories.length,
                    itemBuilder: (context, index) {
                      final category = _categories[index]['name'] as String;
                      final icon = _categories[index]['icon'] as IconData;
                      
                      final document = documents.where((d) => d.category == category).firstOrNull;

                      return VaultTile(
                        category: vaultCategoryTitle(l10n, category),
                        document: document,
                        iconData: icon,
                        onTap: () async {
                          if (document != null) {
                            // Open Presentation Mode
                            final result = await Navigator.of(context).push<String>(
                              PageRouteBuilder(
                                transitionDuration: const Duration(milliseconds: 300),
                                reverseTransitionDuration: const Duration(milliseconds: 250),
                                pageBuilder: (context, animation, secondaryAnimation) {
                                  return FadeTransition(
                                    opacity: animation,
                                    child: PresentationModeScreen(document: document),
                                  );
                                },
                              ),
                            );
                            if (result == 'delete') {
                              await ref.read(vaultProvider.notifier).deleteDocument(category);
                            }
                          } else {
                            try {
                              await ref.read(vaultProvider.notifier).pickAndSaveDocument(category);
                            } catch (e) {
                              if (context.mounted) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text(l10n.vaultProcessFailed('$e'))),
                                );
                              }
                            }
                          }
                        },
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

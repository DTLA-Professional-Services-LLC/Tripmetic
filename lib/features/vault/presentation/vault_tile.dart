import 'package:flutter/material.dart';
import '../../../l10n/l10n_helpers.dart';
import '../domain/vault_document.dart';

class VaultTile extends StatelessWidget {
  const VaultTile({
    super.key,
    required this.category,
    required this.document,
    required this.iconData,
    required this.onTap,
  });

  final String category;
  final VaultDocument? document;
  final IconData iconData;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    final l10n = context.l10n;
    final hasDoc = document != null;
    
    return Hero(
      tag: 'vault_$category',
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16),
          child: Container(
            decoration: BoxDecoration(
              color: cs.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: hasDoc ? cs.primary.withValues(alpha: 0.55) : cs.outlineVariant,
                width: hasDoc ? 1.5 : 1.0,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.2),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      iconData,
                      color: hasDoc ? cs.primary : cs.onSurfaceVariant,
                      size: 28,
                    ),
                    if (hasDoc)
                      Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: Colors.teal.withValues(alpha: 0.2),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.check_rounded,
                          color: Colors.teal,
                          size: 16,
                        ),
                      )
                    else
                      Icon(
                        Icons.add_circle_outline_rounded,
                        color: cs.onSurfaceVariant.withValues(alpha: 0.55),
                        size: 20,
                      ),
                  ],
                ),
                const SizedBox(height: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      category,
                      style: theme.textTheme.titleMedium?.copyWith(
                        color: cs.onSurface,
                        fontWeight: FontWeight.w700,
                        fontSize: 15,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      hasDoc ? l10n.vaultTapToView : l10n.vaultTapToUpload,
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: hasDoc ? cs.primary : cs.onSurfaceVariant,
                        fontWeight: hasDoc ? FontWeight.w600 : FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

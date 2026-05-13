import 'package:flutter/material.dart';

import '../../core/constants/app_brand.dart';

/// App name shown at the top of every screen; optional [subtitle] for context.
class TripmeticAppBarTitle extends StatelessWidget {
  const TripmeticAppBarTitle({super.key, this.subtitle});

  final String? subtitle;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          AppBrand.wordmark,
          style: TextStyle(
            fontWeight: FontWeight.w800,
            letterSpacing: 0.6,
            fontSize: theme.textTheme.titleMedium?.fontSize ?? 18,
            height: theme.textTheme.titleMedium?.height ?? 1.25,
            color: cs.primary,
          ),
        ),
        if (subtitle != null && subtitle!.isNotEmpty) ...[
          const SizedBox(height: 2),
          Text(
            subtitle!,
            style: TextStyle(
              color: cs.onSurfaceVariant,
              fontWeight: FontWeight.w500,
              fontSize: theme.textTheme.labelSmall?.fontSize ?? 11,
              height: theme.textTheme.labelSmall?.height ?? 1.3,
            ),
          ),
        ],
      ],
    );
  }
}

import 'package:flutter/material.dart';

import '../../core/constants/app_brand.dart';

/// App name shown at the top of every screen; optional [subtitle] for context.
class TripmeticAppBarTitle extends StatelessWidget {
  const TripmeticAppBarTitle({super.key, this.subtitle});

  final String? subtitle;

  /// Room for wordmark + optional subtitle without vertical clipping.
  static const double toolbarHeightWithSubtitle = 64;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        FittedBox(
          fit: BoxFit.scaleDown,
          alignment: Alignment.center,
          child: Text(
            AppBrand.wordmark,
            maxLines: 1,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.w800,
              letterSpacing: 0.35,
              fontSize: theme.textTheme.titleMedium?.fontSize ?? 18,
              height: 1.15,
              color: cs.primary,
            ),
          ),
        ),
        if (subtitle != null && subtitle!.isNotEmpty) ...[
          const SizedBox(height: 2),
          FittedBox(
            fit: BoxFit.scaleDown,
            alignment: Alignment.center,
            child: Text(
              subtitle!,
              maxLines: 1,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: cs.onSurfaceVariant,
                fontWeight: FontWeight.w500,
                fontSize: theme.textTheme.labelSmall?.fontSize ?? 11,
                height: 1.2,
              ),
            ),
          ),
        ],
      ],
    );
  }
}

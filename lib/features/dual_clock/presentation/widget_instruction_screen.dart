import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../l10n/l10n_helpers.dart';

/// How to add the dual-clock widget on iOS vs Android.
class WidgetInstructionScreen extends StatefulWidget {
  const WidgetInstructionScreen({super.key});

  @override
  State<WidgetInstructionScreen> createState() => _WidgetInstructionScreenState();
}

class _WidgetInstructionScreenState extends State<WidgetInstructionScreen> {
  int _platformSegment = 0; // 0 = iOS, 1 = Android

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final theme = Theme.of(context);
    final cs = theme.colorScheme;

    final steps = _platformSegment == 0
        ? [
            l10n.widgetInstructionIosStep1,
            l10n.widgetInstructionIosStep2,
            l10n.widgetInstructionIosStep3,
            l10n.widgetInstructionIosStep4,
          ]
        : [
            l10n.widgetInstructionAndroidStep1,
            l10n.widgetInstructionAndroidStep2,
            l10n.widgetInstructionAndroidStep3,
            l10n.widgetInstructionAndroidStep4,
            l10n.widgetInstructionAndroidLockScreenHint,
          ];

    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 8),
                Center(
                  child: Container(
                    padding: const EdgeInsets.all(22),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: cs.primaryContainer.withValues(alpha: 0.5),
                      border: Border.all(color: cs.primary.withValues(alpha: 0.35)),
                    ),
                    child: Icon(Icons.schedule_rounded, size: 48, color: cs.primary),
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  l10n.widgetInstructionTitle,
                  textAlign: TextAlign.center,
                  style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w800),
                ),
                const SizedBox(height: 10),
                Text(
                  l10n.widgetInstructionSubtitle,
                  textAlign: TextAlign.center,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: cs.onSurfaceVariant,
                    height: 1.35,
                  ),
                ),
                const SizedBox(height: 24),
                SegmentedButton<int>(
                  segments: [
                    ButtonSegment<int>(
                      value: 0,
                      label: Text(l10n.widgetInstructionTabIos),
                      icon: const Icon(Icons.phone_iphone_rounded, size: 18),
                    ),
                    ButtonSegment<int>(
                      value: 1,
                      label: Text(l10n.widgetInstructionTabAndroid),
                      icon: const Icon(Icons.android_rounded, size: 18),
                    ),
                  ],
                  selected: {_platformSegment},
                  onSelectionChanged: (s) {
                    setState(() => _platformSegment = s.first);
                  },
                ),
                const SizedBox(height: 24),
                ...List.generate(steps.length, (i) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 14),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          radius: 16,
                          backgroundColor: cs.primary.withValues(alpha: 0.15),
                          foregroundColor: cs.primary,
                          child: Text(
                            '${i + 1}',
                            style: theme.textTheme.labelLarge?.copyWith(
                              fontWeight: FontWeight.w800,
                              color: cs.primary,
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            steps[i],
                            style: theme.textTheme.bodyLarge?.copyWith(height: 1.4),
                          ),
                        ),
                      ],
                    ),
                  );
                }),
              ],
            ),
          ),
        ),
        Material(
          elevation: 8,
          color: theme.scaffoldBackgroundColor,
          child: SafeArea(
            top: false,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => context.push('/dual-clock-widget/configure'),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    backgroundColor: cs.primary,
                    foregroundColor: cs.onPrimary,
                  ),
                  child: Text(l10n.widgetInstructionConfigureCta),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

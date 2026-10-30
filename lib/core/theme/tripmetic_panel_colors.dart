import 'package:flutter/material.dart';

/// Shared panel/input colors for feature screens (budget, mind map, etc.).
@immutable
class TripmeticPanelColors extends ThemeExtension<TripmeticPanelColors> {
  const TripmeticPanelColors({
    required this.panel,
    required this.panelBorder,
    required this.inputFill,
    required this.inputBorder,
    required this.muted,
    required this.toolbar,
    required this.toolbarBorder,
    required this.canvasDot,
  });

  final Color panel;
  final Color panelBorder;
  final Color inputFill;
  final Color inputBorder;
  final Color muted;
  final Color toolbar;
  final Color toolbarBorder;
  final Color canvasDot;

  static const TripmeticPanelColors dark = TripmeticPanelColors(
    panel: Color(0xFF1E293B),
    panelBorder: Color(0xFF334155),
    inputFill: Color(0xFF293548),
    inputBorder: Color(0xFF475569),
    muted: Color(0xFF94A3B8),
    toolbar: Color(0xFF152238),
    toolbarBorder: Color(0xFF243556),
    canvasDot: Color(0xFF334155),
  );

  static TripmeticPanelColors light(ColorScheme scheme) => TripmeticPanelColors(
        panel: scheme.surfaceContainerHighest,
        panelBorder: scheme.outline,
        inputFill: scheme.surface,
        inputBorder: scheme.outline,
        muted: scheme.onSurfaceVariant,
        toolbar: scheme.surfaceContainerHighest,
        toolbarBorder: scheme.outlineVariant,
        canvasDot: scheme.outline,
      );

  @override
  TripmeticPanelColors copyWith({
    Color? panel,
    Color? panelBorder,
    Color? inputFill,
    Color? inputBorder,
    Color? muted,
    Color? toolbar,
    Color? toolbarBorder,
    Color? canvasDot,
  }) {
    return TripmeticPanelColors(
      panel: panel ?? this.panel,
      panelBorder: panelBorder ?? this.panelBorder,
      inputFill: inputFill ?? this.inputFill,
      inputBorder: inputBorder ?? this.inputBorder,
      muted: muted ?? this.muted,
      toolbar: toolbar ?? this.toolbar,
      toolbarBorder: toolbarBorder ?? this.toolbarBorder,
      canvasDot: canvasDot ?? this.canvasDot,
    );
  }

  @override
  TripmeticPanelColors lerp(ThemeExtension<TripmeticPanelColors>? other, double t) {
    if (other is! TripmeticPanelColors) return this;
    return TripmeticPanelColors(
      panel: Color.lerp(panel, other.panel, t)!,
      panelBorder: Color.lerp(panelBorder, other.panelBorder, t)!,
      inputFill: Color.lerp(inputFill, other.inputFill, t)!,
      inputBorder: Color.lerp(inputBorder, other.inputBorder, t)!,
      muted: Color.lerp(muted, other.muted, t)!,
      toolbar: Color.lerp(toolbar, other.toolbar, t)!,
      toolbarBorder: Color.lerp(toolbarBorder, other.toolbarBorder, t)!,
      canvasDot: Color.lerp(canvasDot, other.canvasDot, t)!,
    );
  }
}

TripmeticPanelColors tripmeticPanels(BuildContext context) {
  return Theme.of(context).extension<TripmeticPanelColors>() ??
      TripmeticPanelColors.dark;
}

/// Theme-aware colors for floating panels, bottom sheets, and map overlays.
@immutable
class TripmeticOverlayColors {
  const TripmeticOverlayColors({
    required this.panel,
    required this.nested,
    required this.onPanel,
    required this.muted,
    required this.border,
  });

  final Color panel;
  final Color nested;
  final Color onPanel;
  final Color muted;
  final Color border;
}

TripmeticOverlayColors tripmeticOverlayColors(BuildContext context) {
  final scheme = Theme.of(context).colorScheme;
  final panels = tripmeticPanels(context);
  return TripmeticOverlayColors(
    panel: panels.panel,
    nested: panels.inputFill,
    onPanel: scheme.onSurface,
    muted: scheme.onSurfaceVariant,
    border: panels.panelBorder,
  );
}

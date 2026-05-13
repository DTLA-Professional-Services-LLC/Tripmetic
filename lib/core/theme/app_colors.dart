import 'package:flutter/material.dart';

/// The Executive — deep Oxford blue, lighter navy surfaces, champagne gold accents.
abstract final class AppColors {
  /// Scaffold / page background (Oxford blue).
  static const Color background = Color(0xFF0B132B);

  /// Cards, panels, bottom bar strip.
  static const Color surface = Color(0xFF1C2541);

  /// Nested fields on surfaces (e.g. inputs on cards).
  static const Color surfaceContainer = Color(0xFF243556);

  /// Primary text (crisp white).
  static const Color textPrimary = Color(0xFFFFFFFF);

  /// Secondary / captions (soft silver).
  static const Color textSecondary = Color(0xFF94A3B8);

  /// Champagne gold — active states, primary actions, highlights.
  static const Color accent = Color(0xFFD4AF37);

  /// Teal — always-free tools (settings, unit converter, dual clock), distinct from Pro gold.
  static const Color freeTier = Color(0xFF5EEAD4);

  /// Subtle borders on navy UI.
  static const Color borderSubtle = Color(0xFF3D4F6B);

  /// App bar (aligned with card navy for a lifted strip).
  static const Color appBarBackground = Color(0xFF1C2541);

  static const Color appBarForeground = Color(0xFFFFFFFF);

  /// Bottom navigation bar.
  static const Color navBarBackground = Color(0xFF1C2541);

  /// Unselected tab icons / labels.
  static const Color navIconUnselected = Color(0xFF94A3B8);

  /// Text/icons on gold-filled controls.
  static const Color onAccent = Color(0xFF0B132B);
}

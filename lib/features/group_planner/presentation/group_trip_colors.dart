import 'package:flutter/material.dart';

/// Parses `#RGB`, `#RRGGBB`, or `#AARRGGBB` for member activity accents.
Color parseTripPlannerHexColor(String? raw, {Color fallback = const Color(0xFF64748B)}) {
  if (raw == null || raw.trim().isEmpty) return fallback;
  var h = raw.trim();
  if (h.startsWith('#')) h = h.substring(1);
  if (h.length == 6) {
    final v = int.tryParse(h, radix: 16);
    if (v == null) return fallback;
    return Color(0xFF000000 | v);
  }
  if (h.length == 8) {
    final v = int.tryParse(h, radix: 16);
    if (v == null) return fallback;
    return Color(v);
  }
  return fallback;
}

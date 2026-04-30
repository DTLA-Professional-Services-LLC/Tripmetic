import 'package:flutter/material.dart';

/// Subtle dot grid on the mind map canvas (slate on navy).
class MindMapDotGridPainter extends CustomPainter {
  MindMapDotGridPainter({this.spacing = 28, this.dotRadius = 1.1});

  final double spacing;
  final double dotRadius;

  static const Color _dot = Color(0xFF334155);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = _dot.withValues(alpha: 0.45)
      ..isAntiAlias = true;
    for (var x = 0.0; x < size.width; x += spacing) {
      for (var y = 0.0; y < size.height; y += spacing) {
        canvas.drawCircle(Offset(x, y), dotRadius, paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant MindMapDotGridPainter oldDelegate) {
    return oldDelegate.spacing != spacing || oldDelegate.dotRadius != dotRadius;
  }
}

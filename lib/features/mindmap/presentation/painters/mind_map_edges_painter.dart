import 'package:flutter/material.dart';

import '../../domain/mind_map_layout.dart';
import '../../domain/mind_map_node.dart';

/// Bézier connectors from parent (right center) to child (left center).
class MindMapEdgesPainter extends CustomPainter {
  MindMapEdgesPainter({
    required this.nodes,
    this.lineColor = const Color(0xFFD4AF37),
    this.strokeWidth = 2,
  });

  final List<MindMapNode> nodes;
  final Color lineColor;
  final double strokeWidth;

  @override
  void paint(Canvas canvas, Size size) {
    if (nodes.isEmpty) return;

    final paint = Paint()
      ..color = lineColor.withValues(alpha: 0.65)
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..isAntiAlias = true;

    final byId = <String, MindMapNode>{for (final n in nodes) n.id: n};

    for (final n in nodes) {
      final pid = n.parentId;
      if (pid == null) continue;
      final p = byId[pid];
      if (p == null) continue;

      final bool isRightChild = n.x > p.x;

      final start = Offset(
        isRightChild ? p.x + MindMapLayout.nodeWidth : p.x,
        p.y + MindMapLayout.nodeHeight / 2,
      );
      final end = Offset(
        isRightChild ? n.x : n.x + MindMapLayout.nodeWidth,
        n.y + MindMapLayout.nodeHeight / 2,
      );

      final horizontal = (end.dx - start.dx).abs() * 0.5 + 32;
      final c1 = Offset(isRightChild ? start.dx + horizontal : start.dx - horizontal, start.dy);
      final c2 = Offset(isRightChild ? end.dx - horizontal : end.dx + horizontal, end.dy);

      final path = Path()
        ..moveTo(start.dx, start.dy)
        ..cubicTo(c1.dx, c1.dy, c2.dx, c2.dy, end.dx, end.dy);
      canvas.drawPath(path, paint);
    }
  }

  @override
  bool shouldRepaint(covariant MindMapEdgesPainter oldDelegate) {
    if (oldDelegate.lineColor != lineColor || oldDelegate.strokeWidth != strokeWidth) {
      return true;
    }
    if (identical(oldDelegate.nodes, nodes)) return false;
    if (oldDelegate.nodes.length != nodes.length) return true;

    // Edges depend on geometry + parentId, not list ordering (tiles can be re-stacked).
    final oldById = {for (final n in oldDelegate.nodes) n.id: n};
    if (oldById.length != oldDelegate.nodes.length) return true;
    for (final n in nodes) {
      final o = oldById[n.id];
      if (o == null) return true;
      if (o.x != n.x || o.y != n.y || o.parentId != n.parentId) return true;
    }
    return false;
  }
}

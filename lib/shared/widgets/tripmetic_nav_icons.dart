import 'dart:math' as math;

import 'package:flutter/material.dart';

/// Premium geometric tab icons (gold active, soft silver inactive via [color]).
enum TripmeticNavIconKind { currency, timeDate, budget, packing }

class TripmeticNavIcon extends StatelessWidget {
  const TripmeticNavIcon({
    super.key,
    required this.kind,
    required this.color,
    this.size = 24,
  });

  final TripmeticNavIconKind kind;
  final Color color;
  final double size;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: CustomPaint(
        painter: _TripmeticNavIconPainter(kind: kind, color: color),
      ),
    );
  }
}

class _TripmeticNavIconPainter extends CustomPainter {
  _TripmeticNavIconPainter({required this.kind, required this.color});

  final TripmeticNavIconKind kind;
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final stroke = (w * 0.085).clamp(1.2, 2.0);
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = stroke
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    switch (kind) {
      case TripmeticNavIconKind.currency:
        _paintCurrency(canvas, w, paint, stroke);
        break;
      case TripmeticNavIconKind.timeDate:
        _paintTimeDate(canvas, w, paint, stroke);
        break;
      case TripmeticNavIconKind.budget:
        _paintBudget(canvas, w, paint, stroke);
        break;
      case TripmeticNavIconKind.packing:
        _paintPacking(canvas, w, paint, stroke);
        break;
    }
  }

  /// Sync ring + chain links + currency marks.
  void _paintCurrency(Canvas canvas, double w, Paint paint, double stroke) {
    final cx = w / 2;
    final cy = w / 2;
    final r = w * 0.34;
    // Interlocking arcs (chain / sync motif).
    canvas.drawArc(
      Rect.fromCircle(center: Offset(cx, cy), radius: r),
      -math.pi * 0.15,
      math.pi * 1.35,
      false,
      paint,
    );
    canvas.drawArc(
      Rect.fromCircle(center: Offset(cx, cy), radius: r),
      math.pi * 0.85,
      math.pi * 1.35,
      false,
      paint,
    );
    // Small link circles on the ring.
    final pr = w * 0.055;
    canvas.drawCircle(Offset(cx + r * 0.65, cy - r * 0.35), pr, paint);
    canvas.drawCircle(Offset(cx - r * 0.65, cy + r * 0.35), pr, paint);

    final sym = TextPainter(
      text: TextSpan(
        text: r'$ €',
        style: TextStyle(
          color: paint.color,
          fontSize: w * 0.26,
          fontWeight: FontWeight.w700,
          height: 1,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    sym.paint(canvas, Offset(cx - sym.width / 2, cy - sym.height / 2 - w * 0.02));
  }

  /// Clock + overlap arc (dual-time cue).
  void _paintTimeDate(Canvas canvas, double w, Paint paint, double stroke) {
    final cx = w / 2;
    final cy = w / 2;
    final r = w * 0.38;
    canvas.drawCircle(Offset(cx, cy), r, paint);
    // Simplified quadrant ticks.
    for (var i = 0; i < 4; i++) {
      final a = i * math.pi / 2 - math.pi / 2;
      final tick = Paint()
        ..color = paint.color
        ..strokeWidth = stroke * 1.1
        ..strokeCap = StrokeCap.round;
      canvas.drawLine(
        Offset(cx + (r - w * 0.04) * math.cos(a), cy + (r - w * 0.04) * math.sin(a)),
        Offset(cx + (r - w * 0.14) * math.cos(a), cy + (r - w * 0.14) * math.sin(a)),
        tick,
      );
    }
    final hands = Paint()
      ..color = paint.color
      ..strokeWidth = stroke
      ..strokeCap = StrokeCap.round;
    canvas.drawLine(Offset(cx, cy), Offset(cx + r * 0.45, cy - r * 0.1), hands);
    canvas.drawLine(Offset(cx, cy), Offset(cx - r * 0.35, cy + r * 0.28), hands);
    final overlap = Paint()
      ..color = paint.color
      ..style = PaintingStyle.stroke
      ..strokeWidth = stroke * 0.75
      ..strokeCap = StrokeCap.round;
    canvas.drawArc(
      Rect.fromCircle(center: Offset(cx, cy), radius: r * 0.72),
      math.pi * 0.1,
      math.pi * 0.55,
      false,
      overlap,
    );
  }

  /// Wallet + bar chart stems from brand mark.
  void _paintBudget(Canvas canvas, double w, Paint paint, double stroke) {
    final left = w * 0.14;
    final top = w * 0.22;
    final bodyW = w * 0.72;
    final bodyH = w * 0.5;
    final r = w * 0.08;
    final rect = RRect.fromRectAndRadius(
      Rect.fromLTWH(left, top, bodyW, bodyH),
      Radius.circular(r),
    );
    canvas.drawRRect(rect, paint);
    canvas.drawLine(Offset(left + w * 0.12, top + bodyH * 0.38), Offset(left + bodyW - w * 0.12, top + bodyH * 0.38), paint);
    // Bars inside wallet.
    final bx0 = left + bodyW * 0.28;
    final by = top + bodyH * 0.52;
    final bw = w * 0.09;
    final g = w * 0.06;
    final h1 = w * 0.12;
    final h2 = w * 0.18;
    final h3 = w * 0.24;
    final fill = Paint()
      ..color = paint.color
      ..style = PaintingStyle.fill;
    canvas.drawRect(Rect.fromLTWH(bx0, by - h1, bw, h1), fill);
    canvas.drawRect(Rect.fromLTWH(bx0 + bw + g, by - h2, bw, h2), fill);
    canvas.drawRect(Rect.fromLTWH(bx0 + 2 * (bw + g), by - h3, bw, h3), fill);
  }

  /// Luggage + checkmarks.
  void _paintPacking(Canvas canvas, double w, Paint paint, double stroke) {
    final left = w * 0.22;
    final top = w * 0.2;
    final bodyW = w * 0.56;
    final bodyH = w * 0.42;
    final rr = w * 0.06;
    canvas.drawRRect(
      RRect.fromRectAndRadius(Rect.fromLTWH(left, top, bodyW, bodyH), Radius.circular(rr)),
      paint,
    );
    canvas.drawLine(Offset(left + bodyW * 0.35, top), Offset(left + bodyW * 0.35, top - w * 0.1), paint);
    canvas.drawLine(Offset(left + bodyW * 0.65, top), Offset(left + bodyW * 0.65, top - w * 0.1), paint);
    canvas.drawLine(Offset(left + bodyW * 0.35, top - w * 0.1), Offset(left + bodyW * 0.65, top - w * 0.1), paint);
    // Checks on body.
    final chk = Paint()
      ..color = paint.color
      ..style = PaintingStyle.stroke
      ..strokeWidth = stroke * 0.9
      ..strokeCap = StrokeCap.round;
    final y1 = top + bodyH * 0.35;
    canvas.drawLine(Offset(left + w * 0.1, y1), Offset(left + w * 0.18, y1 + w * 0.06), chk);
    canvas.drawLine(Offset(left + w * 0.18, y1 + w * 0.06), Offset(left + w * 0.32, y1 - w * 0.04), chk);
    final y2 = top + bodyH * 0.62;
    canvas.drawLine(Offset(left + bodyW - w * 0.32, y2), Offset(left + bodyW - w * 0.24, y2 + w * 0.06), chk);
    canvas.drawLine(Offset(left + bodyW - w * 0.24, y2 + w * 0.06), Offset(left + bodyW - w * 0.1, y2 - w * 0.04), chk);
  }

  @override
  bool shouldRepaint(covariant _TripmeticNavIconPainter oldDelegate) {
    return oldDelegate.kind != kind || oldDelegate.color != color;
  }
}

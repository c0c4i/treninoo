import 'package:flutter/material.dart';
import 'package:treninoo/view/style/colors/black.dart';
import 'package:treninoo/view/style/colors/grey.dart';

class CanceledOverlayPainter extends CustomPainter {
  final bool isDarkMode;

  CanceledOverlayPainter({required this.isDarkMode});

  @override
  void paint(Canvas canvas, Size size) {
    // Background color
    final bgPaint = Paint()
      ..color = isDarkMode ? Black.lightest2 : Grey.lighter;
    canvas.drawRect(Offset.zero & size, bgPaint);

    // Stripe color
    final stripePaint = Paint()
      ..color = isDarkMode ? Black.lighter : Grey.light
      ..strokeWidth = 2;

    const gap = 24; // distance between stripes

    // Draw 45° lines
    for (double x = -size.height; x < size.width; x += gap) {
      canvas.drawLine(
        Offset(x, 0),
        Offset(x + size.height, size.height),
        stripePaint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

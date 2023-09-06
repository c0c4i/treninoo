import 'package:flutter/material.dart';
import 'package:treninoo/view/style/colors/grey.dart';

class VerticalDotLinePainter extends CustomPainter {
  final padding = 2.0;
  final radius = 4.0;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Grey.dark
      ..style = PaintingStyle.stroke // Set the style to outline
      ..strokeWidth = 2.0;

    // Draw the first dot
    canvas.drawCircle(Offset(size.width / 2, padding), radius, paint);

    // Draw the second dot
    canvas.drawCircle(
        Offset(size.width / 2, size.height - padding), radius, paint);

    // Draw the line connecting the dots
    canvas.drawLine(
      Offset(size.width / 2, padding + radius),
      Offset(size.width / 2, size.height - padding - radius),
      paint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

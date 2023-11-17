import 'package:flutter/material.dart';

class BubblePainter extends CustomPainter {
  final bool isUser1;
  final Color bubbleColor;

  BubblePainter({required this.bubbleColor, required this.isUser1});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = bubbleColor
      ..style = PaintingStyle.fill;

    Path path = Path();
    path.lineTo(-5, 0);
    path.lineTo(0, 10);
    path.lineTo(5, 0);


    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

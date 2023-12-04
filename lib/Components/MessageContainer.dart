import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WaterDropletsPainter extends CustomPainter {
  final double animationValue;

  WaterDropletsPainter(this.animationValue);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 2.0;

    final dropletRadius = 5.0;

    final dropletX = size.width / 2;
    final dropletY = size.height * animationValue;

    canvas.drawCircle(Offset(dropletX, dropletY), dropletRadius, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
import 'package:flutter/material.dart';
import 'dart:ui' as ui;

class ImagePainter extends CustomPainter {
  ImagePainter({required this.image, required this.color});

  ui.Image image;
  Color color;

  List<Offset> points = [];

  void update(Offset offset) {
    points.add(offset);
  }

  Paint loadPainter() {
    final Paint painter = Paint()
      ..color = color
      ..style = PaintingStyle.fill;
    return painter;
  }

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawImage(image, const Offset(0.0, 0.0), Paint());
    for (Offset offset in points) {
      canvas.drawCircle(offset, 10, loadPainter());
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

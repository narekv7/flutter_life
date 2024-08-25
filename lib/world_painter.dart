import 'package:flutter/material.dart';
import 'package:life/world.dart';

class WorldPainter extends CustomPainter {
  final World world;

  const WorldPainter({
    required this.world,
  });

  @override
  void paint(Canvas canvas, Size size) {
    const cellSize = 3.5;

    final paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    for (int i = 0; i < world.length; i++) {
      for (int j = 0; j < world[i].length; j++) {
        if (world[i][j]) {
          canvas.drawRect(
            Rect.fromLTWH(
              i * cellSize,
              j * cellSize,
              cellSize,
              cellSize,
            ),
            paint,
          );
        }
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

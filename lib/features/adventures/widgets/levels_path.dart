import 'package:flutter/material.dart';

class LevelsPath extends StatelessWidget {
  const LevelsPath({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(size: Size.infinite, painter: PathPainter());
  }
}

class PathPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final path = Path();

    path.moveTo(size.width * 0.5, 0);

    path.cubicTo(
      size.width * 0.1,
      size.height * 0.2,
      size.width * 0.9,
      size.height * 0.3,
      size.width * 0.5,
      size.height * 0.4,
    );

    path.cubicTo(
      size.width * 0.1,
      size.height * 0.5,
      size.width * 0.9,
      size.height * 0.6,
      size.width * 0.5,
      size.height * 0.85,
    );

    final paint = Paint()
      ..color = Colors.white
      ..strokeWidth = 35
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

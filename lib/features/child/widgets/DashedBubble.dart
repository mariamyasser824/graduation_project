import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DashedBubble extends StatelessWidget {
  final String text;

  const DashedBubble({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _DashedBorderPainter(
        color: const Color(0xffC4B5D6),
        strokeWidth: 1.5,
        dashWidth: 5,
        dashSpace: 4,
        radius: 14,
      ),
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(4.r),
            topRight: Radius.circular(14.r),
            bottomLeft: Radius.circular(14.r),
            bottomRight: Radius.circular(14.r),
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 16.sp,
            color: const Color(0xff374151),
            height: 1.5,
          ),
        ),
      ),
    );
  }
}

class _DashedBorderPainter extends CustomPainter {
  final Color color;
  final double strokeWidth;
  final double dashWidth;
  final double dashSpace;
  final double radius;

  _DashedBorderPainter({
    required this.color,
    required this.strokeWidth,
    required this.dashWidth,
    required this.dashSpace,
    required this.radius,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    // نفس الـ borderRadius بتاع الـ container
    final rrect = RRect.fromLTRBAndCorners(
      0,
      0,
      size.width,
      size.height,
      topLeft: const Radius.circular(4),
      topRight: const Radius.circular(14),
      bottomLeft: const Radius.circular(14),
      bottomRight: const Radius.circular(14),
    );

    final path = Path()..addRRect(rrect);
    _drawDashedPath(canvas, path, paint);
  }

  void _drawDashedPath(Canvas canvas, Path path, Paint paint) {
    final PathMetrics metrics = path.computeMetrics();
    for (final metric in metrics) {
      double distance = 0;
      bool draw = true;
      while (distance < metric.length) {
        final len = draw ? dashWidth : dashSpace;
        if (draw) {
          final extracted = metric.extractPath(distance, distance + len);
          canvas.drawPath(extracted, paint);
        }
        distance += len;
        draw = !draw;
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

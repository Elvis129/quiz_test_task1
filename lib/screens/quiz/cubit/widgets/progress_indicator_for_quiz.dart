import 'dart:math';
import 'package:flutter/material.dart';
import 'package:quiz_test_task1/constants/colors.dart';
import 'package:quiz_test_task1/constants/sizes.dart';

class ProgressIndicatorForQuiz extends StatelessWidget {
  final double progress;

  const ProgressIndicatorForQuiz({super.key, required this.progress});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: AppSizes.space2pxW * 29,
      height: AppSizes.space2pxH * 29,
      child: CustomPaint(
        painter: _ProgressPainter(progress),
      ),
    );
  }
}

class _ProgressPainter extends CustomPainter {
  final double progress;

  _ProgressPainter(this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    final Paint backgroundPaint = Paint()
      ..color = AppColors.grayIndicator
      ..style = PaintingStyle.stroke
      ..strokeWidth = 8.0
      ..strokeCap = StrokeCap.round;

    final Paint progressPaint = Paint()
      ..color = AppColors.blueIndicator
      ..style = PaintingStyle.stroke
      ..strokeWidth = 8.0
      ..strokeCap = StrokeCap.round;

    final double radius = size.width / 2;
    final Offset center = Offset(size.width / 2, size.height / 2);

    canvas.drawCircle(center, radius, backgroundPaint);

    const double startAngle = -pi / 2;
    final double sweepAngle = -2 * pi * progress;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      startAngle,
      sweepAngle,
      false,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

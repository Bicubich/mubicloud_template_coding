import 'package:flutter/material.dart';

class CustomProgressBar extends StatelessWidget {
  final double progress;
  final Color backgroundColor;
  final Color progressColor;
  final double barHeight;

  const CustomProgressBar({
    Key? key,
    required this.progress,
    this.backgroundColor = Colors.grey,
    this.progressColor = Colors.blue,
    this.barHeight = 12.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _ProgressBarPainter(
        progress: progress,
        backgroundColor: backgroundColor,
        progressColor: progressColor,
        barHeight: barHeight,
      ),
      child: Container(height: barHeight), // Height is the dot size
    );
  }
}

class _ProgressBarPainter extends CustomPainter {
  final double progress;
  final Color backgroundColor;
  final Color progressColor;
  final double barHeight;

  _ProgressBarPainter({
    required this.progress,
    required this.backgroundColor,
    required this.progressColor,
    required this.barHeight,
  });

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = backgroundColor
      ..strokeCap = StrokeCap.round
      ..strokeWidth = barHeight;

    // Draw the background
    canvas.drawLine(
        Offset(0, size.height / 2), Offset(size.width, size.height / 2), paint);

    // Draw the progress
    paint.color = progressColor;
    var progressWidth = size.width * progress;
    canvas.drawLine(Offset(0, size.height / 2),
        Offset(progressWidth, size.height / 2), paint);

    // Dot drawing code is removed
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}

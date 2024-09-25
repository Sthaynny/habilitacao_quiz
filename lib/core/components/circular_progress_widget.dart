import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:habilitacao_quiz/core/styles/app_styles.dart';

class CircularProgressWidget extends StatefulWidget {
  const CircularProgressWidget({
    super.key,
    this.primaryColor = AppColors.verde,
    this.secondaryColor = AppColors.azul,
    this.lapDuration = 1000,
    this.strokeWidth = 6.5,
  });

  final Color secondaryColor;
  final Color primaryColor;
  final int lapDuration;
  final double strokeWidth;

  @override
  State<CircularProgressWidget> createState() => _CircularProgressState();
}

class _CircularProgressState extends State<CircularProgressWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation animation;

  final kSize = 36.0;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: Duration(
        milliseconds: widget.lapDuration,
      ),
    )..repeat();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RotationTransition(
      turns: Tween(
        begin: 0.0,
        end: 1.0,
      ).animate(controller),
      child: CustomPaint(
        painter: CirclePaint(
            secondaryColor: widget.secondaryColor.withOpacity(0.1),
            primaryColor: widget.primaryColor,
            strokeWidth: widget.strokeWidth),
        size: Size(kSize, kSize),
      ),
    );
  }
}

class CirclePaint extends CustomPainter {
  CirclePaint(
      {this.secondaryColor = Colors.grey,
      this.primaryColor = Colors.blue,
      this.strokeWidth = 15});

  final Color secondaryColor;
  final Color primaryColor;
  final double strokeWidth;

  @override
  void paint(Canvas canvas, Size size) {
    final centerPoint = size.height / 2;

    final paint = Paint()
      ..color = primaryColor
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    paint.shader = SweepGradient(
      colors: [secondaryColor, lighten(primaryColor, 0.2), primaryColor],
      tileMode: TileMode.repeated,
      startAngle: _degreeToRad(270),
      endAngle: _degreeToRad(270 + 360.0),
    ).createShader(
        Rect.fromCircle(center: Offset(centerPoint, centerPoint), radius: 0));
    final scapSize = strokeWidth * 0.70;
    final scapToDegree = scapSize / centerPoint;
    final startAngle = _degreeToRad(270) + scapToDegree;
    final sweepAngle = _degreeToRad(360) - (2 * scapToDegree);

    canvas.drawArc(const Offset(0.0, 0.0) & Size(size.width, size.width),
        startAngle, sweepAngle, false, paint..color = primaryColor);
  }

  double _degreeToRad(double degree) => degree * math.pi / 180;

  @override
  bool shouldRepaint(CirclePaint oldDelegate) {
    return true;
  }

  Color lighten(Color color, [double amount = .1]) {
    assert(amount >= 0 && amount <= 1);

    final hsl = HSLColor.fromColor(color);
    final hslLight =
        hsl.withLightness((hsl.lightness + amount).clamp(0.0, 1.0));

    return hslLight.toColor();
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:math';
import '../../core/theme/colors.dart';
import '../../core/utils/hijri_helper.dart';
import '../../presentation/manager/worship_provider.dart';
import 'event_detail_sheet.dart';

class CosmicChronometer extends StatefulWidget {
  final Function(int day) onDaySelected;
  const CosmicChronometer({super.key, required this.onDaySelected});

  @override
  State<CosmicChronometer> createState() => _CosmicChronometerState();
}

class _CosmicChronometerState extends State<CosmicChronometer> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  int? _selectedDay;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleTap(Offset localPosition, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final dx = localPosition.dx - center.dx;
    final dy = localPosition.dy - center.dy;
    
    double angle = atan2(dy, dx);
    if (angle < 0) angle += 2 * pi;
    
    int day = ((angle / (2 * pi)) * 30).ceil().clamp(1, 30);
    
    setState(() {
      _selectedDay = day;
    });
    _controller.forward(from: 0.0);
    widget.onDaySelected(day);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (details) => _handleTap(details.localPosition, MediaQuery.of(context).size),
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return CustomPaint(
            size: const Size(300, 300),
            painter: ChronometerPainter(
              selectedDay: _selectedDay,
              animationValue: _controller.value,
            ),
          );
        },
      ),
    );
  }
}

class ChronometerPainter extends CustomPainter {
  final int? selectedDay;
  final double animationValue;

  ChronometerPainter({this.selectedDay, this.animationValue = 0.0});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;
    final ringWidth = 20.0;
    
    final Paint basePaint = Paint()
      ..color = MeeqatColors.mutedSlate.withOpacity(0.3)
      ..style = PaintingStyle.stroke
      ..strokeWidth = ringWidth;

    final Paint highlightPaint = Paint()
      ..color = MeeqatColors.spiritualGold
      ..style = PaintingStyle.stroke
      ..strokeWidth = ringWidth;

    final Paint activePaint = Paint()
      ..color = MeeqatColors.accentAmber
      ..style = PaintingStyle.stroke
      ..strokeWidth = ringWidth + 5;

    for (int i = 1; i <= 30; i++) {
      double startAngle = ((i - 1) / 30) * 2 * pi - pi / 2;
      double sweepAngle = (1 / 30) * 2 * pi - 0.05;

      Paint currentPaint = basePaint;
      
      if (i == 13 || i == 14 || i == 15) {
        currentPaint = highlightPaint;
      }

      if (i == selectedDay) {
        currentPaint = activePaint..strokeWidth = ringWidth + (10 * animationValue);
      }

      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        startAngle,
        sweepAngle,
        false,
        currentPaint,
      );
    }

    final corePaint = Paint()
      ..shader = RadialGradient(
        colors: [MeeqatColors.spiritualGold, MeeqatColors.midnightBlue],
      ).createShader(Rect.fromCircle(center: center, radius: 40));

    canvas.drawCircle(center, 40, corePaint);
    
    final glowPaint = Paint()
      ..color = MeeqatColors.spiritualGold.withOpacity(0.2)
      ..style = PaintingStyle.fill;
      
    canvas.drawCircle(center, 50 + (10 * animationValue), glowPaint);
  }

  @override
  bool shouldRepaint(covariant ChronometerPainter oldDelegate) {
    return oldDelegate.selectedDay != selectedDay || oldDelegate.animationValue != animationValue;
  }
}

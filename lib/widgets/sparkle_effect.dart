import 'dart:math';
import 'package:flutter/material.dart';

class SparkleEffect extends StatefulWidget {
  final int numberOfSparkles;
  const SparkleEffect({super.key, this.numberOfSparkles = 30});

  @override
  State<SparkleEffect> createState() => _SparkleEffectState();
}

class _SparkleEffectState extends State<SparkleEffect> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final List<_Sparkle> _sparkles = [];
  final Random _random = Random();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();

    _controller.addListener(() {
      setState(() {
        for (var sparkle in _sparkles) {
          sparkle.update();
        }
      });
    });

    // Initialize sparkles
    for (int i = 0; i < widget.numberOfSparkles; i++) {
      _sparkles.add(_generateSparkle());
    }
  }

  _Sparkle _generateSparkle() {
    return _Sparkle(
      x: _random.nextDouble(),
      y: _random.nextDouble(),
      size: _random.nextDouble() * 5 + 1, // Size between 1 and 4
      opacity: _random.nextDouble(),
      speed: _random.nextDouble() * 0.010 + 0.002,
      isFadingIn: _random.nextBool(),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _SparklePainter(_sparkles),
      child: Container(),
    );
  }
}

class _Sparkle {
  double x;
  double y;
  double size;
  double opacity;
  double speed;
  bool isFadingIn;

  _Sparkle({
    required this.x,
    required this.y,
    required this.size,
    required this.opacity,
    required this.speed,
    required this.isFadingIn,
  });

  void update() {
    if (isFadingIn) {
      opacity += speed;
      if (opacity >= 1.0) {
        opacity = 1.0;
        isFadingIn = false;
      }
    } else {
      opacity -= speed;
      if (opacity <= 0.0) {
        // Respawn
        opacity = 0.0;
        isFadingIn = true;
        x = Random().nextDouble();
        y = Random().nextDouble();
      }
    }
  }
}

class _SparklePainter extends CustomPainter {
  final List<_Sparkle> sparkles;

  _SparklePainter(this.sparkles);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    for (var sparkle in sparkles) {
      paint.color = Colors.white.withOpacity(sparkle.opacity);
      
      // Draw a 4-pointed star shape for a nicer sparkle
      final cx = sparkle.x * size.width;
      final cy = sparkle.y * size.height;
      final radius = sparkle.size;

      final path = Path();
      path.moveTo(cx, cy - radius);
      path.quadraticBezierTo(cx + radius * 0.1, cy - radius * 0.1, cx + radius, cy);
      path.quadraticBezierTo(cx + radius * 0.1, cy + radius * 0.1, cx, cy + radius);
      path.quadraticBezierTo(cx - radius * 0.1, cy + radius * 0.1, cx - radius, cy);
      path.quadraticBezierTo(cx - radius * 0.1, cy - radius * 0.1, cx, cy - radius);
      path.close();

      canvas.drawPath(path, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

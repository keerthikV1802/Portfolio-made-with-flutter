import 'package:flutter/material.dart';

class JumpingDash extends StatefulWidget {
  const JumpingDash({super.key});

  @override
  State<JumpingDash> createState() => _JumpingDashState();
}

class _JumpingDashState extends State<JumpingDash> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
    duration: const Duration(seconds: 1),
      vsync: this,
    )..repeat(reverse: true);
    
    _animation = Tween<double>(begin: 0, end: -30).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, _animation.value),
          child: child,
        );
      },
      child: Image.asset(
        'assets/flutter_dash_icon.png',
        width: 60,
        height: 60,
        fit: BoxFit.contain,
      ),
    );
  }
}

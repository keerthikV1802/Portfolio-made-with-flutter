import 'dart:math';
import 'package:flutter/material.dart';

class FlyingDashes extends StatefulWidget {
  const FlyingDashes({super.key});

  @override
  State<FlyingDashes> createState() => _FlyingDashesState();
}

class _FlyingDashesState extends State<FlyingDashes> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 50), // Reduced speed (slower)
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        final screenWidth = MediaQuery.of(context).size.width;
        final actualWidth = width > 0 && width < double.infinity ? width : screenWidth;
        
        // Define flight path boundaries
        final leftOffScreen = -100.0;
        final rightOffScreen = actualWidth + 100.0;

        return Stack(
          alignment: Alignment.center,
          clipBehavior: Clip.none,
          children: [
            // Bird 1: Right-facing (Flies Left -> Right)
            // Plays during first half (0.0 - 0.5)
            AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                if (_controller.value > 0.5) return const SizedBox(); // Hide in second half

                // Map 0.0-0.5 to 0.0-1.0
                final progress = _controller.value * 2;
                final currentX = leftOffScreen + (rightOffScreen - leftOffScreen) * progress;
                
                // Sinusoidal vertical movement
                final currentY = -40 + sin(progress * 2 * pi * 3) * 20;

                return Positioned(
                  left: currentX,
                  top: currentY, 
                  child: child!,
                );
              },
              child: Image.asset(
                'assets/dash_right.png',
                width: 60,
                height: 60,
                fit: BoxFit.contain,
              ),
            ),

            // Bird 2: Left-facing (Files Right -> Left)
            // Plays during second half (0.5 - 1.0)
            AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                if (_controller.value <= 0.5) return const SizedBox(); // Hide in first half

                // Map 0.5-1.0 to 0.0-1.0
                final progress = (_controller.value - 0.5) * 2;
                final currentX = rightOffScreen + (leftOffScreen - rightOffScreen) * progress;

                // Same vertical path (top)
                final currentY = -40 + sin(progress * 2 * pi * 3) * 20;

                return Positioned(
                  left: currentX,
                  top: currentY, // Now on top as well
                  child: child!,
                );
              },
              child: Image.asset(
                'assets/dash_left.png',
                width: 60,
                height: 60,
                fit: BoxFit.contain,
              ),
            ),
          ],
        );
      },
    );
  }
}

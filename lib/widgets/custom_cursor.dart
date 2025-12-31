import 'package:flutter/material.dart';

class CustomCursor extends StatefulWidget {
  final Widget child;
  const CustomCursor({super.key, required this.child});

  @override
  State<CustomCursor> createState() => _CustomCursorState();
}

class _CustomCursorState extends State<CustomCursor> {
  Offset _mousePos = Offset.zero;

  @override
  Widget build(BuildContext context) {
    // Disable custom cursor on mobile
    if (MediaQuery.of(context).size.width < 800) {
      return widget.child;
    }

    return MouseRegion(
      onHover: (event) {
        setState(() {
          _mousePos = event.position;
        });
      },
      child: Stack(
        children: [
          widget.child,
          // The Follower Cursor
          Positioned(
            left: _mousePos.dx - 15,
            top: _mousePos.dy - 15,
            child: IgnorePointer(
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 100),
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white.withOpacity(0.5), width: 2),
                  color: Colors.white.withOpacity(0.1),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.white.withOpacity(0.2),
                      blurRadius: 10,
                      spreadRadius: 2,
                    ),
                  ],
                ),
              ),
            ),
          ),
          // The Dot Center
          Positioned(
            left: _mousePos.dx - 4,
            top: _mousePos.dy - 4,
            child: IgnorePointer(
              child: Container(
                width: 8,
                height: 8,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

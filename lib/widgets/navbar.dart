import 'package:flutter/material.dart';

class NavBar extends StatelessWidget {
  final Function(int) onNavTap;
  final int activeIndex;
  final bool isMobile;

  const NavBar({
    super.key, 
    required this.onNavTap, 
    this.activeIndex = 0,
    this.isMobile = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
      color: Colors.transparent, 
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildLogo(),
          
          if (isMobile)
            IconButton(
              icon: const Icon(Icons.menu, color: Colors.white, size: 30),
              onPressed: () {
                Scaffold.of(context).openEndDrawer();
              },
            )
          else
            _buildDesktopNav(),
        ],
      ),
    );
  }

  Widget _buildLogo() {
    return const Text(
      "MyPortfolio",
      style: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: Colors.white,
        shadows: [
          Shadow(
            color: Colors.black45,
            offset: Offset(0, 2),
            blurRadius: 4,
          ),
        ],
      ),
    );
  }

  Widget _buildDesktopNav() {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.3),
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: Colors.white.withOpacity(0.1)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _navItem("Home", 0),
          _navItem("About Me", 1),
          _navItem("Projects", 2),
          _navItem("Contact", 3),
        ],
      ),
    );
  }

  Widget _navItem(String title, int index) {
    final bool isActive = activeIndex == index;
    
    return InkWell(
      onTap: () => onNavTap(index),
      borderRadius: BorderRadius.circular(20),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: isActive ? Colors.white : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          title,
          style: TextStyle(
            fontSize: 16, 
            color: isActive ? Colors.black : Colors.white, 
            fontWeight: isActive ? FontWeight.bold : FontWeight.w500,
            letterSpacing: 0.5,
          ),
        ),
      ),
    );
  }
}

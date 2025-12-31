// lib/home_page.dart
import 'package:flutter/material.dart';
import 'sections/about_section.dart';
import 'sections/projects_section.dart';
import 'sections/contact_section.dart';
import 'widgets/navbar.dart';
import 'widgets/sparkle_effect.dart';
import 'widgets/flying_dashes.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController _scrollController = ScrollController();
  int _activeIndex = 0;

  // Keys to identify the sections
  final GlobalKey _homeKey = GlobalKey();
  final GlobalKey _aboutKey = GlobalKey();
  final GlobalKey _projectsKey = GlobalKey();
  final GlobalKey _contactKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    // Only update if we have mounted keys
    if (_homeKey.currentContext == null) return;

    // Helper to get logic offset
    double getOffset(GlobalKey key) {
      final RenderBox? box = key.currentContext?.findRenderObject() as RenderBox?;
      if (box == null) return double.infinity;
      // Get position relative to viewport
      final position = box.localToGlobal(Offset.zero);
      return position.dy; 
    }

    final double aboutPos = getOffset(_aboutKey);
    final double projectsPos = getOffset(_projectsKey);
    final double contactPos = getOffset(_contactKey);
    
    // Threshold: Section is active if its top is near top of screen (e.g. within 1/3 viewport)
    // or if it's taking up most of the screen.
    // Simple logic: Find the first section that is NOT above the top of the viewport minus a buffer.
    
    // Since sections are stacked:
    // If Contact is visible (pos < screenHeight/2), it's probably active
    // We check from bottom up
    
    final screenHeight = MediaQuery.of(context).size.height;
    final threshold = screenHeight * 0.4; // 40% down the screen

    int newIndex = 0;
    if (contactPos < threshold) {
      newIndex = 3;
    } else if (projectsPos < threshold) {
      newIndex = 2;
    } else if (aboutPos < threshold) {
      newIndex = 1;
    } else {
      newIndex = 0;
    }

    if (newIndex != _activeIndex) {
      setState(() {
        _activeIndex = newIndex;
      });
    }
  }

  void _scrollToSection(int index) {
    setState(() => _activeIndex = index); // Update immediately on tap
    
    GlobalKey key;
    switch (index) {
      case 0: key = _homeKey; break;
      case 1: key = _aboutKey; break;
      case 2: key = _projectsKey; break;
      case 3: key = _contactKey; break;
      default: return;
    }

    // Scroll to the specific context
    final context = key.currentContext;
    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final bool isMobile = size.width < 800;
    final heroHeight = size.height * 1;

    return Scaffold(
      endDrawer: isMobile ? _buildMobileDrawer() : null,
      // keep scaffold body as a Stack so background is outside the scroll
      body: Stack(
        children: [
          // --- FIXED BACKGROUND IMAGE (outside scroll) ---
          Positioned.fill(
            child: Image.asset(
              'assets/elegant_bg.png',
              fit: BoxFit.fill,
            ),
          ),
          
          // --- SPARKLE EFFECT (Overlay on background) ---
          const Positioned.fill(
            child: SparkleEffect(numberOfSparkles: 50),
          ),

          // --- SCROLLABLE CONTENT (only this part scrolls) ---
          SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              children: [
                // HERO SLOT: same height as viewport so next section starts below
                SizedBox(
                  key: _homeKey, // Assign Home Key
                  height: heroHeight,
                  child: Center(
                    // AnimatedBuilder reads scrollController and rebuilds hero content
                    child: AnimatedBuilder(
                      animation: _scrollController,
                      builder: (context, _) {
                        final offset =
                            _scrollController.hasClients ? _scrollController.offset : 0.0;

                        // control how fast the text moves/fades:
                        final progress = (offset / (heroHeight * 0.6)).clamp(0.0, 1.0);
                        final translateY = -progress * 120; // move up to 120px
                        final opacity = (1.0 - progress).clamp(0.0, 1.0);

                        return Transform.translate(
                          offset: Offset(0, translateY),
                          child: Opacity(
                            opacity: opacity,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.end, // Align text to the right
                              children: [
                                const SizedBox(height: 150), 
                                Padding(
                                padding: EdgeInsets.only(right: isMobile ? 20.0 : 50.0), // Reduced padding for mobile
                                  child: Text(
                                    'FLUTTER DEVELOPER',
                                    style: TextStyle(
                                      fontSize: isMobile ? 24 : 50,
                                      color: Colors.white70,
                                      letterSpacing: isMobile ? 3.0 : 5.0,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: 'Poppins',
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 0),
                                Transform.scale(
                                  scaleY: 1.5,
                                  child: Stack(
                                    alignment: Alignment.center,
                                    clipBehavior: Clip.none,
                                    children: [
                                      isMobile
                                          ? ConstrainedBox(
                                              constraints: BoxConstraints(
                                                  maxWidth: size.width * 0.9),
                                              child: FittedBox(
                                                fit: BoxFit.scaleDown,
                                                child: Text(
                                                  'KEERTHIK V',
                                                  style: const TextStyle(
                                                    fontSize: 120, // Max size for mobile
                                                    fontFamily: "Anton",
                                                    color: Color.fromARGB(255, 255, 255, 255),
                                                    letterSpacing: 0.5,
                                                    wordSpacing: -2.0,
                                                  ),
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                            )
                                          : Text(
                                              'KEERTHIK V',
                                              style: const TextStyle(
                                                fontSize: 350,
                                                fontFamily: "Anton",
                                                color: Color.fromARGB(255, 255, 255, 255),
                                                letterSpacing: 0.5,
                                                wordSpacing: -5.0,
                                              ),
                                              textAlign: TextAlign.center,
                                            ),
                                      // Overlay Flying Dashes
                                      const Positioned.fill(
                                        child: FlyingDashes(),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),

                // --- below sections (About / Projects / Contact) ---
                AboutSection(
                  key: _aboutKey, 
                  isVisible: _activeIndex == 1, // Trigger animation when section is active
                ),
                ProjectsSection(key: _projectsKey),
                ContactSection(key: _contactKey),

                // small bottom padding
                const SizedBox(height: 80),
              ],
            ),
          ),

          // NAVBAR on top (sticky)
          Positioned(
            top: 0, 
            left: 0, 
            right: 0, 
            child: NavBar(
              onNavTap: _scrollToSection, 
              activeIndex: _activeIndex,
              isMobile: isMobile,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMobileDrawer() {
    return Drawer(
      backgroundColor: Colors.black.withOpacity(0.9),
      child: Column(
        children: [
          const DrawerHeader(
            child: Center(
              child: Text(
                "MyPortfolio",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          _drawerItem("Home", 0),
          _drawerItem("About Me", 1),
          _drawerItem("Projects", 2),
          _drawerItem("Contact", 3),
        ],
      ),
    );
  }

  Widget _drawerItem(String title, int index) {
    return ListTile(
      title: Text(
        title,
        style: TextStyle(
          color: _activeIndex == index ? Colors.blueAccent : Colors.white,
          fontSize: 18,
        ),
      ),
      onTap: () {
        Navigator.pop(context); // Close drawer
        _scrollToSection(index);
      },
    );
  }
}

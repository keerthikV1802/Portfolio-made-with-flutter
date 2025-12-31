import 'package:flutter/material.dart';
import '../widgets/section_title.dart';

class AboutSection extends StatefulWidget {
  final bool isVisible;
  const AboutSection({super.key, this.isVisible = false});

  @override
  State<AboutSection> createState() => _AboutSectionState();
}

class _AboutSectionState extends State<AboutSection> {
  final String _text = "I am a Flutter developer passionate about building apps and websites. "
      "This portfolio is built entirely with Flutter Web. "
      "I love working with Flutter, Firebase, and modern UI designs.";
  
  late List<String> _words;
  late List<bool> _wordVisible;
  bool _hasAnimated = false;

  @override
  void initState() {
    super.initState();
    _words = _text.split(' ');
    _wordVisible = List.filled(_words.length, false);
  }

  @override
  void didUpdateWidget(AboutSection oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isVisible && !_hasAnimated) {
      _startAnimation();
    }
  }

  void _startAnimation() async {
    _hasAnimated = true;
    for (int i = 0; i < _words.length; i++) {
      if (!mounted) return;
      await Future.delayed(const Duration(milliseconds: 50));
      setState(() {
        _wordVisible[i] = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final bool isMobile = size.width < 800;

    return Container(
      padding: EdgeInsets.symmetric(
        vertical: isMobile ? 100 : 250, 
        horizontal: isMobile ? 25 : 75
      ),
      width: double.infinity,
      color: const Color.fromRGBO(213, 210, 200, 1),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SectionTitle(title: "About Me"),
          const SizedBox(height: 35),
          Wrap(
            alignment: WrapAlignment.center,
            spacing: 8.0, // space between words
            runSpacing: 4.0, // space between lines
            children: List.generate(_words.length, (index) {
              return AnimatedOpacity(
                duration: const Duration(milliseconds: 300),
                opacity: _wordVisible[index] ? 1.0 : 0.0,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  transform: Matrix4.translationValues(
                    0, 
                    _wordVisible[index] ? 0 : 20, // Slide up/drop in effect
                    0
                  ),
                  child: Text(
                    _words[index],
                    style: TextStyle(
                      fontSize: isMobile ? 28 : 55, 
                      color: const Color.fromARGB(179, 0, 0, 0), 
                      height: 1.5,
                      fontFamily: 'Poppins',
                    ),
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}

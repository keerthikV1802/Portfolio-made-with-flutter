import 'package:flutter/material.dart';
import 'dart:ui'; // Required for BackdropFilter
import '../widgets/section_title.dart';

import 'package:url_launcher/url_launcher.dart';

class ProjectsSection extends StatelessWidget {
  const ProjectsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final bool isMobile = size.width < 800;

    return Container(
      padding: EdgeInsets.symmetric(
        vertical: 100, 
        horizontal: isMobile ? 20 : 40
      ),
      width: double.infinity,
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionTitle(title: "PROJECTS"),
          const SizedBox(height: 40),
          isMobile 
            ? Column(
                children: [
                   ProjectCard(
                    title: "Student Profile App",
                    tech: "Flutter + Firebase",
                    imagePath: "assets/project1.png",
                    description: "A comprehensive mobile application for managing student profiles, attendance, and grades. Built with Flutter and Firebase for real-time data synchronization.",
                    link: "https://github.com/keerthikV1802",
                    isMobile: isMobile,
                  ),
                  const SizedBox(height: 30),
                  ProjectCard(
                    title: "Dice Roller",
                    tech: "Flutter Fun Project",
                    imagePath: "assets/project3.png",
                    description: "A fun and interactive dice rolling application perfect for board games. Features realistic animations and sound effects.",
                    link: "https://github.com/keerthikV1802",
                    isMobile: isMobile,
                  ),
                ],
              )
            : SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    const SizedBox(width: 40), // Initial padding
                    ProjectCard(
                      title: "Student Profile App",
                      tech: "Flutter + Firebase",
                      imagePath: "assets/project1.png",
                      description: "A comprehensive mobile application for managing student profiles, attendance, and grades. Built with Flutter and Firebase for real-time data synchronization.",
                      link: "https://github.com/keerthikV1802",
                    ),
                    const SizedBox(width: 30),
                    
                    
                    ProjectCard(
                      title: "Dice Roller",
                      tech: "Flutter Fun Project",
                      imagePath: "assets/project3.png",
                      description: "A fun and interactive dice rolling application perfect for board games. Features realistic animations and sound effects.",
                      link: "https://github.com/keerthikV1802",
                    ),
                    const SizedBox(width: 40), // End padding
                  ],
                ),
              ),
        ],
      ),
    );
  }
}

class ProjectCard extends StatefulWidget {
  final String title;
  final String tech;
  final String imagePath;
  final String description;
  final String? link;
  final bool isMobile;

  const ProjectCard({
    super.key,
    required this.title,
    required this.tech,
    required this.imagePath,
    required this.description,
    this.link,
    this.isMobile = false,
  });

  @override
  State<ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<ProjectCard> {
  bool _isHovered = false;

  void _showDetails(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        child: Container(
          width: 500,
          constraints: const BoxConstraints(maxHeight: 600),
          decoration: BoxDecoration(
             color: Colors.black.withOpacity(0.85),
             borderRadius: BorderRadius.circular(25),
             border: Border.all(color: Colors.white.withOpacity(0.2)),
             boxShadow: [
               BoxShadow(color: Colors.black.withOpacity(0.5), blurRadius: 20, spreadRadius: 5),
             ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Image Header
              ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(25)),
                child: Image.asset(widget.imagePath, height: 250, width: double.infinity, fit: BoxFit.cover),
              ),
              Padding(
                padding: const EdgeInsets.all(25),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.tech.toUpperCase(), style: TextStyle(color: Colors.blueAccent[100], fontSize: 14, fontWeight: FontWeight.bold, letterSpacing: 1.5)),
                    const SizedBox(height: 10),
                    Text(widget.title, style: const TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold, fontFamily: 'Poppins')),
                    const SizedBox(height: 20),
                    Text(widget.description, style: TextStyle(color: Colors.white.withOpacity(0.8), fontSize: 16, height: 1.5, fontFamily: 'Poppins')),
                    const SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        if (widget.link != null)
                          Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: ElevatedButton.icon(
                              onPressed: () async {
                                final Uri url = Uri.parse(widget.link!);
                                if (await canLaunchUrl(url)) {
                                  await launchUrl(url);
                                }
                              },
                              icon: const Icon(Icons.open_in_new, size: 18),
                              label: const Text("View Project"),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blueAccent,
                                foregroundColor: Colors.white,
                              ),
                            ),
                          ),
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          style: TextButton.styleFrom(foregroundColor: Colors.white),
                          child: const Text("Close", style: TextStyle(fontSize: 16)),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: () => _showDetails(context),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeInOut,
          transform: Matrix4.identity()..scale(_isHovered ? 1.05 : 1.0),
          width: widget.isMobile ? double.infinity : 350,
          height: widget.isMobile ? 400 : 450,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(_isHovered ? 0.2 : 0.1), // enhance shadow on hover
                blurRadius: _isHovered ? 30 : 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Stack(
              children: [
                // Background Image
                Positioned.fill(
                  child: Image.asset(
                    widget.imagePath,
                    fit: BoxFit.cover,
                  ),
                ),
                // Gradient Overlay for readability
                Positioned.fill(
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black.withOpacity(0.8),
                        ],
                      ),
                    ),
                  ),
                ),
                // Text Content with Glassmorphism effect
                Positioned(
                  bottom: 20,
                  left: 20,
                  right: 20,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.1),
                          border: Border.all(color: Colors.white.withOpacity(0.2)),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.tech.toUpperCase(),
                              style: TextStyle(
                                color: Colors.blueAccent[100],
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1.2,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              widget.title,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
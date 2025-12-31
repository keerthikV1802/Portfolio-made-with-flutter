import 'package:flutter/material.dart';
import '../widgets/section_title.dart';

class ContactSection extends StatelessWidget {
  const ContactSection({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final bool isMobile = size.width < 800;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        vertical: 100, 
        horizontal: isMobile ? 20 : 40
      ),
      // Use a transparent container since the background is handled by HomePage
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SectionTitle(title: "Get In Touch"),
          const SizedBox(height: 10),
          Text(
            "Let's build something amazing together.",
            style: TextStyle(
              fontSize: 18,
              color: Colors.white.withOpacity(0.8),
              fontFamily: 'Poppins',
              letterSpacing: 1.2,
            ),
          ),
          const SizedBox(height: 60),

          // Cards Layout
          Wrap(
            spacing: 30, // Horizontal space
            runSpacing: 30, // Vertical space
            alignment: WrapAlignment.center,
            children: [
              _contactCard(
                icon: Icons.email_outlined,
                title: "Email",
                content: "keerthikv1807@gmail.com",
                color: Colors.redAccent,
              ),
              _contactCard(
                icon: Icons.code, // Approximating GitHub
                title: "GitHub",
                content: "github.com/keerthikV1802",
                color: Colors.grey,
              ),
              _contactCard(
                icon: Icons.person_search_outlined, // Approximating LinkedIn
                title: "LinkedIn",
                content: "linkedin.com/in/keerthik-a8525926b",
                color: Colors.blueAccent,
              ),
            ],
          ),
          const SizedBox(height: 100),
        ],
      ),
    );
  }

  Widget _contactCard({
    required IconData icon,
    required String title,
    required String content,
    required Color color,
  }) {
    return Container(
      width: 300,
      padding: const EdgeInsets.all(25),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withOpacity(0.1)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Icon Bubble
          Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: color.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, size: 30, color: color),
          ),
          const SizedBox(height: 20),
          
          // Title
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontFamily: 'Poppins',
            ),
          ),
          const SizedBox(height: 10),
          
          // Content (Selectable)
          SelectableText(
            content,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              color: Colors.white.withOpacity(0.7),
              fontFamily: 'Poppins',
            ),
          ),
        ],
      ),
    );
  }
}

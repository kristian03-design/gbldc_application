import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

void main() => runApp(const AboutUsApp());

class AboutUsApp extends StatelessWidget {
  const AboutUsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'About Us',
      debugShowCheckedModeBanner: false,
      home: const AboutUsPage(),
    );
  }
}

class AboutUsPage extends StatelessWidget {
  const AboutUsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6F8),
      appBar: AppBar(
        elevation: 1,
        centerTitle: true,
        backgroundColor: Colors.white,
        title: const Text(
          'About Us',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w600,
            fontSize: 18,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Iconsax.arrow_left, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  blurRadius: 10,
                  color: Colors.black.withOpacity(0.05),
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              children: [
                Image.asset('assets/images/logocoop.png', height: 70, width: 70),
                const SizedBox(height: 16),
                const Text(
                  'Greater Bulacan Livelihood Development Cooperative',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    height: 1.4,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 12),
                const Text(
                  'We are a cooperative-based institution committed to empowering Filipino communities through affordable and accessible financial services.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black54,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 30),
          const SectionWithIcon(
            title: 'Our Mission',
            icon: Iconsax.flag,
            text:
            'To provide sustainable and inclusive financial solutions that uplift the lives of every member and their families.',
          ),
          const SectionWithIcon(
            title: 'Our Vision',
            icon: Iconsax.eye,
            text:
            'To be the most trusted cooperative bank in the region—known for integrity, innovation, and meaningful impact.',
          ),
          const SectionWithIcon(
            title: 'Core Values',
            icon: Iconsax.star,
            text:
            '• Integrity\n• Transparency\n• Commitment\n• Empowerment\n• Community Focus',
          ),
          const SizedBox(height: 25),
          const Text(
            'Contact Us',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFFF7F9FA),
              borderRadius: BorderRadius.circular(14),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ContactRow(icon: Iconsax.sms, text: 'support@gblc.coop'),
                SizedBox(height: 10),
                ContactRow(icon: Iconsax.call, text: '+63 912 345 6789'),
                SizedBox(height: 10),
                ContactRow(icon: Iconsax.location, text: 'Baliwag, Bulacan'),
                SizedBox(height: 10),
                ContactRow(icon: Iconsax.global, text: 'www.gblc.coop'),
              ],
            ),
          ),
          const SizedBox(height: 30),
          ElevatedButton.icon(
            onPressed: () {},
            icon: const Icon(Iconsax.global, color: Colors.white, size: 20),
            label: const Text(
              'Visit Website',
              style: TextStyle(
                fontSize: 16,
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green.shade600,
              minimumSize: const Size(double.infinity, 50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              elevation: 2,
            ),
          ),
        ],
      ),
    );
  }
}

class SectionWithIcon extends StatelessWidget {
  final String title;
  final IconData icon;
  final String text;

  const SectionWithIcon({
    super.key,
    required this.title,
    required this.icon,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 26),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: Colors.green.shade700, size: 20),
              const SizedBox(width: 6),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            text,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.black87,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}

class ContactRow extends StatelessWidget {
  final IconData icon;
  final String text;

  const ContactRow({super.key, required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: Colors.green.shade700, size: 18),
        const SizedBox(width: 10),
        Flexible(
          child: Text(
            text,
            style: const TextStyle(fontSize: 14, color: Colors.black87),
          ),
        ),
      ],
    );
  }
}

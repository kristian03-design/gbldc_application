import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

void main() {
  runApp(const PrivacyPolicyApp());
}

class PrivacyPolicyApp extends StatelessWidget {
  const PrivacyPolicyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Privacy Policy',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFF1F5F9),
        fontFamily: 'Roboto',
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          titleTextStyle: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w700,
            fontSize: 20,
          ),
          iconTheme: IconThemeData(color: Colors.black),
        ),
      ),
      home: const PrivacyPolicyPage(),
    );
  }
}

class PrivacyPolicyPage extends StatefulWidget {
  const PrivacyPolicyPage({super.key});

  @override
  State<PrivacyPolicyPage> createState() => _PrivacyPolicyPageState();
}

class _PrivacyPolicyPageState extends State<PrivacyPolicyPage> {
  final ScrollController _scrollController = ScrollController();

  void _scrollToTop() {
    _scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF1F5F9),
      extendBodyBehindAppBar: true,
      floatingActionButton:
          _scrollController.hasClients && _scrollController.offset > 200
              ? FloatingActionButton(
                  onPressed: _scrollToTop,
                  backgroundColor: Colors.green.shade600,
                  child: const Icon(Icons.arrow_upward, color: Colors.white),
                )
              : null,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: Container(
          child: AppBar(
            backgroundColor: const Color(0xFFF1F5F9),
            elevation: 0,
            centerTitle: true,
            title: const Text('Privacy Policy'),
            leading: IconButton(
              icon: const Icon(Iconsax.arrow_left),
              onPressed: () => Navigator.pop(context),
            ),
          ),
        ),
      ),
      body: ListView(
        controller: _scrollController,
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 90),
        children: const [
          PolicySection(
            icon: Iconsax.info_circle,
            title: '1. Introduction',
            body:
                "Your privacy is important to us. This privacy policy outlines how we collect, use, and protect your personal information when you use our services.",
          ),
          PolicySection(
            icon: Iconsax.document,
            title: '2. Data We Collect',
            body:
                "We may collect personal details such as your full name, contact number, email, location, device information, and usage statistics.",
          ),
          PolicySection(
            icon: Iconsax.activity,
            title: '3. How We Use Your Data',
            body:
                "We use your data to provide and improve our services, personalize your experience, process transactions, and communicate with you about your account or activity.",
          ),
          PolicySection(
            icon: Iconsax.shield_tick,
            title: '4. Sharing Your Information',
            body:
                "We do not share your personal data with third parties without your consent, except to comply with legal obligations, enforce our policies, or protect our rights.",
          ),
          PolicySection(
            icon: Iconsax.user_tick,
            title: '5. Your Rights',
            body:
                "You have the right to access, correct, or delete your personal data. You may also object to certain uses of your data or withdraw consent at any time.",
          ),
          PolicySection(
            icon: Iconsax.lock,
            title: '6. Data Security',
            body:
                "We implement strong security measures to safeguard your data, including encryption, secure servers, and access restrictions.",
          ),
          PolicySection(
            icon: Iconsax.refresh,
            title: '7. Changes to This Policy',
            body:
                "We may update this policy occasionally. Any changes will be posted on this page, and we encourage you to review it periodically.",
          ),
          PolicySection(
            icon: Iconsax.message,
            title: '8. Contact Us',
            body:
                "If you have any questions or concerns about this privacy policy, please contact us at:\n\ngbldc@gmail.com\n\nThank you for trusting us with your information.",
          ),
        ],
      ),
    );
  }
}

class PolicySection extends StatelessWidget {
  final IconData icon;
  final String title;
  final String body;

  const PolicySection({
    super.key,
    required this.icon,
    required this.title,
    required this.body,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10),
      elevation: 2,
      color: const Color(0xFFFFFFFF), // Added background color
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: Colors.green.shade700, size: 22),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              body,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.black87,
                height: 1.6,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'dart:io';
import 'package:flutter/material.dart';
import 'submission_confirmation_screen.dart';
import 'package:iconsax/iconsax.dart';

class ReviewDetailsScreen extends StatelessWidget {
  final File selfie;

  const ReviewDetailsScreen({super.key, required this.selfie});

  Future<void> _submitApplication(BuildContext context) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: const [
            CircularProgressIndicator(color: Colors.green),
            SizedBox(height: 20),
            Text("Submitting application..."),
          ],
        ),
      ),
    );

    await Future.delayed(const Duration(seconds: 2));

    if (context.mounted) {
      Navigator.pop(context); // Close loading dialog
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          transitionDuration: const Duration(milliseconds: 800),
          pageBuilder: (context, animation, _) =>
          const SubmissionConfirmationScreen(),
          transitionsBuilder: (context, animation, _, child) {
            final curved = CurvedAnimation(
              parent: animation,
              curve: Curves.easeInOut,
            );
            return FadeTransition(
              opacity: curved,
              child: child,
            );
          },
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF1F5F9),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF1F5F9),
        elevation: 0,
        leading: const BackButton(color: Colors.black),
        title: const Text("Review Details", style: TextStyle(color: Colors.black)),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: ListView(
          children: [
            const Text(
              "Please review all your submitted information before final submission.",
              style: TextStyle(fontSize: 14, color: Colors.black54),
            ),
            const SizedBox(height: 24),

            _buildSectionTitle("Personal Information"),
            _buildInfoRow("Full Name", "Juan Dela Cruz"),
            _buildInfoRow("Date of Birth", "27-12-1995"),
            _buildInfoRow("Email", "juan@example.com"),
            _buildInfoRow("Phone", "+63 912 345 6789"),
            _buildInfoRow("Address", "123 Example St, Quezon City"),
            _buildInfoRow("Nationality", "Filipino"),
            _buildInfoRow("Occupation", "Software Engineer"),
            _buildInfoRow("Source of Funds", "Salary"),
            _buildInfoRow("Amount of Salary", "PHP 20,000"),
            _buildInfoRow("Marital Status", "Single"),
            _buildInfoRow("Emergency Contact 1", "Maria Dela Cruz, +63 998 765 4321"),
            _buildInfoRow("Emergency Contact 2", "Pedro Penduko, +63 917 123 4567"),

            const SizedBox(height: 32),

            _buildSectionTitle("Selfie with ID Card"),
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.file(
                selfie,
                height: 250,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),

            const SizedBox(height: 40),
            ElevatedButton.icon(
              onPressed: () {
                _submitApplication(context);
              },
              icon: const Icon(Iconsax.send_2, color: Colors.white),
              label: const Text(
                "Submit Application",
                style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.w500),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 3,
            child: Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            flex: 5,
            child: Text(
              value,
              style: const TextStyle(color: Colors.black87),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: Colors.black87,
        ),
      ),
    );
  }
}

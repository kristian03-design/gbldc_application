import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class LoanPageRejected extends StatelessWidget {
  const LoanPageRejected({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F8FA),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 36),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Logo
              Center(child: Image.asset('assets/images/logocoop.png', height: 70)),
              const SizedBox(height: 40),

              // Modern red X icon using Iconsax
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.red.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Iconsax.close_circle, color: Colors.red, size: 80),
              ),
              const SizedBox(height: 24),

              const Text(
                "Loan Application Rejected",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 12),

              const Text(
                "Unfortunately, your loan application has been declined. Please review the reason and suggestions below.",
                style: TextStyle(fontSize: 15, color: Colors.black54),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 28),

              // Rejection reason card
              _buildInfoCard(
                icon: Iconsax.info_circle,
                title: "Reason for Rejection",
                content: "- Credit score is too low\n"
                    "- Incomplete ID verification\n"
                    "- Monthly income did not meet required threshold",
                backgroundColor: Colors.white,
                titleColor: Colors.black87,
                contentColor: Colors.black87,
              ),

              const SizedBox(height: 20),

              // Suggestions card
              _buildInfoCard(
                icon: Iconsax.activity,
                title: "Suggestions to Improve",
                content: "- Improve your credit score\n"
                    "- Upload valid and clear ID documents\n"
                    "- Ensure all personal and financial info is updated",
                backgroundColor: const Color(0xFFE8F5E9),
                titleColor: const Color(0xFF2E7D32),
                contentColor: const Color(0xFF2E7D32),
              ),

              const SizedBox(height: 32),

              // Try Again button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Iconsax.refresh, size: 20),
                  label: const Text(
                    "Try Again",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF16A34A),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 2,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoCard({
    required IconData icon,
    required String title,
    required String content,
    required Color backgroundColor,
    required Color titleColor,
    required Color contentColor,
  }) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          if (backgroundColor == Colors.white)
            const BoxShadow(
              color: Colors.black12,
              blurRadius: 10,
              offset: Offset(0, 4),
            )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 20, color: titleColor),
              const SizedBox(width: 8),
              Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: titleColor,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            content,
            style: TextStyle(
              fontSize: 14,
              color: contentColor,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}

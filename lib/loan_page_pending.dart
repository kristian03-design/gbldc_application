import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class LoanPagePending extends StatelessWidget {
  const LoanPagePending({Key? key}) : super(key: key);

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

              // Pending icon
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.amber.withOpacity(0.15),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Iconsax.timer_start, color: Colors.amber, size: 80),
              ),
              const SizedBox(height: 24),

              const Text(
                "Loan Application Pending",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 12),

              const Text(
                "Your loan application is currently under review. Please wait while we verify your details.",
                style: TextStyle(fontSize: 15, color: Colors.black54),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 28),

              // Loan status card
              _buildInfoCard(
                icon: Iconsax.document_text,
                title: "Status Summary",
                content: "- Application received\n"
                    "- ID verification in process\n"
                    "- Credit review in progress",
                backgroundColor: Colors.white,
                titleColor: Colors.black87,
                contentColor: Colors.black87,
              ),

              const SizedBox(height: 20),

              // What to expect
              _buildInfoCard(
                icon: Iconsax.information,
                title: "What to Expect",
                content: "- Processing may take 1–3 business days\n"
                    "- You will receive updates via email or app\n"
                    "- Make sure your contact details are up to date",
                backgroundColor: const Color(0xFFFEF3C7),
                titleColor: const Color(0xFF92400E),
                contentColor: const Color(0xFF92400E),
              ),

              const SizedBox(height: 32),

              // Refresh status
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () {
                    // Refresh logic here or navigate
                  },
                  icon: const Icon(Iconsax.refresh, size: 20),
                  label: const Text(
                    "Refresh Status",
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

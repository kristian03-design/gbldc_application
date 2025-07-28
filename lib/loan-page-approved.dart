import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'loan-page.dart';

class LoanPageApproved extends StatefulWidget {
  const LoanPageApproved({Key? key}) : super(key: key);

  @override
  State<LoanPageApproved> createState() => _LoanPageApprovedState();
}

class _LoanPageApprovedState extends State<LoanPageApproved> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F8FA),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 36),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(child: Image.asset('assets/images/logocoop.png', height: 70)),
              const SizedBox(height: 40),
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.green.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
              child: const Icon(Iconsax.tick_circle, color: Colors.green, size: 80),
      ),
              const SizedBox(height: 24),

              const Text(
                "Loan Application Approved",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600, color: Colors.black87),
              ),
              const SizedBox(height: 12),

              const Text(
                "Congratulations! Your loan application has been approved. Details of your loan are shown below.",
                style: TextStyle(fontSize: 15, color: Colors.black54),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),

              // Expandable Loan Summary Card
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                padding: const EdgeInsets.all(20),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(color: Colors.grey.withOpacity(0.2), blurRadius: 10, offset: const Offset(0, 4))
                  ],
                ),
                child: Column(
                  children: [
                    InkWell(
                      onTap: () {
                        setState(() {
                          _isExpanded = !_isExpanded;
                        });
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: const [
                              Icon(Iconsax.document, color: Color(0xFF16A34A), size: 24),
                              SizedBox(width: 8),
                              Text(
                                "Loan Details",
                                style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600, color: Colors.black87),
                              ),
                            ],
                          ),
                          Icon(_isExpanded ? Iconsax.arrow_up_2 : Iconsax.arrow_down_1, color: Colors.black54),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Expandable Section
                    AnimatedCrossFade(
                      duration: const Duration(milliseconds: 300),
                      firstChild: const SizedBox.shrink(),
                      secondChild: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          LoanDetailItem(icon: Iconsax.money_2, text: "Amount Approved: ₱20,000"),
                          LoanDetailItem(icon: Iconsax.percentage_circle, text: "Interest Rate: 1.5% per month"),
                          LoanDetailItem(icon: Iconsax.timer_1, text: "Term: 12 months"),
                          LoanDetailItem(icon: Iconsax.wallet_check, text: "Monthly Payment: ₱1,900"),
                          LoanDetailItem(icon: Iconsax.calendar_1, text: "Next Payment Due: November 15, 2023"),
                        ],
                      ),
                      crossFadeState:
                      _isExpanded ? CrossFadeState.showSecond : CrossFadeState.showFirst,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 28),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (_) =>  LoanPageHomepage()),
                          (route) => false,
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF16A34A),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  child: const Text("Go to Loan Dashboard", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class LoanDetailItem extends StatelessWidget {
  final IconData icon;
  final String text;

  const LoanDetailItem({Key? key, required this.icon, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Icon(icon, color: Color(0xFF16A34A), size: 18),
          const SizedBox(width: 8),
          Expanded(child: Text(text, style: const TextStyle(fontSize: 14, color: Colors.black87))),
        ],
      ),
    );
  }
}

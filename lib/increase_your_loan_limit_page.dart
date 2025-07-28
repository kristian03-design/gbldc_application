import 'package:flutter/material.dart';
import 'request_limit_form.dart';
import 'package:iconsax/iconsax.dart';

class IncreaseLimitPage extends StatelessWidget {
  const IncreaseLimitPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> tips = [
      {
        "title": "Use Your Account Regularly",
        "description":
        "Make regular transactions like bill payments, fund transfers, or purchases. Consistent activity builds your credibility.",
        "icon": Iconsax.repeat,
      },
      {
        "title": "Pay on Time",
        "description":
        "Timely payments on loans or credit cards show you’re financially responsible. Avoid late fees to keep your record clean.",
        "icon": Iconsax.clock,
      },
      {
        "title": "Maintain Low Credit Usage",
        "description":
        "Use only a portion of your current limit—ideally below 30%. This indicates you’re not over-reliant on credit.",
        "icon": Iconsax.chart,
      },
      {
        "title": "Submit Updated Income Proof",
        "description":
        "Provide recent payslips, COE, or income statements. A higher or more stable income strengthens your request.",
        "icon": Iconsax.document_text,
      },
      {
        "title": "Keep Contact Details Updated",
        "description":
        "Ensure your mobile number, address, and employer details are correct. This makes your account more trustworthy.",
        "icon": Iconsax.user_edit,
      },
      {
        "title": "Build Loan History",
        "description":
        "Complete 2–3 short-term loans successfully. Showing good repayment history makes your account low-risk.",
        "icon": Iconsax.archive_tick,
      },
      {
        "title": "Maintain a Stable Job",
        "description":
        "Being employed for at least 6 months in your current job indicates financial stability to lenders.",
        "icon": Iconsax.briefcase,
      },
      {
        "title": "Use Auto-Debit for Payments",
        "description":
        "Enroll in auto-debit for recurring payments. It shows discipline and ensures on-time payments.",
        "icon": Iconsax.card_tick,
      },
      {
        "title": "Keep Loan-to-Income Ratio Low",
        "description":
        "If your current debt is too high compared to your income, it may affect your credit limit approval.",
        "icon": Iconsax.ranking,
      },
      {
        "title": "Request During Salary Increase",
        "description":
        "If your salary recently increased, it’s a great time to request a limit raise—submit updated proof.",
        "icon": Iconsax.trend_up,
      },
    ];


    return Scaffold(
      backgroundColor: const Color(0xFFF1F5F9),
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          "Increase Your Limit",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.black),
        elevation: 0.5,
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          children: [
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Colors.green.shade50,
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "How to Increase Your Credit Limit",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Want to unlock a higher credit limit? Here are a few smart tips to help you get approved quickly and responsibly.",
                    style: TextStyle(
                        fontSize: 14, color: Colors.black54, height: 1.6),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),
            const Text(
              "Tips for Faster Approval",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 10),

            ...tips.map((tip) {
              return Container(
                margin: const EdgeInsets.symmetric(vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 4,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Theme(
                  data: Theme.of(context)
                      .copyWith(dividerColor: Colors.transparent),
                  child: ExpansionTile(
                    tilePadding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 4),
                    childrenPadding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 10),
                    title: Row(
                      children: [
                        Icon(tip["icon"], color: Colors.green),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            tip["title"],
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ],
                    ),
                    children: [
                      Text(
                        tip["description"],
                        style: const TextStyle(
                            fontSize: 14, color: Colors.black87),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),

            const SizedBox(height: 30),

            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const RequestLimitFormPage(),
                  ),
                );
              },
              icon: const Icon(Iconsax.arrow_up_3),
              label: const Text("Request Limit Increase"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
                padding:
                const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

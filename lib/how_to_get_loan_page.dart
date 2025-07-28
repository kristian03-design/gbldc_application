import 'package:flutter/material.dart';
import 'online-application.dart';
import 'package:iconsax/iconsax.dart';

class HowToGetLoanPage extends StatelessWidget {
  const HowToGetLoanPage({super.key});

  final List<Map<String, dynamic>> steps = const [
    {
      'icon': Iconsax.profile_add,
      'title': 'Register or Log In',
      'description': 'Create an account or log in to your GBLDC profile.',
    },
    {
      'icon': Iconsax.profile_circle,
      'title': 'Complete Profile',
      'description': 'Fill in your personal, contact, and employment information.',
    },
    {
      'icon': Iconsax.document_upload,
      'title': 'Upload Requirements',
      'description': 'Upload valid ID, proof of income, and other documents.',
    },
    {
      'icon': Iconsax.note_text,
      'title': 'Apply for a Loan',
      'description': 'Choose your loan type, amount, and submit your application.',
    },
    {
      'icon': Iconsax.shield_tick,
      'title': 'Wait for Approval',
      'description': 'We will review your application and notify you shortly.',
    },
    {
      'icon': Iconsax.wallet_check,
      'title': 'Get Your Funds',
      'description': 'Once approved, your loan will be credited directly.',
    },
  ];

  final List<Map<String, String>> loanTypes = const [
    {
      'title': 'Personal Loan',
      'desc': 'Ideal for emergencies, medical bills, or other needs.',
    },
    {
      'title': 'Business Loan',
      'desc': 'Support for micro or small businesses and cooperatives.',
    },
    {
      'title': 'Education Loan',
      'desc': 'Assistance for tuition, supplies, and school fees.',
    },
  ];

  final List<String> tips = const [
    'Use a valid government-issued ID.',
    'Ensure all your documents are clear and readable.',
    'Double-check your mobile number and email for updates.',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF1F5F9),
      appBar: AppBar(
        title: const Text('How to Get a Loan',
            style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 1,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
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
                Text("Need a loan?",
                    style:
                    TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
                SizedBox(height: 4),
                Text(
                  "Follow these simple steps to apply and get approved easily.",
                  style: TextStyle(fontSize: 14, color: Colors.black54),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          const Text("Step-by-Step Process",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
          const SizedBox(height: 10),
          ...steps.map((step) {
            return Container(
              margin: const EdgeInsets.only(bottom: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 6,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Theme(
                data: Theme.of(context).copyWith(
                    dividerColor: Colors.transparent),
                child: ExpansionTile(
                  tilePadding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  childrenPadding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  leading: CircleAvatar(
                    backgroundColor: Colors.green.shade100,
                    child: Icon(step['icon'], color: Colors.green[800]),
                  ),
                  title: Text(
                    step['title'],
                    style: const TextStyle(
                        fontSize: 15, fontWeight: FontWeight.w600),
                  ),
                  children: [
                    Text(
                      step['description'],
                      style: const TextStyle(
                          fontSize: 14, color: Colors.black87),
                    ),
                  ],
                ),
              ),
            );
          }),
          const SizedBox(height: 30),
          const Text("Loan Products Available",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
          const SizedBox(height: 10),
          ...loanTypes.map((loan) {
            return Container(
              margin: const EdgeInsets.only(bottom: 12),
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.green.shade100),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(loan['title']!,
                      style: const TextStyle(
                          fontWeight: FontWeight.w600, fontSize: 15)),
                  const SizedBox(height: 6),
                  Text(loan['desc']!,
                      style: const TextStyle(
                          fontSize: 13, color: Colors.black54)),
                ],
              ),
            );
          }),
          const SizedBox(height: 30),
          const Text("Helpful Tips Before Applying",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
          const SizedBox(height: 10),
          ...tips.map((tip) => Row(
            children: [
              const Icon(Iconsax.tick_circle,
                  size: 18, color: Colors.green),
              const SizedBox(width: 6),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6),
                  child: Text(tip,
                      style: const TextStyle(
                          fontSize: 14, color: Colors.black87)),
                ),
              )
            ],
          )),
          const SizedBox(height: 40),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const RegistrationForm()),
                );
              },
              icon: const Icon(Iconsax.arrow_right_1),
              label: const Text("Apply for a Loan"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

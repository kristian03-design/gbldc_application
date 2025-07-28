import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class CooperativeMemberBenefitsPage extends StatelessWidget {
  const CooperativeMemberBenefitsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FA),
      appBar: AppBar(
        title: const Text('Member Benefits', style: TextStyle(fontWeight: FontWeight.w600)),
        backgroundColor: Colors.white,
        elevation: 0.5,
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          // Member Summary Card
          Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            elevation: 0,
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Total Dividends', style: TextStyle(color: Colors.grey, fontSize: 14)),
                  const SizedBox(height: 6),
                  const Text('₱ 15,000', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 18),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _miniSummary('Patronage Refund', '₱ 3,500'),
                      _miniSummary('Status', 'Active'),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),

          // Quick Actions
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _quickAction(Iconsax.gift, 'View Dividends', Colors.green),
              _quickAction(Iconsax.money_recive, 'Claim Refund', Colors.blue),
              _quickAction(Iconsax.people, 'Join Programs', Colors.orange),
            ],
          ),
          const SizedBox(height: 32),

          // Recent Activities
          const Text('Recent Activities', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16)),
          const SizedBox(height: 12),
          _activityTile('Dividend Credited', '+₱ 2,000', 'Today', Colors.green),
          _activityTile('Joined Seminar', '', 'Yesterday', Colors.orange),
          _activityTile('Refund Claimed', '+₱ 1,000', '3 days ago', Colors.blue),
        ],
      ),
    );
  }

  Widget _miniSummary(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(color: Colors.grey, fontSize: 13)),
        const SizedBox(height: 2),
        Text(value, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16)),
      ],
    );
  }

  Widget _quickAction(IconData icon, String label, Color color) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: color.withOpacity(0.12),
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.all(14),
          child: Icon(icon, color: color, size: 28),
        ),
        const SizedBox(height: 8),
        Text(label, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500)),
      ],
    );
  }

  Widget _activityTile(String title, String amount, String date, Color color) {
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 0,
      color: Colors.white,
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: color.withOpacity(0.13),
          child: Icon(Iconsax.activity, color: color),
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w500)),
        subtitle: Text(date, style: const TextStyle(fontSize: 12, color: Colors.grey)),
        trailing: amount.isNotEmpty
            ? Text(
          amount,
          style: TextStyle(
            color: color,
            fontWeight: FontWeight.w600,
            fontSize: 15,
          ),
        )
            : null,
      ),
    );
  }
}
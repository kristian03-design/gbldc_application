import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class LoanDetailsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Map<String, String> loanDetails = {
      'Amount': '₱ 12,600.00',
      'Loan Type': 'Personal',
      'Status': 'Paid Off',
      'Date Issued': 'Sep 10, 2024',
      'Due Date': 'Dec 10, 2024',
      'Term': '3 months',
      'Interest Rate': '5%',
      'Monthly Payment': '₱ 4,200.00',
      'Total Paid': '₱ 12,600.00',
    };

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('Loan Details', style: TextStyle(color: Colors.black)),
        centerTitle: true,
        elevation: 1,
        leading: IconButton(
          icon: const Icon(Iconsax.arrow_left, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      backgroundColor: const Color(0xFFF5F7FA),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Card
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.green.shade50,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Loan Amount',
                    style: TextStyle(color: Colors.green, fontSize: 14),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    loanDetails['Amount']!,
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      const Icon(Iconsax.tick_circle, color: Colors.green, size: 20),
                      const SizedBox(width: 6),
                      Text(
                        loanDetails['Status']!,
                        style: const TextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.w600,
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),

            const SizedBox(height: 25),

            // Details List
            ...loanDetails.entries
                .where((entry) => entry.key != 'Amount' && entry.key != 'Status')
                .map((entry) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 14),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.03),
                        blurRadius: 5,
                        offset: const Offset(0, 2),
                      )
                    ],
                  ),
                  child: Row(
                    children: [
                      Icon(
                        _getIconForKey(entry.key),
                        color: Colors.green,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          entry.key,
                          style: const TextStyle(fontSize: 15, color: Colors.black87),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        entry.value,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),

            const SizedBox(height: 30),

            // Download button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  // Add export or share logic here
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                icon: const Icon(Iconsax.document_download, color: Colors.white),
                label: const Text(
                  'Download Summary',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  IconData _getIconForKey(String key) {
    switch (key) {
      case 'Loan Type':
        return Iconsax.category;
      case 'Date Issued':
        return Iconsax.calendar;
      case 'Due Date':
        return Iconsax.calendar_1;
      case 'Term':
        return Iconsax.clock;
      case 'Interest Rate':
        return Iconsax.percentage_circle;
      case 'Monthly Payment':
        return Iconsax.wallet_check;
      case 'Total Paid':
        return Iconsax.money_recive;
      default:
        return Iconsax.information;
    }
  }
}

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'loan_payment_method.dart';
import 'package:iconsax/iconsax.dart';

class LoanPaymentPage extends StatelessWidget {
  final double totalLoan = 20000;
  final double interest = 1200;
  final double paidAmount = 5000;
  final DateTime dueDate = DateTime.now().add(const Duration(days: 10));

  final List<Map<String, String>> paymentHistory = [
    {
      "date": "June 10, 2025",
      "amount": "₱1,000.00",
      "method": "GCash",
      "status": "Paid",
      "transactionNo": "TRX123456789",
    },
    {
      "date": "May 25, 2025",
      "amount": "₱2,000.00",
      "method": "Bank Transfer",
      "status": "Paid",
      "transactionNo": "TRX987654321",
    },
    {
      "date": "May 10, 2025",
      "amount": "₱2,000.00",
      "method": "Credit Card",
      "status": "Paid",
      "transactionNo": "TRX543216789",
    },
  ];


  @override
  Widget build(BuildContext context) {
    final remaining = totalLoan + interest - paidAmount;
    final progress = (paidAmount / (totalLoan + interest)).clamp(0.0, 1.0);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title:
        const Text("Loan Payment", style: TextStyle(color: Colors.black)),
        elevation: 1,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
            _buildSummaryCard(context, remaining, progress),
            const SizedBox(height: 28),
            _sectionTitle("Loan Details"),
            _infoRow("Principal", '₱${totalLoan.toStringAsFixed(2)}'),
            _infoRow("Interest", '₱${interest.toStringAsFixed(2)}'),
            _infoRow(
                "Total Loan", '₱${(totalLoan + interest).toStringAsFixed(2)}'),
            _infoRow("Paid", '₱${paidAmount.toStringAsFixed(2)}'),
            _infoRow("Remaining", '₱${remaining.toStringAsFixed(2)}'),
            const SizedBox(height: 30),
            _buildPayNowButton(context, remaining),
            const SizedBox(height: 30),
            _sectionTitle("Payment History"),
            ...paymentHistory
                .map((entry) => _historyTile(context, entry))
                .toList(),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryCard(BuildContext context, double remaining,
      double progress) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.green.shade50,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Amount Due",
              style: TextStyle(fontSize: 15, color: Colors.black)),
          const SizedBox(height: 6),
          Text(
            '₱${remaining.toStringAsFixed(2)}',
            style: const TextStyle(
                fontSize: 30, fontWeight: FontWeight.w600, color: Colors.green),
          ),
          const SizedBox(height: 8),
          Text(
            "Due Date: ${DateFormat.yMMMMd().format(dueDate)}",
            style: const TextStyle(fontSize: 14, color: Colors.black),
          ),
          const SizedBox(height: 14),
          LinearProgressIndicator(
            value: progress,
            color: Colors.green,
            backgroundColor: Colors.green.shade100,
            minHeight: 10,
            borderRadius: BorderRadius.circular(6),
          ),
          const SizedBox(height: 4),
          Text("${(progress * 100).toStringAsFixed(0)}% Paid",
              style: const TextStyle(fontSize: 12, color: Colors.black54)),
        ],
      ),
    );
  }

  Widget _buildPayNowButton(BuildContext context, double remaining) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  SelectPaymentMethodPage(
                    amountPaid: remaining,
                  ),
            ),
          );
        },
        icon: const Icon(Iconsax.card, color: Colors.white),
        label: const Text("Pay Loan Now",
            style: TextStyle(fontSize: 16, color: Colors.white)),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.green,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
      ),
    );
  }

  Widget _infoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label,
              style: const TextStyle(fontSize: 14, color: Colors.black87)),
          Text(value, style: const TextStyle(fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Text(
        title,
        style: const TextStyle(
            fontSize: 17, fontWeight: FontWeight.w600, color: Colors.black),
      ),
    );
  }

  Widget _historyTile(BuildContext context, Map<String, String> entry) {
    return GestureDetector(
      onTap: () {
        showGeneralDialog(
          context: context,
          barrierDismissible: true,
          barrierLabel: "Payment Details",
          barrierColor: Colors.black.withOpacity(0.3), // Background dim
          transitionDuration: const Duration(milliseconds: 300),
          pageBuilder: (context, anim1, anim2) {
            return Align(
              alignment: Alignment.bottomCenter,
              child: Material(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.5,
                  padding: const EdgeInsets.all(20),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                  ),
                  child: Column(
                    children: [
                      Container(
                        width: 40,
                        height: 5,
                        margin: const EdgeInsets.only(bottom: 15),
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            entry['status']! == "Paid"
                                ? Iconsax.tick_circle
                                : Iconsax.close_circle,
                            color: entry['status']! == "Paid"
                                ? Colors.green
                                : Colors.red,
                            size: 24,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            "Payment Details",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                color: Colors.black87),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                      const SizedBox(height: 25),
                      _buildDetailItem(
                          Iconsax.calendar_1, "Payment Date", entry['date']!),
                      _buildDetailItem(
                          Iconsax.money_send, "Amount Paid", entry['amount']!),
                      _buildDetailItem(Iconsax.card_pos, "Payment Method",
                          entry['method']!),
                      _buildDetailItem(
                          entry['status']! == "Paid"
                              ? Iconsax.task_square
                              : Iconsax.warning_2,
                          "Status", entry['status']!),
                      _buildDetailItem(Iconsax.document_text_1,
                          "Transaction No.", entry['transactionNo']!),
                    ],
                  ),
                ),
              ),
            );
          },
          transitionBuilder: (context, animation, secondaryAnimation, child) {
            final curvedAnimation = CurvedAnimation(
              parent: animation,
              curve: Curves.easeOutCubic,
            );
            return SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0, 1),
                end: Offset.zero,
              ).animate(curvedAnimation),
              child: child,
            );
          },
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade200),
          borderRadius: BorderRadius.circular(12),
          color: Colors.green[50],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(entry['amount']!,
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w600)),
              const SizedBox(height: 4),
              Text(entry['date']!,
                  style: const TextStyle(fontSize: 13, color: Colors.black54)),
            ]),
            Icon(Iconsax.arrow_right_3, color: Colors.grey.shade400),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailItem(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        children: [
          Icon(icon, color: Colors.green, size: 22),
          const SizedBox(width: 15),
          Expanded(
            child: Text(
              label,
              style: TextStyle(fontSize: 15, color: Colors.black),
            ),
          ),
          Text(
            value,
            style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: Colors.black87),
          ),
        ],
      ),
    );
  }
}
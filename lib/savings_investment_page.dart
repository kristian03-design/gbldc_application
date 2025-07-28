import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class SavingsAndInvestmentPage extends StatefulWidget {
  const SavingsAndInvestmentPage({super.key});

  @override
  State<SavingsAndInvestmentPage> createState() => _SavingsAndInvestmentPageState();
}

class _SavingsAndInvestmentPageState extends State<SavingsAndInvestmentPage> {
  double savings = 80000;
  double investments = 40500;
  List<Map<String, dynamic>> transactions = [
    {'title': 'Investment Return', 'amount': 1200, 'date': 'Today', 'type': 'credit', 'color': Colors.green},
    {'title': 'Deposit', 'amount': 5000, 'date': 'Yesterday', 'type': 'credit', 'color': Colors.green},
    {'title': 'Withdrawal', 'amount': 2000, 'date': '2 days ago', 'type': 'debit', 'color': Colors.red},
    {'title': 'Investment', 'amount': 10000, 'date': '3 days ago', 'type': 'debit', 'color': Colors.blue},
  ];

  void _showActionDialog(String action) {
    final controller = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('$action Amount'),
        content: TextField(
          controller: controller,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(hintText: 'Enter amount'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              final amount = double.tryParse(controller.text) ?? 0;
              if (amount > 0) {
                setState(() {
                  if (action == 'Deposit') {
                    savings += amount;
                    transactions.insert(0, {
                      'title': 'Deposit',
                      'amount': amount,
                      'date': 'Now',
                      'type': 'credit',
                      'color': Colors.green,
                    });
                  } else if (action == 'Withdraw') {
                    if (savings >= amount) {
                      savings -= amount;
                      transactions.insert(0, {
                        'title': 'Withdrawal',
                        'amount': amount,
                        'date': 'Now',
                        'type': 'debit',
                        'color': Colors.red,
                      });
                    }
                  } else if (action == 'Invest') {
                    if (savings >= amount) {
                      savings -= amount;
                      investments += amount;
                      transactions.insert(0, {
                        'title': 'Investment',
                        'amount': amount,
                        'date': 'Now',
                        'type': 'debit',
                        'color': Colors.blue,
                      });
                    }
                  }
                });
                Navigator.pop(context);
              }
            },
            child: const Text('Confirm'),
          ),
        ],
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    double totalBalance = savings + investments;
    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FA),
      appBar: AppBar(
        title: const Text('Savings & Investments', style: TextStyle(fontWeight: FontWeight.w600)),
        backgroundColor: Colors.white,
        elevation: 0.5,
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            elevation: 0,
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Total Balance', style: TextStyle(color: Colors.grey, fontSize: 14)),
                  const SizedBox(height: 6),
                  Text('₱ ${totalBalance.toStringAsFixed(2)}', style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 18),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _miniSummary('Savings', '₱ ${savings.toStringAsFixed(2)}'),
                      _miniSummary('Investments', '₱ ${investments.toStringAsFixed(2)}'),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () => _showActionDialog('Deposit'),
                child: _quickAction(Iconsax.add, 'Deposit', Colors.green),
              ),
              GestureDetector(
                onTap: () => _showActionDialog('Withdraw'),
                child: _quickAction(Iconsax.arrow_up_1, 'Withdraw', Colors.orange),
              ),
              GestureDetector(
                onTap: () => _showActionDialog('Invest'),
                child: _quickAction(Iconsax.trend_up, 'Invest', Colors.blue),
              ),
            ],
          ),
          const SizedBox(height: 32),
          const Text('Recent Transactions', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16)),
          const SizedBox(height: 12),
          ...transactions.map((tx) => _transactionTile(
            tx['title'],
            '${tx['type'] == 'credit' ? '+' : '-'}₱ ${tx['amount'].toStringAsFixed(0)}',
            tx['date'],
            tx['color'],
          )),
        ],
      ),
    );
  }

  Widget _miniSummary(String label, String amount) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(color: Colors.grey, fontSize: 13)),
        const SizedBox(height: 2),
        Text(amount, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16)),
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

  Widget _transactionTile(String title, String amount, String date, Color color) {
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 0,
      color: Colors.white,
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: color.withOpacity(0.13),
          child: Icon(Iconsax.receipt, color: color),
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w500)),
        subtitle: Text(date, style: const TextStyle(fontSize: 12, color: Colors.grey)),
        trailing: Text(
          amount,
          style: TextStyle(
            color: color,
            fontWeight: FontWeight.w600,
            fontSize: 15,
          ),
        ),
      ),
    );
  }
}
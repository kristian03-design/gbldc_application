// ignore_for_file: unnecessary_to_list_in_spreads

import 'package:flutter/material.dart';
import 'payment-confirmation.dart';
import 'package:iconsax/iconsax.dart';

class SelectPaymentMethodPage extends StatefulWidget {
  final double amountPaid;

  const SelectPaymentMethodPage({Key? key, required this.amountPaid})
      : super(key: key);

  @override
  _SelectPaymentMethodPageState createState() =>
      _SelectPaymentMethodPageState();
}

class _SelectPaymentMethodPageState extends State<SelectPaymentMethodPage> {
  String _selectedMethod = 'GCash';
  double? _customAmount;

  final List<Map<String, dynamic>> paymentMethods = [
    {'name': 'GCash', 'icon': 'assets/images/g-cash.jpeg'},
    {'name': 'Maya', 'icon': 'assets/images/maya.jpeg'},
    {'name': 'PayPal', 'icon': 'assets/images/gbldc_paypal.png'},
    {'name': 'Credit Card', 'icon': 'assets/images/visa-card.png'},
  ];

  final TextEditingController _amountController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _amountController.text = widget.amountPaid.toStringAsFixed(2);
    _customAmount = widget.amountPaid;
  }

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  void _navigateToConfirmation() {
    if (_customAmount! <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a valid payment amount')),
      );
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => PaymentConfirmationPage(
          amountPaid: _customAmount!,
          paymentMethod: _selectedMethod,
          transactionNumber: "N/A", // Placeholder for actual transaction number
        ),
      ),
    );
  }

  void _showConfirmationModal() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 30),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Row(
                children: [
                  Icon(Iconsax.receipt_text, color: Colors.green),
                  SizedBox(width: 8),
                  Text(
                    "Payment Summary",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              _loanInfoRow(Iconsax.money_send, "Amount Due",
                  '₱${_customAmount!.toStringAsFixed(2)}'),
              _loanInfoRow(Iconsax.percentage_circle, "Interest Rate", "6%"),
              _loanInfoRow(Iconsax.card_pos, "Payment Type", "Partial / Full"),
              _loanInfoRow(
                  Iconsax.wallet_check, "Payment Method", _selectedMethod),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: TextButton.icon(
                      icon:
                          const Icon(Iconsax.close_circle, color: Colors.green),
                      onPressed: () => Navigator.pop(context),
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.green[50],
                      ),
                      label: const Text("Cancel",
                          style: TextStyle(fontSize: 14, color: Colors.green)),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton.icon(
                      icon:
                          const Icon(Iconsax.tick_circle, color: Colors.white),
                      onPressed: () {
                        Navigator.pop(context);
                        _navigateToConfirmation();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      label: const Text("Confirm",
                          style: TextStyle(color: Colors.white)),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _loanInfoRow(IconData icon, String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(icon, size: 20, color: Colors.green),
              const SizedBox(width: 8),
              Text(title, style: const TextStyle(fontSize: 14)),
            ],
          ),
          Text(value,
              style:
                  const TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }

  Widget _paymentMethodTile(Map<String, dynamic> method) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 0, vertical: 4),
      leading: CircleAvatar(
        backgroundColor: Colors.white,
        backgroundImage: AssetImage(method['icon']),
        radius: 20,
      ),
      title: Text(method['name'],
          style: const TextStyle(fontWeight: FontWeight.w500)),
      trailing: Radio<String>(
        value: method['name'],
        groupValue: _selectedMethod,
        onChanged: (value) {
          setState(() {
            _selectedMethod = value!;
          });
        },
        activeColor: Colors.green,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Select Payment Method',
            style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
        elevation: 1,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
            Row(
              children: [
                Icon(Iconsax.document_text, color: Colors.green),
                SizedBox(width: 8),
                Text("Loan Summary",
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
              ],
            ),
            // const Text("Loan Summary",
            //     style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
            const SizedBox(height: 10),
            _loanInfoRow(Iconsax.money_send, "Amount Due",
                '₱${widget.amountPaid.toStringAsFixed(2)}'),
            _loanInfoRow(Iconsax.percentage_circle, "Interest Rate", "6%"),
            _loanInfoRow(Iconsax.card_pos, "Payment Type", "Partial / Full"),
            const SizedBox(height: 25),
            const Row(
              children: [
                Icon(Iconsax.wallet_money, color: Colors.green),
                SizedBox(width: 8),
                Text("Enter Amount to Pay",
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
              ],
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _amountController,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              onChanged: (value) {
                setState(() {
                  _customAmount = double.tryParse(value) ?? 0;
                });
              },
              decoration: InputDecoration(
                prefixIcon: const Icon(Iconsax.wallet_2, color: Colors.green),
                prefixText: "₱ ",
                hintText: "0.00",
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.green.shade200),
                ),
              ),
            ),
            const SizedBox(height: 25),
            const Text("Choose Payment Method",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
            const SizedBox(height: 12),
            ...paymentMethods
                .map((method) => _paymentMethodTile(method))
                .toList(),
            const SizedBox(height: 30),
            const Text(
              "Note: You can make a partial payment or pay the full amount. Choose your preferred method and confirm your transaction.",
              style: TextStyle(
                  fontSize: 13,
                  color: Colors.black54,
                  fontStyle: FontStyle.italic),
            ),
            const SizedBox(height: 40),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: _showConfirmationModal,
                icon: const Icon(Iconsax.arrow_right_1, color: Colors.white),
                label: const Text("Proceed to Pay",
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.w500)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

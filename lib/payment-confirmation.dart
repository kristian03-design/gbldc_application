import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'loan-page.dart';
import 'package:iconsax/iconsax.dart';

class PaymentConfirmationPage extends StatefulWidget {
  final double amountPaid;
  final String paymentMethod;
  final String transactionNumber;

  const PaymentConfirmationPage({
    super.key,
    required this.amountPaid,
    this.paymentMethod = "GCash",
    required this.transactionNumber,
  });

  @override
  State<PaymentConfirmationPage> createState() =>
      _PaymentConfirmationPageState();
}

class _PaymentConfirmationPageState extends State<PaymentConfirmationPage>
    with TickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _fadeIn;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );

    _fadeIn = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    );

    Future.delayed(const Duration(milliseconds: 500), () {
      _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final String formattedDate =
    DateFormat('MMMM d, y – hh:mm a').format(DateTime.now());

    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              const SizedBox(height: 40),
              Container(
                padding: const EdgeInsets.all(30),
                decoration: BoxDecoration(
                  color: Colors.green[50], // Example background color
                  borderRadius: BorderRadius.circular(100), // Example border radius
                ),
                child: const Icon(
                  Iconsax.tick_circle,
                  color: Color(0xFF22C55E),
                  size: 120,
                ),
              ),
              const SizedBox(height: 24),
              FadeTransition(
                opacity: _fadeIn,
                child: Column(
                  children: [
                    const Text(
                      "Payment Successful",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF111827),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      "₱${widget.amountPaid.toStringAsFixed(2)} has been paid.",
                      style: const TextStyle(
                        fontSize: 16,
                        color: Color(0xFF6B7280),
                      ),
                    ),
                    const SizedBox(height: 32),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 30),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 10,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          _paymentDetail("Payment Date", formattedDate),
                          const SizedBox(height: 16),
                          _paymentDetail("Transaction Number", widget.transactionNumber),
                          const SizedBox(height: 16),
                          _paymentDetail("Payment Method", widget.paymentMethod),
                          const SizedBox(height: 16),
                          _paymentDetail("Amount Paid",
                              "₱${widget.amountPaid.toStringAsFixed(2)}"),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (_) => LoanPageHomepage()),
                          (route) => false,
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF22C55E),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 2,
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Iconsax.arrow_left_3, color: Colors.white, size: 20),
                      SizedBox(width: 8),
                      Text(
                        "Back to Loan Page",
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ],
                  )

                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _paymentDetail(String title, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 15,
            color: Color(0xFF6B7280),
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: Color(0xFF111827),
          ),
        ),
      ],
    );
  }
}

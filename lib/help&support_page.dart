import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:iconsax/iconsax.dart';

import 'contact-support-page.dart';

void main() {
  runApp(const HelpSupportApp());
}

class HelpSupportApp extends StatelessWidget {
  const HelpSupportApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Help & Support',
      debugShowCheckedModeBanner: false,
      home: const HelpSupportPage(),
    );
  }
}

class HelpSupportPage extends StatefulWidget {
  const HelpSupportPage({super.key});

  @override
  State<HelpSupportPage> createState() => _HelpSupportPageState();
}

class _HelpSupportPageState extends State<HelpSupportPage> {
  final TextEditingController _searchController = TextEditingController();
  final TextEditingController _ticketSubjectController =
      TextEditingController();
  final TextEditingController _ticketMessageController =
      TextEditingController();

  String _searchQuery = '';

  final List<Map<String, String>> faqs = [
    {
      "question": "How do I reset my password?",
      "answer":
          "Go to the login screen, tap 'Forgot Password', and follow the instructions."
    },
    {
      "question": "How can I apply for a loan?",
      "answer":
          "Navigate to the Home screen, tap on 'Apply' and complete the form."
    },
    {
      "question": "How to check my loan status?",
      "answer": "Go to the Loan page to view your active and past loans."
    },
    {
      "question": "How do I update my contact information?",
      "answer": "Go to Profile > Edit Info to update your phone or email."
    },
  ];

  List<Map<String, String>> ticketHistory = [
    {
      "ticket": "#456123",
      "status": "Resolved",
      "date": "July 10, 2025",
      "description":
          "My payment was not reflected in my account. I have attached the proof of payment for your review. Please update my account balance accordingly."
    },
    {
      "ticket": "#456122",
      "status": "In Progress",
      "date": "July 6, 2025",
      "description":
          "I am having trouble logging into the mobile app. It keeps showing an 'Invalid Credentials' error even though I am sure my username and password are correct. I have tried resetting my password, but the issue persists."
    },
  ];

  void _deleteTicket(Map<String, String> ticket) {
    setState(() {
      ticketHistory.remove(ticket);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('${ticket['ticket']} deleted')),
    );
  }

  void _showTicketDetails(Map<String, String> ticket) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: Text(ticket['ticket']!,
              style:
                  TextStyle(fontWeight: FontWeight.w600, color: Colors.green)),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildDetailRow("Status:", ticket['status']!,
                    valueColor: ticket['status'] == 'Resolved'
                        ? Colors.green
                        : Colors.orange),
                _buildDetailRow("Date:", ticket['date']!),
                const SizedBox(height: 12),
                const Text("Description:",
                    style:
                        TextStyle(fontWeight: FontWeight.w600, fontSize: 15)),
                const SizedBox(height: 6),
                Text(ticket['description']!,
                    style: TextStyle(fontSize: 14, color: Colors.black87)),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("CLOSE",
                  style: TextStyle(
                      color: Colors.green, fontWeight: FontWeight.bold)),
            ),
          ],
        );
      },
    );
  }

  Widget _buildDetailRow(String label, String value, {Color? valueColor}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("$label ",
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15)),
          Expanded(
              child: Text(value,
                  style: TextStyle(
                      fontSize: 15, color: valueColor ?? Colors.black87))),
        ],
      ),
    );
  }

  void _openTicketModal() {
    bool _isSubmitting = false;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Padding(
              padding: EdgeInsets.only(
                top: 20,
                left: 20,
                right: 20,
                bottom: MediaQuery.of(context).viewInsets.bottom + 20,
              ),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Container(
                        width: 50,
                        height: 5,
                        margin: const EdgeInsets.only(bottom: 16),
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                    const Text(
                      "Open New Support Ticket",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Divider(thickness: 1, height: 20),
                    const SizedBox(height: 10),
                    const Text("Subject",
                        style: TextStyle(fontWeight: FontWeight.w500)),
                    const SizedBox(height: 6),
                    TextField(
                      controller: _ticketSubjectController,
                      enabled: !_isSubmitting,
                      decoration: InputDecoration(
                        hintText: "Brief subject of your concern",
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12)),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide:
                              const BorderSide(color: Colors.green, width: 2),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text("Message",
                        style: TextStyle(fontWeight: FontWeight.w500)),
                    const SizedBox(height: 6),
                    TextField(
                      controller: _ticketMessageController,
                      maxLines: 4,
                      enabled: !_isSubmitting,
                      decoration: InputDecoration(
                        hintText: "Describe your issue in detail...",
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12)),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide:
                              const BorderSide(color: Colors.green, width: 2),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    Center(
                      child: FloatingActionButton.extended(
                        onPressed: _isSubmitting
                            ? null
                            : () async {
                                setModalState(() => _isSubmitting = true);
                                await Future.delayed(
                                    const Duration(seconds: 2));
                                if (context.mounted) {
                                  Navigator.pop(context);
                                }
                                _ticketSubjectController.clear();
                                _ticketMessageController.clear();
                                showDialog(
                                  context: context,
                                  builder: (_) => AlertDialog(
                                    backgroundColor: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    contentPadding: const EdgeInsets.all(24),
                                    content: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: const [
                                        Icon(Iconsax.tick_circle,
                                            color: Colors.green, size: 64),
                                        SizedBox(height: 16),
                                        Text(
                                          "Ticket Submitted",
                                          style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 18,
                                            color: Colors.black87,
                                          ),
                                        ),
                                        SizedBox(height: 8),
                                        Text(
                                          "Your support ticket has been sent.\nOur team will get back to you soon.",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(fontSize: 14),
                                        ),
                                      ],
                                    ),
                                    actions: [
                                      Center(
                                        child: TextButton(
                                          onPressed: () => Navigator.pop(_),
                                          child: const Text(
                                            "OK",
                                            style:
                                                TextStyle(color: Colors.green),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                        icon: _isSubmitting
                            ? const SizedBox(
                                width: 18,
                                height: 18,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: Colors.white,
                                ),
                              )
                            : const Icon(
                                Iconsax.send_2,
                                color: Colors.white,
                              ),
                        label: Text(
                          _isSubmitting ? "Submitting..." : "Submit Ticket",
                          style: TextStyle(color: Colors.white),
                        ),
                        backgroundColor: Colors.green,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  @override
  void dispose() {
    _ticketSubjectController.dispose();
    _ticketMessageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final filteredFaqs = faqs
        .where((faq) =>
            faq['question']!.toLowerCase().contains(_searchQuery.toLowerCase()))
        .toList();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        centerTitle: true,
        title: const Text("Help & Support",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600)),
        leading: IconButton(
          icon: const Icon(Iconsax.arrow_left, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        children: [
          Center(
            child: Image.asset(
              'assets/images/logocoop.png',
              height: 60,
              fit: BoxFit.contain,
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _searchController,
            onChanged: (value) => setState(() => _searchQuery = value),
            decoration: InputDecoration(
              hintText: 'Search FAQs or concerns...',
              prefixIcon: const Icon(Iconsax.search_normal),
              filled: true,
              fillColor: Colors.grey.shade100,
              contentPadding: const EdgeInsets.symmetric(vertical: 14),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
            ),
          ),
          const SizedBox(height: 20),
          const Text('Contact Us',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          LiveChatPage(),
                      transitionsBuilder:
                          (context, animation, secondaryAnimation, child) {
                        const begin = Offset(1.0, 0.0);
                        const end = Offset.zero;
                        const curve = Curves.ease;
                        final tween = Tween(begin: begin, end: end)
                            .chain(CurveTween(curve: curve));
                        return SlideTransition(
                          position: animation.drive(tween),
                          child: child,
                        );
                      },
                    ),
                  );
                },
                child: _contactIcon(Iconsax.message, 'Live Chat'),
              ),
              GestureDetector(
                onTap: () {
                  // Navigate to Email support or open mail client
                  // Example: launch('mailto:support@example.com');
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Email tapped')),
                  );
                },
                child: _contactIcon(Iconsax.direct, 'Email'),
              ),
              GestureDetector(
                onTap: () {
                  // Navigate to Call support or open dialer
                  // Example: launch('tel:+1234567890');
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Call tapped')),
                  );
                },
                child: _contactIcon(Iconsax.call, 'Call'),
              ),
            ],
          ),
          const SizedBox(height: 24),
          const Text('FAQs',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          ...filteredFaqs.map((faq) => _buildFaqTile(faq)).toList(),
          if (filteredFaqs.isEmpty)
            const Padding(
              padding: EdgeInsets.only(top: 12),
              child: Text('No matching FAQs found.',
                  style: TextStyle(color: Colors.grey)),
            ),
          const SizedBox(height: 28),
          const Text('Ticket History',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          if (ticketHistory.isEmpty)
            const Padding(
              padding: EdgeInsets.only(top: 12),
              child: Text('No ticket history available.',
                  style: TextStyle(color: Colors.grey)),
            )
          else
            ...ticketHistory.map((ticket) {
              return Slidable(
                  key: ValueKey(ticket['ticket']),
                  endActionPane: ActionPane(
                    motion: const StretchMotion(),
                    dismissible: DismissiblePane(onDismissed: () {
                      _deleteTicket(ticket);
                    }),
                    children: [
                      SlidableAction(
                          onPressed: (context) => _deleteTicket(ticket),
                          backgroundColor: Colors.red,
                          foregroundColor: Colors.white,
                          icon: Iconsax.trash,
                          label: 'Delete')
                    ],
                  ),
                  child: _buildTicketTile(ticket));
            }).toList(),
          const SizedBox(height: 30),
          Center(
            child: FloatingActionButton.extended(
              onPressed: _openTicketModal,
              icon: const Icon(
                Iconsax.add,
                color: Colors.white,
              ),
              label: const Text("Open a Support Ticket",
                  style: TextStyle(color: Colors.white)),
              backgroundColor: Colors.green,
            ),
          ),
        ],
      ),
    );
  }

  Widget _contactIcon(IconData icon, String label) {
    return Column(
      children: [
        CircleAvatar(
          backgroundColor: Colors.green.shade50,
          radius: 26,
          child: Icon(icon, color: Colors.green),
        ),
        const SizedBox(height: 6),
        Text(label,
            style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500)),
      ],
    );
  }

  Widget _buildFaqTile(Map<String, String> faq) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          tilePadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
          title: Row(
            children: [
              const Icon(Iconsax.info_circle, color: Colors.green),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  faq['question']!,
                  style: const TextStyle(
                      fontWeight: FontWeight.w600, fontSize: 15),
                ),
              ),
            ],
          ),
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                faq['answer']!,
                style: const TextStyle(fontSize: 14, color: Colors.black87),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTicketTile(Map<String, String> ticket) {
    return GestureDetector(
      onTap: () => _showTicketDetails(ticket),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 6),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.green.shade50,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.green.shade100),
        ),
        child: Row(
          children: [
            const Icon(Iconsax.ticket, color: Colors.green),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(ticket['ticket']!,
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 4),
                  Text(
                    ticket['status']!,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: ticket['status'] == 'Resolved'
                          ? Colors.green
                          : Colors.orange,
                    ),
                  ),
                  Text(ticket['date']!,
                      style: const TextStyle(fontSize: 12, color: Colors.grey)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'loan-details.dart';
import 'package:iconsax/iconsax.dart';

class LoanHistoryPage extends StatefulWidget {
  @override
  _LoanHistoryPageState createState() => _LoanHistoryPageState();
}

class _LoanHistoryPageState extends State<LoanHistoryPage> {
  final List<Map<String, String>> allLoans = [
    {
      'amount': '₱ 5,200.00',
      'date': 'Jan 22, 2025 - 09:41 AM',
      'status': 'Paid Off',
      'type': 'Personal'
    },
    {
      'amount': '₱ 10,800.00',
      'date': 'Nov 15, 2024 - 11:15 PM',
      'status': 'Pending',
      'type': 'Business'
    },
    {
      'amount': '₱ 15,500.00',
      'date': 'Oct 28, 2024 - 10:30 AM',
      'status': 'Rejected',
      'type': 'Emergency'
    },
    {
      'amount': '₱ 12,600.00',
      'date': 'Sep 10, 2024 - 10:00 AM',
      'status': 'Paid Off',
      'type': 'Personal'
    },
    {
      'amount': '₱ 8,700.00',
      'date': 'Aug 05, 2024 - 08:05 AM',
      'status': 'Paid Off',
      'type': 'Business'
    },
    {
      'amount': '₱ 9,900.00',
      'date': 'Jul 20, 2024 - 12:02 PM',
      'status': 'Pending',
      'type': 'Emergency'
    },
    {
      'amount': '₱ 20,400.00',
      'date': 'Jun 18, 2024 - 10:00 AM',
      'status': 'Rejected',
      'type': 'Personal'
    },
    {
      'amount': '₱ 25,100.00',
      'date': 'Jun 01, 2024 - 04:00 PM',
      'status': 'Paid Off',
      'type': 'Business'
    },
  ];

  String searchQuery = '';
  String selectedStatus = 'All';
  String selectedType = 'All';

  List<Map<String, String>> get filteredLoans {
    return allLoans.where((loan) {
      final matchesStatus =
          selectedStatus == 'All' || loan['status'] == selectedStatus;
      final matchesType = selectedType == 'All' || loan['type'] == selectedType;
      final matchesSearch =
          loan['amount']!.toLowerCase().contains(searchQuery.toLowerCase()) ||
              loan['date']!.toLowerCase().contains(searchQuery.toLowerCase());
      return matchesStatus && matchesType && matchesSearch;
    }).toList();
  }

  Icon _getLoanIcon(String type) {
    switch (type) {
      case 'Personal':
        return const Icon(Iconsax.profile_circle, color: Colors.green);
      case 'Business':
        return const Icon(Iconsax.briefcase, color: Colors.blueAccent);
      case 'Emergency':
        return const Icon(Iconsax.danger, color: Colors.redAccent);
      default:
        return const Icon(Iconsax.money_2, color: Colors.grey);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(
        title:
            const Text('Loan History', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 1,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          // Search and Filters
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.08),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: SizedBox(
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Search by amount or date',
                          prefixIcon: const Icon(Iconsax.search_normal),
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding:
                              const EdgeInsets.symmetric(horizontal: 20),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none,
                          ),
                        ),
                        onChanged: (value) {
                          setState(() => searchQuery = value);
                        },
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                // Status Filter
                Container(
                  width: 140,
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.08),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: DropdownButtonFormField<String>(
                    dropdownColor: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    value: selectedStatus,
                    icon: const Icon(Iconsax.filter),
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(vertical: 6),
                    ),
                    items: ['All', 'Paid Off', 'Pending', 'Rejected']
                        .map((status) => DropdownMenuItem(
                              value: status,
                              child: Text(status),
                            ))
                        .toList(),
                    onChanged: (value) {
                      setState(() => selectedStatus = value!);
                    },
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 10),

          // Loan List
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              itemCount: filteredLoans.length,
              separatorBuilder: (_, __) => const SizedBox(height: 14),
              itemBuilder: (context, index) {
                final loan = filteredLoans[index];

                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => LoanDetailsPage()),
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(14),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 6,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        // Loan Icon
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.grey[100],
                            shape: BoxShape.circle,
                          ),
                          child: _getLoanIcon(loan['type'] ?? ''),
                        ),
                        const SizedBox(width: 16),

                        // Loan Info
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                loan['amount']!,
                                style: const TextStyle(
                                    fontSize: 17, fontWeight: FontWeight.w600),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                loan['date']!,
                                style: TextStyle(
                                    fontSize: 13, color: Colors.grey[600]),
                              ),
                            ],
                          ),
                        ),

                        // Status Tag
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: _getStatusColor(loan['status']),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            children: [
                              Text(
                                loan['status']!,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(width: 4),
                              const Icon(Icons.chevron_right,
                                  color: Colors.white, size: 16),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(String? status) {
    switch (status) {
      case 'Paid Off':
        return Colors.green;
      case 'Pending':
        return Colors.orange;
      case 'Rejected':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
}

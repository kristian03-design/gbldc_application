import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class PaymentHistoryPage extends StatefulWidget {
  const PaymentHistoryPage({super.key});

  @override
  State<PaymentHistoryPage> createState() => _PaymentHistoryPageState();
}

class _PaymentHistoryPageState extends State<PaymentHistoryPage> {
  final List<Map<String, dynamic>> transactions = [
    {
      "date": "July 10, 2025",
      "amount": 2000.0,
      "method": "GCash",
      "reference": "TXN123456",
      "status": "Paid"
    },
    {
      "date": "July 8, 2025",
      "amount": 1500.0,
      "method": "Maya",
      "reference": "TXN654321",
      "status": "Pending"
    },
    {
      "date": "July 5, 2025",
      "amount": 3500.0,
      "method": "Bank Transfer",
      "reference": "TXN908765",
      "status": "Failed"
    },
    {
      "date": "July 3, 2025",
      "amount": 2500.0,
      "method": "GCash",
      "reference": "TXN111111",
      "status": "Paid"
    },
    {
      "date": "July 13, 2025",
      "amount": 8600.0,
      "method": "Credit Card",
      "reference": "TXN2426548",
      "status": "Paid"
    }
  ];

  String searchQuery = '';
  String selectedStatus = 'All';

  List<Map<String, dynamic>> get filteredTransactions {
    return transactions.where((txn) {
      final matchesQuery =
      txn["reference"].toLowerCase().contains(searchQuery.toLowerCase());
      final matchesStatus =
          selectedStatus == "All" || txn["status"] == selectedStatus;
      return matchesQuery && matchesStatus;
    }).toList();
  }

  void _showTransactionDetails(Map<String, dynamic> txn) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) {
        return Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey[400],
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                "Transaction Details",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.green[700],
                ),
              ),
              const SizedBox(height: 20),
              _detailRow("Reference No:", txn["reference"]),
              _detailRow("Date:", txn["date"]),
              _detailRow("Amount Paid:", "₱${txn["amount"].toStringAsFixed(2)}"),
              _detailRow("Payment Method:", txn["method"]),
              _detailRow("Status:", txn["status"]),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(Iconsax.document_download, color: Colors.white),
                label: const Text(
                  "Download Receipt",
                  style: TextStyle(fontSize: 14, color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  minimumSize: const Size.fromHeight(50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }

  Widget _detailRow(String title, String value) {
    return Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: Row(
            children: [
            Expanded(child: Text(title, style: const TextStyle(fontSize: 15))),
    Text(value,
        style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 15)),
    ],
    ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Payment History", style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
        elevation: 1,
      ),
      backgroundColor: const Color(0xFFF1F5F9),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  flex: 3,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 4,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: TextField(
                      onChanged: (value) => setState(() => searchQuery = value),
                      decoration: InputDecoration(
                        hintText: 'Search Ref No.',
                        prefixIcon: const Icon(Iconsax.search_normal, color: Colors.black54),
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.green, width: 1.2),
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 4,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: selectedStatus,
                      borderRadius: BorderRadius.circular(10),
                      dropdownColor: Colors.white,
                      items: const [
                        DropdownMenuItem(value: "All", child: Text("All")),
                        DropdownMenuItem(value: "Paid", child: Text("Paid")),
                        DropdownMenuItem(value: "Pending", child: Text("Pending")),
                        DropdownMenuItem(value: "Failed", child: Text("Failed")),
                      ],
                      onChanged: (value) => setState(() => selectedStatus = value!),
                      icon: const Icon(Iconsax.filter),
                      style: const TextStyle(color: Colors.black),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: filteredTransactions.length,
                itemBuilder: (context, index) {
                  final txn = filteredTransactions[index];
                  return InkWell(
                    onTap: () => _showTransactionDetails(txn),
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(14),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 6,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "₱${txn["amount"].toStringAsFixed(2)}",
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17,
                                ),
                              ),
                              const SizedBox(height: 6),
                              Text(txn["date"], style: const TextStyle(color: Colors.grey)),
                              Text(
                                txn["method"],
                                style: const TextStyle(fontSize: 12, color: Colors.grey),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                txn["status"],
                                style: TextStyle(
                                  color: txn["status"] == "Paid"
                                      ? Colors.green
                                      : txn["status"] == "Pending"
                                      ? Colors.orange
                                      : Colors.red,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                txn["reference"],
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Colors.black54,
                                ),
                              ),
                            ],
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
      ),
    );
  }
}

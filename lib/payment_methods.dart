import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'add_payment_method.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Payment Methods',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
        fontFamily: 'Poppins',
      ),
      home: const PaymentMethods(),
    );
  }
}

class PaymentMethods extends StatefulWidget {
  const PaymentMethods({super.key});

  @override
  State<PaymentMethods> createState() => _PaymentMethodsState();
}

class _PaymentMethodsState extends State<PaymentMethods> {

  final List<Map<String, String>> allMethods = [
    {
      'type': 'Wallet',
      'name': 'GCASH',
      'number': '(+63) 912 345 6789',
      'owner': 'Kristian Lloyd Hernandez',
      'logo': 'assets/images/g-cash.jpeg',
    },
    {
      'type': 'Wallet',
      'name': 'Maya Bank',
      'number': '(+63) 912 345 6789',
      'owner': 'Kristian Lloyd Hernandez',
      'logo': 'assets/images/maya.jpeg',
    },
    {
      'type': 'Wallet',
      'name': 'GoTyme Bank',
      'number': '(+63) 912 345 6789',
      'owner': 'Kristian Lloyd DC Hernandez',
      'logo': 'assets/images/gotyme.jpeg',
    },
  ];

  void _deleteAccount(int index) {
    setState(() {
      allMethods.removeAt(index);
    });
  }
  void _showAddPaymentMethodModal() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      backgroundColor: Colors.white,
      builder: (BuildContext context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Add New Method',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 20),
                ListTile(
                  leading: const Icon(Iconsax.bank, color: Colors.green),
                  title: const Text('Add Payment Method'),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const AddPaymentMethodPage()),
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6F9),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Payment Methods',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
        child: Column(
            children: [
            Expanded(
              child: allMethods.isEmpty
                  ? const Center(
                child: Text(
                  'No payment methods added yet.',
                  style: TextStyle(color: Colors.grey),
                ),
              )
                  : ListView.separated(
                itemCount: allMethods.length,
                separatorBuilder: (_, __) => const SizedBox(height: 16),
                itemBuilder: (context, index) {
                  final account = allMethods[index];
                  return Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(14),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12.withOpacity(0.05),
                          blurRadius: 6,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.asset(
                            account['logo']!,
                            width: 50,
                            height: 50,
                            fit: BoxFit.cover,
                            errorBuilder: (_, __, ___) => const Icon(
                              Iconsax.wallet_2,
                              size: 40,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(account['name']!,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16)),
                              const SizedBox(height: 4),
                              Text(account['number']!,
                                  style: const TextStyle(
                                      color: Colors.grey, fontSize: 13)),
                              Text(account['owner']!,
                                  style: const TextStyle(
                                      color: Colors.grey, fontSize: 13)),
                            ],
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Iconsax.trash,
                              color: Colors.red),
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (_) => AlertDialog(
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                    BorderRadius.circular(12)),
                                backgroundColor: Colors.white,
                                title: const Text('Confirm Deletion'),
                                content: const Text(
                                  'Are you sure you want to delete this payment method?',
                                  style: TextStyle(height: 1.5),
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.pop(context),
                                    child: const Text('Cancel',
                                        style: TextStyle(
                                            color: Colors.black)),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      _deleteAccount(index);
                                      Navigator.pop(context);
                                    },
                                    child: const Text('Delete',
                                        style:
                                        TextStyle(color: Colors.red)),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddPaymentMethodModal,
        backgroundColor: Colors.green,
        child: const Icon(Iconsax.add, color: Colors.white),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'add_bank_account.dart';
import 'package:iconsax/iconsax.dart';

class BankAccountPage extends StatefulWidget {
  const BankAccountPage({super.key});

  @override
  State<BankAccountPage> createState() => _BankAccountPageState();
}

class _BankAccountPageState extends State<BankAccountPage> {
  List<Map<String, String>> bankAccounts = [
    {
      'name': 'Security Bank',
      'number': '•••• 3456',
      'owner': 'Kristian Lloyd Hernandez',
      'logo': 'assets/images/Security-bank.jpeg',
    },
    {
      'name': 'BDO (Banco de Oro)',
      'number': '•••• 4567',
      'owner': 'Kristian Lloyd Hernandez',
      'logo': 'assets/images/bdo.png',
    },
    {
      'name': 'PNB Bank',
      'number': '•••• 3456',
      'owner': 'Kristian Lloyd DC Hernandez',
      'logo': 'assets/images/pnb.png',
    },

  ];

  void _deleteAccount(int index) {
    setState(() {
      bankAccounts.removeAt(index);
    });
  }

  void _showAddBankMethodModal() {
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
                  title: const Text('Add Bank Account'),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const AddBankAccountPage()),
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
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        centerTitle: true,
        title: const Text(
          'Bank Accounts',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w600,
            fontSize: 18,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: bankAccounts.isEmpty
                  ? const Center(
                child: Text(
                  'No bank accounts found.',
                  style: TextStyle(color: Colors.black54, fontSize: 16),
                ),
              )
                  : ListView.builder(
                itemCount: bankAccounts.length,
                itemBuilder: (context, index) {
                  final account = bankAccounts[index];
                  return Container(
                    margin: const EdgeInsets.only(bottom: 16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12.withOpacity(0.05),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(16),
                      leading: CircleAvatar(
                        backgroundColor: Colors.grey.shade100,
                        radius: 26,
                        backgroundImage: AssetImage(account['logo']!),
                        onBackgroundImageError: (_, __) =>
                        const Icon(Icons.image),
                      ),
                      title: Text(
                        account['name']!,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      subtitle: Padding(
                        padding: const EdgeInsets.only(top: 4.0),
                        child: Text(
                          '${account['number']} • ${account['owner']}',
                          style: const TextStyle(
                            fontSize: 13,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      trailing: IconButton(
                        icon: const Icon(Iconsax.trash, color: Colors.red),
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (_) => AlertDialog(
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                  BorderRadius.circular(12)),
                              backgroundColor: Colors.white,
                              title: const Text('Remove Account'),
                              content: const Text(
                                  'Are you sure you want to delete this bank account?'),
                              actions: [
                                TextButton(
                                  child: const Text('Cancel',
                                      style:
                                      TextStyle(color: Colors.black)),
                                  onPressed: () => Navigator.pop(context),
                                ),
                                TextButton(
                                  child: const Text('Delete',
                                      style:
                                      TextStyle(color: Colors.red)),
                                  onPressed: () {
                                    _deleteAccount(index);
                                    Navigator.pop(context);
                                  },
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddBankMethodModal,
        backgroundColor: Colors.green,
        child: const Icon(Iconsax.add, color: Colors.white),
      ),
    );
  }
}

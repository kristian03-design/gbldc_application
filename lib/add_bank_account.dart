import 'package:flutter/material.dart';

class AddBankAccountPage extends StatefulWidget {
  const AddBankAccountPage({super.key});

  @override
  State<AddBankAccountPage> createState() => _AddBankAccountPageState();
}

class _AddBankAccountPageState extends State<AddBankAccountPage> {
  final _formKey = GlobalKey<FormState>();
  final _accountNumberController = TextEditingController();
  final _ownerNameController = TextEditingController();

  String? selectedBank;

  final List<String> bankOptions = [
    'BDO (Banco de Oro)',
    'BPI (Bank of the Philippine Islands)',
    'UnionBank',
    'Security Bank',
    'Metrobank',
    'PNB',
  ];

  final Map<String, String> bankLogos = {
    'BDO (Banco de Oro)': 'assets/images/bdo.png',
    'BPI (Bank of the Philippine Islands)': 'assets/images/bpi.jpeg',
    'UnionBank': 'assets/images/union-bank.jpeg',
    'Security Bank': 'assets/images/Security-bank.jpeg',
    'Metrobank': 'assets/images/metrobank.png',
    'PNB': 'assets/images/pnb.png',
  };

  void _submit() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Bank account added successfully."),
          backgroundColor: Colors.green,
        ),
      );
      Navigator.pop(context);
    }
  }

  InputDecoration _inputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(fontSize: 14, color: Colors.grey),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      filled: true,
      fillColor: Colors.white,
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.grey.shade300),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.green),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    String? logoPath = selectedBank != null ? bankLogos[selectedBank!] : null;

    return Scaffold(
      backgroundColor: const Color(0xFFF4F6F9),
      appBar: AppBar(
        title: const Text('Add Bank Account',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600)),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0.5,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(18),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              if (logoPath != null)
                Container(
                  margin: const EdgeInsets.only(bottom: 20),
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 8,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: ClipOval(
                    child: Image.asset(
                      logoPath,
                      fit: BoxFit.contain,
                      errorBuilder: (_, __, ___) =>
                          const Icon(Icons.account_balance),
                    ),
                  ),
                ),

              // Bank dropdown
              DropdownButtonFormField<String>(
                value: selectedBank,
                hint: const Text("Select bank"),
                items: bankOptions
                    .map((bank) => DropdownMenuItem(
                          value: bank,
                          child:
                              Text(bank, style: const TextStyle(fontSize: 15)),
                        ))
                    .toList(),
                decoration: _inputDecoration("Select your bank"),
                validator: (value) =>
                    value == null ? "Please select a bank" : null,
                onChanged: (value) => setState(() => selectedBank = value),
              ),
              const SizedBox(height: 20),

              // Account number
              TextFormField(
                controller: _accountNumberController,
                keyboardType: TextInputType.number,
                decoration: _inputDecoration("Enter account number"),
                validator: (value) => value == null || value.isEmpty
                    ? 'Account number required'
                    : null,
              ),
              const SizedBox(height: 20),

              // Owner name
              TextFormField(
                controller: _ownerNameController,
                decoration: _inputDecoration("Enter account holder name"),
                validator: (value) =>
                    value == null || value.isEmpty ? 'Name required' : null,
              ),
              const SizedBox(height: 30),

              // Submit Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _submit,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 3,
                  ),
                  child: const Text(
                    "Add Account",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

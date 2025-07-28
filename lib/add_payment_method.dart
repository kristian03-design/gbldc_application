import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class AddPaymentMethodPage extends StatefulWidget {
  const AddPaymentMethodPage({super.key});

  @override
  State<AddPaymentMethodPage> createState() => _AddPaymentMethodPageState();
}

class _AddPaymentMethodPageState extends State<AddPaymentMethodPage> {
  final _formKey = GlobalKey<FormState>();

  String? _paymentType;
  String? _accountNumber;
  String? _ownerName;
  String? _imagePath;
  bool _isDefault = false;

  final List<Map<String, String>> _paymentTypes = [
    {'name': 'GCASH', 'logo': 'assets/images/g-cash.jpeg'},
    {'name': 'Maya', 'logo': 'assets/images/maya.jpeg'},
    {'name': 'GoTyme', 'logo': 'assets/images/gotyme.jpeg'},
    {'name': 'Visa Card', 'logo': 'assets/images/visa-card.png'},
    {'name': 'MasterCard', 'logo': 'assets/images/master-card.jpeg'},
  ];

  void _submit() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          backgroundColor: Colors.white,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.check_circle, color: Colors.green, size: 64),
                const SizedBox(height: 16),
                const Text(
                  'Payment Method Added',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  _isDefault
                      ? 'This payment method is set as default.'
                      : 'Your payment method has been saved.',
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.grey),
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context); // close dialog
                    Navigator.pop(context); // go back
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                  ),
                  child: const Text(
                    'Done',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
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

  void _updatePaymentType(String? value) {
    final found = _paymentTypes.firstWhere(
            (element) => element['name'] == value,
        orElse: () => <String, String>{'logo': ''});
    setState(() {
      _paymentType = value;
      _imagePath = found['logo'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(
        title: const Text('Add Payment Method'),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        leading: IconButton(
          icon: const Icon(Iconsax.arrow_left),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              // Preview Card if info is filled
              if (_paymentType != null &&
                  _accountNumber != null &&
                  _ownerName != null) ...[
                Container(
                  margin: const EdgeInsets.only(bottom: 24),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.08),
                        blurRadius: 6,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      if (_imagePath != null)
                        ClipRRect(
                          borderRadius: BorderRadius.circular(14),
                          child: Image.asset(
                            _imagePath!,
                            height: 48,
                            width: 48,
                            fit: BoxFit.cover,
                          ),
                        ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              _paymentType!,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              '**** ${_accountNumber!.substring(_accountNumber!.length - 4)}',
                              style: const TextStyle(color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
                      if (_isDefault)
                        const Icon(Iconsax.tick_circle, color: Colors.green),
                    ],
                  ),
                ),
              ],

              DropdownButtonFormField<String>(
                dropdownColor: Colors.white,
                borderRadius: BorderRadius.circular(12),
                decoration: _inputDecoration('Select Payment Type'),
                items: _paymentTypes
                    .map((type) => DropdownMenuItem(
                  value: type['name'],
                  child: Row(
                    children: [
                      if (type['logo'] != null)
                        ClipRRect(
                          borderRadius: BorderRadius.circular(14),
                          child: Image.asset(
                            type['logo']!,
                            height: 24,
                            width: 24,
                            fit: BoxFit.cover,
                          ),
                        ),
                      const SizedBox(width: 8),
                      Text(type['name'] ?? ''),
                    ],
                  ),
                ))
                    .toList(),
                onChanged: _updatePaymentType,
                validator: (value) =>
                value == null ? 'Please select a payment type' : null,
              ),
              const SizedBox(height: 16),

              TextFormField(
                decoration: _inputDecoration('Account Number')
                    .copyWith(hintText: 'e.g., 09171234567 or 1234-5678-9012'),
                keyboardType: TextInputType.number,
                onChanged: (value) => _accountNumber = value,
                validator: (value) => value == null || value.isEmpty
                    ? 'Enter account number'
                    : null,
              ),
              const SizedBox(height: 16),

              TextFormField(
                decoration: _inputDecoration('Account Owner Name')
                    .copyWith(hintText: 'e.g., Juan Dela Cruz'),
                onChanged: (value) => _ownerName = value,
                validator: (value) =>
                value == null || value.isEmpty ? 'Enter owner name' : null,
              ),
              const SizedBox(height: 16),

              SwitchListTile(
                value: _isDefault,
                onChanged: (val) => setState(() => _isDefault = val),
                title: const Text('Set as default payment method'),
                activeColor: Colors.green,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                tileColor: Colors.white,
              ),

              const SizedBox(height: 32),

              ElevatedButton.icon(
                onPressed: _submit,
                icon: const Icon(Iconsax.save_2, color: Colors.white,),
                label: const Text(
                  'Save Payment Method',
                  style: TextStyle(fontWeight: FontWeight.w600, color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  InputDecoration _inputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(color: Colors.grey.shade300),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(color: Colors.grey.shade300),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: Colors.green),
      ),
    );
  }
}

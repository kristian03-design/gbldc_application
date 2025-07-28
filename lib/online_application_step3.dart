import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'online_application_step4.dart';
import 'package:iconsax/iconsax.dart';

void main() => runApp(const MaterialApp(
      home: EmergencyContactsPage(),
      debugShowCheckedModeBanner: false,
    ));

class EmergencyContactsPage extends StatefulWidget {
  const EmergencyContactsPage({super.key});

  @override
  State<EmergencyContactsPage> createState() => _EmergencyContactsPageState();
}

class _EmergencyContactsPageState extends State<EmergencyContactsPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController nameController1 = TextEditingController();
  final TextEditingController emailController1 = TextEditingController();
  final TextEditingController addressController1 = TextEditingController();

  final TextEditingController nameController2 = TextEditingController();
  final TextEditingController emailController2 = TextEditingController();
  final TextEditingController addressController2 = TextEditingController();

  String? selectedRelationship1;
  String? selectedRelationship2;
  String? phoneNumber1;
  String? phoneNumber2;

  final List<String> relationships = [
    'Parent',
    'Sibling',
    'Spouse',
    'Friend',
    'Relative',
    'Colleague'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF1F5F9),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF1F5F9),
        elevation: 0,
        leading: const BackButton(color: Colors.black),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: Center(
              child: Text("Step 3 of 5",
                  style: TextStyle(color: Colors.black, fontSize: 14)),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: ListView(
              children: [
                const LinearProgressIndicator(
                  value: 0.6,
                  color: Colors.green,
                  backgroundColor: Colors.grey,
                ),
                const SizedBox(height: 20),
                const Text(
                  "Emergency Contacts",
                  style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                      ),
                ),
                const SizedBox(height: 8),
                const Text(
                  "Please provide details of two trusted contacts. We’ll only reach out to them in case of emergencies related to your loan.",
                  style: TextStyle(
                      fontSize: 14, color: Colors.grey),
                ),
                const SizedBox(height: 30),
                const Text(
                  "Emergency Contact 1",
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 12),
                _buildLabel("Contact's Full Name"),
                _buildInput(
                    controller: nameController1,
                    hint: "Enter contact's full name"),
                const SizedBox(height: 20),
                _buildLabel("Relationship to User"),
                _buildDropdown(
                  value: selectedRelationship1,
                  items: relationships,
                  onChanged: (value) =>
                      setState(() => selectedRelationship1 = value),
                  hint: 'Select relationship to you',
                ),
                const SizedBox(height: 20),
                _buildLabel("Phone Number"),
                IntlPhoneField(
                  decoration: _inputDecoration(hint: 'Phone Number'),
                  initialCountryCode: 'PH',
                  onChanged: (phone) => phoneNumber1 = phone.completeNumber,
                ),
                const SizedBox(height: 20),
                _buildLabel("Contact's Email Address"),
                _buildInput(
                    controller: emailController1,
                    hint: "Enter contact's email address"),
                const SizedBox(height: 20),
                _buildLabel("Home Address"),
                _buildInput(
                    controller: addressController1,
                    hint: "Enter contact's home address"),
                const SizedBox(height: 30),
                const Text(
                  "Emergency Contact 2",
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 12),
                _buildLabel("Contact's Full Name"),
                _buildInput(
                    controller: nameController2,
                    hint: "Enter contact's full name"),
                const SizedBox(height: 20),
                _buildLabel("Relationship to User"),
                _buildDropdown(
                  value: selectedRelationship2,
                  items: relationships,
                  onChanged: (value) =>
                      setState(() => selectedRelationship2 = value),
                  hint: 'Select relationship to you',
                ),
                const SizedBox(height: 20),
                _buildLabel("Phone Number"),
                IntlPhoneField(
                  decoration: _inputDecoration(hint: 'Phone Number'),
                  initialCountryCode: 'PH',
                  onChanged: (phone) => phoneNumber2 = phone.completeNumber,
                ),
                const SizedBox(height: 20),
                _buildLabel("Contact's Email Address"),
                _buildInput(
                    controller: emailController2,
                    hint: "Enter contact's email address"),
                const SizedBox(height: 20),
                _buildLabel("Home Address"),
                _buildInput(
                    controller: addressController2,
                    hint: "Enter contact's home address"),
                const SizedBox(height: 30),
                SizedBox(
                  width: double.infinity,
                  child:  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size.fromHeight(50),
                      backgroundColor: Colors.green,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        PageRouteBuilder(
                          transitionDuration: const Duration(milliseconds: 800),
                          pageBuilder: (context, animation, _) =>
                          const IDCardUploadScreen(),
                          transitionsBuilder: (context, animation, _, child) {
                            final curved = CurvedAnimation(
                              parent: animation,
                              curve: Curves.easeInOut,
                            );
                            return FadeTransition(
                              opacity: curved,
                              child: child,
                            );
                          },
                        ),
                      );
                    },
                    icon: const Icon(Iconsax.arrow_right_2, color: Colors.white),
                    label: const Text(
                      "Continue",
                      style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Text(
      text,
      style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
    );
  }

  Widget _buildInput({
    required TextEditingController controller,
    required String hint,
  }) {
    return TextFormField(
      controller: controller,
      decoration: _inputDecoration(hint: hint),
    );
  }

  Widget _buildDropdown({
    required String? value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
    required String hint,
  }) {
    return DropdownButtonFormField<String>(
      value: value,
      onChanged: onChanged,
      items: items
          .map((item) => DropdownMenuItem(value: item, child: Text(item)))
          .toList(),
      decoration: _inputDecoration(hint: hint),
    );
  }

  InputDecoration _inputDecoration({String? hint}) {
    return InputDecoration(
      hintText: hint,
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: Colors.grey),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: Colors.green, width: 1.5),
      ),
    );
  }
}

import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class RequestLimitFormPage extends StatefulWidget {
  const RequestLimitFormPage({super.key});

  @override
  State<RequestLimitFormPage> createState() => _RequestLimitFormPageState();
}

class _RequestLimitFormPageState extends State<RequestLimitFormPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _incomeController = TextEditingController();
  final TextEditingController _reasonController = TextEditingController();

  String _selectedEmployment = 'Employed';
  final List<String> _employmentTypes = [
    'Employed',
    'Self-Employed',
    'Freelancer',
    'Unemployed',
    'Student'
  ];

  File? _selectedFile;

  @override
  void dispose() {
    _incomeController.dispose();
    _reasonController.dispose();
    super.dispose();
  }

  Future<void> _pickDocument() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'jpg', 'png'],
    );

    if (result != null && result.files.single.path != null) {
      setState(() {
        _selectedFile = File(result.files.single.path!);
      });
    }
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      if (_selectedFile == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Please upload a supporting document")),
        );
        return;
      }

      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: const [
              SizedBox(height: 20),
              CircularProgressIndicator(color: Colors.green),
              SizedBox(height: 20),
              Text("Submitting...", style: TextStyle(fontWeight: FontWeight.w500)),
              SizedBox(height: 20),
            ],
          ),
        ),
      );

      Future.delayed(const Duration(seconds: 3), () {
        Navigator.of(context).pop(); // close dialog
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Request submitted successfully!"),
        ));
        Navigator.pop(context); // go back
      });
    }
  }

  Widget buildSectionHeader(String title, IconData icon) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Icon(icon, color: Colors.green),
          const SizedBox(width: 8),
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FA),
      appBar: AppBar(
        title: const Text(
          "Request Credit Limit",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
        ),
        backgroundColor: Colors.white,
        elevation: 0.5,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Form(
        key: _formKey,
        child: Stack(
          children: [
            SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 100),
              child: Column(
                children: [
                  // Income Section
                  Container(
                    padding: const EdgeInsets.all(16),
                    margin: const EdgeInsets.only(bottom: 20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.03),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        buildSectionHeader("Income Information", Iconsax.wallet_2),
                        const SizedBox(height: 8),
                        TextFormField(
                          controller: _incomeController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: "Monthly Income",
                            prefixText: '₱ ',
                            filled: true,
                            fillColor: const Color(0xFFF2F3F5),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide.none,
                            ),
                          ),
                          validator: (value) => value!.isEmpty
                              ? "Please enter your income"
                              : null,
                        ),
                        const SizedBox(height: 16),
                        DropdownButtonFormField<String>(
                          value: _selectedEmployment,
                          decoration: InputDecoration(
                            labelText: "Employment Type",
                            filled: true,
                            fillColor: const Color(0xFFF2F3F5),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide.none,
                            ),
                          ),
                          items: _employmentTypes.map((type) {
                            return DropdownMenuItem(
                              value: type,
                              child: Text(type),
                            );
                          }).toList(),
                          onChanged: (value) =>
                              setState(() => _selectedEmployment = value!),
                        ),
                      ],
                    ),
                  ),

                  // Request Details
                  Container(
                    padding: const EdgeInsets.all(16),
                    margin: const EdgeInsets.only(bottom: 20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.03),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        buildSectionHeader("Request Details", Iconsax.note_1),
                        const SizedBox(height: 8),
                        TextFormField(
                          controller: _reasonController,
                          maxLines: 3,
                          decoration: InputDecoration(
                            labelText: "Reason for Increase",
                            filled: true,
                            fillColor: const Color(0xFFF2F3F5),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide.none,
                            ),
                          ),
                          validator: (value) =>
                          value!.isEmpty ? "Please provide a reason" : null,
                        ),
                        const SizedBox(height: 16),
                        Text("Upload Supporting Document",
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Colors.grey[800])),
                        const SizedBox(height: 8),
                        ElevatedButton.icon(
                          onPressed: _pickDocument,
                          icon: const Icon(Iconsax.export),
                          label: const Text("Upload File"),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                        if (_selectedFile != null)
                          Container(
                            margin: const EdgeInsets.only(top: 12),
                            padding: const EdgeInsets.symmetric(
                                vertical: 8, horizontal: 12),
                            decoration: BoxDecoration(
                              color: const Color(0xFFEFFDF2),
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: Colors.green.shade200),
                            ),
                            child: Row(
                              children: [
                                const Icon(Iconsax.document, color: Colors.green),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Text(
                                    _selectedFile!.path.split('/').last,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ],
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Submit Button (Fixed)
            Positioned(
              bottom: 16,
              left: 20,
              right: 20,
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _submitForm,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(Iconsax.send_1, color: Colors.white, size: 20),
                      SizedBox(width: 8),
                      Text(
                        "Submit Request",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  )

                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

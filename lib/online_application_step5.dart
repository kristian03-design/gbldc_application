import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'online_application_step5_nextscreen.dart';
import 'package:iconsax/iconsax.dart';

class SelfieWithIDCardScreen extends StatefulWidget {
  const SelfieWithIDCardScreen({super.key});

  @override
  State<SelfieWithIDCardScreen> createState() => _SelfieWithIDCardScreenState();
}

class _SelfieWithIDCardScreenState extends State<SelfieWithIDCardScreen> {
  final ImagePicker _picker = ImagePicker();

  Future<void> _takeSelfie() async {
    final XFile? photo = await _picker.pickImage(source: ImageSource.camera);
    if (photo != null) {
      final File selfie = File(photo.path);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => SelfiePreviewScreen(selfie: selfie)),
      );
    }
  }

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
            padding: EdgeInsets.only(right: 16.0),
            child: Center(
              child: Text(
                "Step 5 of 5",
                style: TextStyle(color: Colors.black, fontSize: 14),
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              const LinearProgressIndicator(
                value: 1.0,
                color: Colors.green,
                backgroundColor: Colors.grey,
              ),
              const SizedBox(height: 24),
              const Text(
                "Selfie with ID Card",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 8),
              const Text(
                "Take a selfie holding your ID card next to your face. Ensure your face and ID card are clearly visible.",
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
              const SizedBox(height: 30),

              // Illustration
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 6,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(12),
                child: Column(
                  children: [
                    Image.asset(
                      'assets/images/selfie_illustration.jpg',
                      height: 300,
                      fit: BoxFit.cover,
                    ),
                  ],
                ),
              ),

              const Spacer(),

              // Take Selfie Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: _takeSelfie,
                  icon: const Icon(Iconsax.camera, color: Colors.white),
                  label: const Text(
                    "Take Selfie",
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

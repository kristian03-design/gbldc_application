// ignore_for_file: unused_field

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'online_application_step4_nextscreen.dart';
import 'package:iconsax/iconsax.dart';

class IDCardUploadScreen extends StatefulWidget {
  const IDCardUploadScreen({super.key});

  @override
  State<IDCardUploadScreen> createState() => _IDCardUploadScreenState();
}

class _IDCardUploadScreenState extends State<IDCardUploadScreen> {
  File? _image;
  final ImagePicker _picker = ImagePicker();

  Future<void> _takePhoto() async {
    final XFile? photo = await _picker.pickImage(source: ImageSource.camera);
    if (photo != null) {
      final File file = File(photo.path);
      setState(() {
        _image = file;
      });

      if (mounted) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => NextScreen(imageFile: file)),
        );
      }
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
            padding: EdgeInsets.only(right: 16),
            child: Center(
              child: Text("Step 4 of 5",
                  style: TextStyle(color: Colors.black, fontSize: 14)),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          children: [
            const LinearProgressIndicator(
              value: 0.8,
              color: Colors.green,
              backgroundColor: Colors.grey,
            ),
            const SizedBox(height: 24),
            const Text(
              "Upload Your ID",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 6),
            const Text(
              "Make sure your photo is clear and meets the verification requirements.",
              style: TextStyle(fontSize: 14, color: Colors.black54),
            ),
            const SizedBox(height: 30),

            // ✅ Correct Example
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 5,
                    offset: const Offset(0, 2),
                  )
                ],
              ),
              child: Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.asset(
                      'assets/images/id_card_example.jpeg',
                      height: 160,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Iconsax.tick_circle, color: Colors.green),
                      SizedBox(width: 6),
                      Text("Correct Example",
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                              color: Colors.green)),
                    ],
                  )
                ],
              ),
            ),

            const SizedBox(height: 30),

            // ❌ Wrong Examples
            const Text("Avoid These Mistakes",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
            const SizedBox(height: 12),
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                _buildWrongCard("Too Dark", "assets/images/id_card_dark.jpeg"),
                _buildWrongCard("Blurry", "assets/images/id_card_blur.png"),
                _buildWrongCard("Covered Info", "assets/images/id_card_blocked.png"),
                _buildWrongCard("Overexposed", "assets/images/id_card_bright.png"),
              ],
            ),

            const SizedBox(height: 40),

            // 📷 Take Photo
            ElevatedButton.icon(
              onPressed: _takePhoto,
              icon: const Icon(Iconsax.camera, color: Colors.white),
              label: const Text("Take Photo",
                  style: TextStyle(fontSize: 16, color: Colors.white)),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildWrongCard(String label, String imagePath) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.red.shade100),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
            offset: const Offset(0, 2),
          )
        ],
      ),
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset(imagePath, height: 80, fit: BoxFit.cover),
          ),
          const SizedBox(height: 6),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Iconsax.close_circle, color: Colors.red, size: 16),
              const SizedBox(width: 4),
              Text(
                label,
                style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: Colors.red),
              ),
            ],
          )
        ],
      ),
    );
  }
}

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:iconsax/iconsax.dart';
import 'package:local_auth/local_auth.dart';

class AccountSecurityPage extends StatefulWidget {
  const AccountSecurityPage({Key? key}) : super(key: key);

  @override
  State<AccountSecurityPage> createState() => _AccountSecurityPageState();
}

class _AccountSecurityPageState extends State<AccountSecurityPage> {
  File? _profileImage;
  final picker = ImagePicker();
  String _userName = "Kristian Lloyd Hernandez";

  bool biometricEnabled = true;
  bool is2FAEnabled = false;

  final LocalAuthentication auth = LocalAuthentication();

  Future<void> _pickImage() async {
    final pickedFile =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 85);
    if (pickedFile != null) {
      setState(() {
        _profileImage = File(pickedFile.path);
      });
    }
  }

  void _showModernInputDialog({
    required String title,
    required String hint,
    required TextInputType inputType,
    required void Function(String) onSubmit,
  }) {
    final controller = TextEditingController();

    showDialog(
      context: context,
      builder: (_) => Dialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 28),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: controller,
                keyboardType: inputType,
                style: const TextStyle(fontSize: 16),
                decoration: InputDecoration(
                  hintText: hint,
                  filled: true,
                  fillColor: Colors.grey.shade100,
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text("Cancel",
                        style: TextStyle(color: Colors.green)),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: () {
                      onSubmit(controller.text);
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 12),
                    ),
                    child: const Text("Save", style: TextStyle(fontSize: 15)),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showChangePasswordDialog() {
    final current = TextEditingController();
    final newPass = TextEditingController();
    final confirm = TextEditingController();

    showDialog(
      context: context,
      builder: (_) => Dialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 28),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Change Password",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
              const SizedBox(height: 16),
              TextField(
                  controller: current,
                  obscureText: true,
                  decoration: _inputDecoration("Current Password")),
              const SizedBox(height: 12),
              TextField(
                  controller: newPass,
                  obscureText: true,
                  decoration: _inputDecoration("New Password")),
              const SizedBox(height: 12),
              TextField(
                  controller: confirm,
                  obscureText: true,
                  decoration: _inputDecoration("Confirm Password")),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text("Cancel",
                          style: TextStyle(color: Colors.green))),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: () {
                      if (newPass.text != confirm.text) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text("Passwords do not match")),
                        );
                      } else {
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Password updated")),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 12),
                    ),
                    child: const Text("Update", style: TextStyle(fontSize: 15)),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  InputDecoration _inputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      filled: true,
      fillColor: Colors.grey.shade100,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
    );
  }

  void _showLoginActivityDialog() {
    // Example: Replace with real API call for real-time activity
    final activities = [
      {"date": "July 18, 2025", "device": "Android", "ip": "192.168.1.1"},
      {"date": "July 17, 2025", "device": "Web", "ip": "203.0.113.5"},
    ];
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: Colors.white,
        title: const Text("Login Activity"),
        content: SizedBox(
          width: 300,
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: activities.length,
            itemBuilder: (_, i) {
              final a = activities[i];
              return ListTile(
                title: Text(a["date"]!),
                subtitle: Text("${a["device"]} - ${a["ip"]}"),
              );
            },
          ),
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Close", style: TextStyle(color: Colors.green)),
          ),
        ],
      ),
    );
  }

  void _show2FADialog() {
    final controller = TextEditingController();
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Enter 2FA Code"),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(hintText: "Enter code"),
          keyboardType: TextInputType.number,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () async {
              // TODO: Call backend to verify code
              setState(() => is2FAEnabled = true);
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("2FA enabled!")),
              );
            },
            child: const Text("Verify"),
          ),
        ],
      ),
    );
  }

  Future<void> _toggleBiometric(bool enable) async {
    if (enable) {
      bool canCheck = await auth.canCheckBiometrics;
      if (canCheck) {
        bool authenticated = await auth.authenticate(
          localizedReason: 'Enable biometric login',
          options: const AuthenticationOptions(biometricOnly: true),
        );
        if (authenticated) {
          setState(() => biometricEnabled = true);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Biometric enabled")),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("No biometrics available on device")),
        );
      }
    } else {
      setState(() => biometricEnabled = false);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Biometric disabled")),
      );
    }
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 25, bottom: 10),
      child: Text(title,
          style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w600)),
    );
  }

  Widget _buildCardTile(String title, IconData icon,
      {VoidCallback? onTap, Widget? trailing}) {
    return Card(
      color: Colors.white,
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        leading: CircleAvatar(
          radius: 20,
          backgroundColor: Colors.white,
          child: Icon(icon, color: Colors.green),
        ),
        title: Text(title, style: const TextStyle(fontSize: 15)),
        trailing: trailing ?? const Icon(Iconsax.arrow_right_3, size: 18),
        onTap: onTap,
      ),
    );
  }

  Widget _buildProfileAvatar() {
    return Column(
      children: [
        Center(
          child: GestureDetector(
            onTap: _pickImage,
            child: Stack(
              alignment: Alignment.bottomRight,
              children: [
                CircleAvatar(
                  radius: 55,
                  backgroundImage: _profileImage != null
                      ? FileImage(_profileImage!)
                      : const AssetImage("assets/default-avatar.png")
                          as ImageProvider,
                  backgroundColor: Colors.grey.shade300,
                ),
                Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: Colors.green,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 2),
                  ),
                  child:
                      const Icon(Iconsax.edit_2, size: 16, color: Colors.white),
                )
              ],
            ),
          ),
        ),
        const SizedBox(height: 15),
        Text(
          _userName,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 5),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Account & Security"),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0.4,
      ),
      backgroundColor: Colors.white,
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          _buildProfileAvatar(),
          _buildSectionTitle("Account Info"),
          _buildCardTile("Edit Profile", Iconsax.user_edit, onTap: () {
            _showModernInputDialog(
              title: "Update Name",
              hint: "Enter your full name",
              inputType: TextInputType.name,
              onSubmit: (value) {
                setState(() {
                  _userName = value;
                });
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Name updated to $value")));
              },
            );
          }),
          _buildCardTile("Email Address", Iconsax.sms, onTap: () {
            _showModernInputDialog(
              title: "Update Email",
              hint: "Enter your new email",
              inputType: TextInputType.emailAddress,
              onSubmit: (value) {
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Email updated to $value")));
              },
            );
          }),
          _buildCardTile("Phone Number", Iconsax.call, onTap: () {
            _showModernInputDialog(
              title: "Update Phone Number",
              hint: "Enter your phone number",
              inputType: TextInputType.phone,
              onSubmit: (value) {
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Phone number updated to $value")));
              },
            );
          }),
          _buildSectionTitle("Security"),
          _buildCardTile("Change Password", Iconsax.lock,
              onTap: _showChangePasswordDialog),
          _buildCardTile(
            "Two-Factor Authentication",
            Iconsax.shield_tick,
            trailing: Switch(
              value: is2FAEnabled,
              activeColor: Colors.green,
              onChanged: (val) {
                if (!is2FAEnabled) {
                  _show2FADialog();
                } else {
                  setState(() => is2FAEnabled = false);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("2FA disabled")),
                  );
                }
              },
            ),
            onTap: () {
              if (!is2FAEnabled) {
                _show2FADialog();
              } else {
                setState(() => is2FAEnabled = false);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("2FA disabled")),
                );
              }
            },
          ),
          _buildCardTile("Login Activity", Iconsax.activity,
              onTap: _showLoginActivityDialog),
          const SizedBox(height: 12),
          SwitchListTile(
            value: biometricEnabled,
            onChanged: (val) => _toggleBiometric(val),
            title: const Text("Enable Biometric Login",
                style: TextStyle(fontWeight: FontWeight.w500)),
            activeColor: Colors.green,
            contentPadding: const EdgeInsets.symmetric(horizontal: 0),
          )
        ],
      ),
    );
  }
}

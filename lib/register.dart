import 'package:flutter/material.dart';
import 'package:gbldc_app/login_form.dart';
import 'verify_email.dart';
import 'package:iconsax/iconsax.dart';// Make sure this file exists

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  bool obscurePassword = true;
  bool obscureConfirmPassword = true;
  bool agreeToTerms = false;
  String? passwordError;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 36),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Image.asset('assets/images/logocoop.png', height: 70),
              ),
              const SizedBox(height: 30),

              const Center(
                child: Text(
                  'Create Account',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),

              const SizedBox(height: 8),
              const Text(
                'Please fill in the details below to create your account.',
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.black54,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),

              _buildTextField(label: 'Full Name'),
              const SizedBox(height: 16),

              _buildTextField(label: 'Email Address'),
              const SizedBox(height: 16),

              _buildTextField(
                label: 'Phone Number',
                keyboardType: TextInputType.phone,
              ),
              const SizedBox(height: 16),

              // Password
              TextField(
                controller: _passwordController,
                obscureText: obscurePassword,
                decoration: _buildInputDecoration(
                  label: 'Password',
                  suffixIcon: IconButton(
                    icon: Icon(obscurePassword
                        ? Iconsax.eye_slash
                        : Iconsax.eye),
                    onPressed: () =>
                        setState(() => obscurePassword = !obscurePassword),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Confirm Password
              TextField(
                controller: _confirmPasswordController,
                obscureText: obscureConfirmPassword,
                decoration: _buildInputDecoration(
                  label: 'Confirm Password',
                  errorText: passwordError,
                  suffixIcon: IconButton(
                    icon: Icon(obscureConfirmPassword
                        ? Iconsax.eye_slash
                        : Iconsax.eye),
                    onPressed: () => setState(
                        () => obscureConfirmPassword = !obscureConfirmPassword),
                  ),
                ),
              ),
              const SizedBox(height: 12),

              // Terms
              Row(
                children: [
                  Checkbox(
                    value: agreeToTerms,
                    onChanged: (val) => setState(() => agreeToTerms = val!),
                    activeColor: const Color(0xFF16A34A),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  const Expanded(
                    child: Text(
                      'I agree to the Terms and Conditions',
                      style: TextStyle(fontSize: 13),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Register Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _handleRegister,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF16A34A),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    elevation: 2,
                  ),
                  child: const Text(
                    "Register",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                ),
              ),
              const SizedBox(height: 24),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Already have an account? "),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        PageRouteBuilder(
                          transitionDuration:
                          const Duration(milliseconds: 800),
                          pageBuilder: (context, animation, _) =>
                          const LoginScreen(),
                          transitionsBuilder:
                              (context, animation, _, child) {
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
                    child: const Text(
                      "Sign in",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF16A34A),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  InputDecoration _buildInputDecoration({
    required String label,
    Widget? suffixIcon,
    String? errorText,
  }) {
    return InputDecoration(
      labelText: label,
      errorText: errorText,
      filled: true,
      fillColor: const Color(0xFFF5F5F5),
      contentPadding: const EdgeInsets.symmetric(vertical: 18, horizontal: 20),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      suffixIcon: suffixIcon,
    );
  }

  Widget _buildTextField({required String label, TextInputType? keyboardType}) {
    return TextField(
      keyboardType: keyboardType,
      decoration: _buildInputDecoration(label: label),
    );
  }

  void _handleRegister() {
    if (!agreeToTerms) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.white,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            title: const Column(
              // Changed Row to Column
              crossAxisAlignment:
                  CrossAxisAlignment.center, // Center items horizontally
              mainAxisSize: MainAxisSize.min, // To make the column wrap content
              children: <Widget>[
                Icon(Iconsax.warning_2,
                    color: Colors.red, size: 70), // Made icon larger
                SizedBox(height: 12), // Added space between icon and text
                Text(
                  // Text widget for title
                  "Terms and Conditions",
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                      color: Colors.black87),
                ),
              ],
            ),
            content: const Text(
              "Please agree to the terms and conditions to proceed.",
              textAlign: TextAlign.center, // Center align the content text
              style: TextStyle(fontSize: 14, color: Colors.black87),
            ),
            actions: <Widget>[
              Center(
                child: TextButton(
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.red,
                    alignment: Alignment.center,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text(
                    "OK",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ],
          );
        },
      );
      return;
    }

    if (_passwordController.text != _confirmPasswordController.text) {
      setState(() => passwordError = "Passwords do not match");
      return;
    } else {
      setState(() => passwordError = null);
    }

    // Show confirmation modal
    showDialog(
      context: context,
      barrierDismissible: false, // Prevent manual dismissal
      builder: (context) {
        Future.delayed(const Duration(seconds: 3), () {
          Navigator.of(context).pop(); // Close the dialog
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const VerifyEmailPage()),
          );
        });

        return AlertDialog(
          backgroundColor: Colors.white,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: const [
              CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF16A34A)),
              ),
              SizedBox(height: 24),
              Text(
                "Verifying your email...",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  height: 1.5,
                ),
              ),
              SizedBox(height: 8),
              Text(
                "Please wait while we send a 6-digit code to your email.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.black54,
                  height: 1.4,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'dart:async';
import 'create-pin.dart'; // Adjust this path based on your project
import 'package:iconsax/iconsax.dart';

class VerifyEmailPage extends StatefulWidget {
  const VerifyEmailPage({super.key});

  @override
  State<VerifyEmailPage> createState() => _VerifyEmailPageState();
}

class _VerifyEmailPageState extends State<VerifyEmailPage> {
  List<String> otpCode = List.filled(6, '');
  List<FocusNode> focusNodes =
      List.generate(6, (_) => FocusNode()); // 6 focus nodes

  int _secondsRemaining = 60;
  bool _isResendVisible = false;

  @override
  void initState() {
    super.initState();
    _startTimer();
    focusNodes[0].requestFocus(); // Autofocus first box
  }

  void _startTimer() {
    _secondsRemaining = 60;
    _isResendVisible = false;

    Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secondsRemaining == 0) {
        setState(() {
          _isResendVisible = true;
        });
        timer.cancel();
      } else {
        setState(() {
          _secondsRemaining--;
        });
      }
    });
  }

  void _verifyOTP() {
    final enteredCode = otpCode.join();
    if (enteredCode == "123456") {
      _showSuccessDialog();
    } else {
      _showErrorDialog();
    }
  }

  void _showErrorDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          title: const Column(
            children: [
              Icon(
                Iconsax.close_circle,
                color: Colors.red,
                size: 70,
              ),
              SizedBox(height: 10),
              Text("Invalid Code"),
            ],
          ),
          content: const Text(
            "The code you entered is incorrect. Please try again.",
            textAlign: TextAlign.center,
          ),
          actions: <Widget>[
            Center(
              child: TextButton(
                style: TextButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.red,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                child: const Text("OK"),
                onPressed: () {
                  Navigator.of(context).pop();
                  // Optionally, clear the OTP fields or reset focus
                  setState(() {
                    otpCode = List.filled(6, '');
                    focusNodes[0].requestFocus();
                  });
                },
              ),
            ),
          ],
        );
      },
    );
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        Future.delayed(const Duration(seconds: 3), () {
          Navigator.of(context).pop();
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => CreatePinScreen()),
          );
        });

        return Dialog(
          backgroundColor: Colors.white,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Iconsax.verify, size: 90, color: Colors.green),
                const SizedBox(height: 20),
                const Text(
                  "Email Verified!",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 12),
                const Text(
                  "Your email has been successfully verified.\nRedirecting to Create Pin Screen...",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black87,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 24),
                const CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF16A34A)),
                  strokeWidth: 2.5,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildOTPBox(int index) {
    return SizedBox(
      width: 45,
      child: TextField(
        focusNode: focusNodes[index],
        onChanged: (value) {
          if (value.isNotEmpty) {
            otpCode[index] = value;
            if (index < 5) {
              FocusScope.of(context).requestFocus(focusNodes[index + 1]);
            } else {
              FocusScope.of(context).unfocus(); // last field
            }
          } else {
            otpCode[index] = '';
            if (index > 0) {
              FocusScope.of(context).requestFocus(focusNodes[index - 1]);
            }
          }
        },
        keyboardType: TextInputType.number,
        maxLength: 1,
        textAlign: TextAlign.center,
        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        decoration: InputDecoration(
          counterText: '',
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Colors.grey),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Colors.green, width: 2),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Verify Email",
          style: TextStyle(color: Colors.black),
        ),
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 36),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            Center(
                child: Image.asset('assets/images/logocoop.png', height: 70)),
            const SizedBox(height: 20),
            const Text(
              "A 6-digit verification code has been sent to your email.",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 15, color: Colors.black87),
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(6, _buildOTPBox),
            ),
            const SizedBox(height: 30),
            _isResendVisible
                ? TextButton(
                    onPressed: _startTimer,
                    child: const Text("Resend Code",
                        style: TextStyle(fontSize: 15, color: Colors.green)),
                  )
                : Text(
                    "Resend code in $_secondsRemaining seconds",
                    style: const TextStyle(color: Colors.grey),
                  ),
            const SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _verifyOTP,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF16A34A),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  "Verify",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

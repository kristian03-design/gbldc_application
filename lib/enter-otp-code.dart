import 'dart:async';
import 'package:flutter/material.dart';
import 'landing_page.dart';
import 'package:iconsax/iconsax.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  late Timer _timer;
  int _secondsRemaining = 50;
  bool _canResend = false;

  final List<TextEditingController> _otpControllers =
  List.generate(6, (_) => TextEditingController());
  final List<FocusNode> _focusNodes = List.generate(6, (_) => FocusNode());

  @override
  void initState() {
    super.initState();
    _startCountdown();
  }

  void _startCountdown() {
    _secondsRemaining = 50;
    _canResend = false;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secondsRemaining > 0) {
        setState(() {
          _secondsRemaining--;
        });
      } else {
        timer.cancel();
        setState(() {
          _canResend = true;
        });
      }
    });
  }

  void _resendCode() {
    _startCountdown();
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          contentPadding: const EdgeInsets.fromLTRB(24, 30, 24, 10),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: const [
              Icon(Icons.mark_email_read_rounded, size: 90, color: Colors.green),
              SizedBox(height: 20),
              Text(
                "OTP Resent",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.black87),
              ),
              SizedBox(height: 10),
              Text(
                "A new OTP code has been sent to your email.",
                style: TextStyle(fontSize: 14, color: Colors.black54),
                textAlign: TextAlign.center,
              ),
            ],
          ),
          actionsAlignment: MainAxisAlignment.center,
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              style: TextButton.styleFrom(
                foregroundColor: Colors.green,
                textStyle: const TextStyle(fontWeight: FontWeight.w600),
              ),
              child: const Text("OK"),
            ),
          ],
        );
      },
    );
  }

  void _verifyOtp() {
    String otp = _otpControllers.map((c) => c.text).join();
    if (otp.length < 6) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            contentPadding: const EdgeInsets.fromLTRB(24, 30, 24, 10),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Icon(Iconsax.info_circle, size: 90, color: Colors.red),
                SizedBox(height: 20),
                Text(
                  "Incomplete OTP",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.black87),
                ),
                SizedBox(height: 10),
                Text(
                  "Please enter the complete 6-digit OTP to continue.",
                  style: TextStyle(fontSize: 14, color: Colors.black54),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            actionsAlignment: MainAxisAlignment.center,
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                style: TextButton.styleFrom(
                  foregroundColor: Colors.green,
                  textStyle: const TextStyle(fontWeight: FontWeight.w600),
                ),
                child: const Text("OK"),
              ),
            ],
          );
        },
      );
      return;
    }

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) {
        bool isVerified = false;

        return StatefulBuilder(
          builder: (context, setState) {
            // Animate to check after 2 seconds
            Future.delayed(const Duration(seconds: 2), () {
              setState(() => isVerified = true);
            });

            // Close dialog and navigate after 4 seconds
            Future.delayed(const Duration(seconds: 4), () {
              if (Navigator.of(context).canPop()) {
                Navigator.of(context).pop();
              }
              Navigator.pushReplacement(
                context,
                PageRouteBuilder(
                  transitionDuration: const Duration(milliseconds: 500),
                  pageBuilder: (_, __, ___) => LandingPage(),
                  transitionsBuilder: (_, animation, __, child) {
                    final offsetAnimation = Tween<Offset>(
                      begin: const Offset(1.0, 0.0),
                      end: Offset.zero,
                    ).animate(CurvedAnimation(
                      parent: animation,
                      curve: Curves.easeOut,
                    ));
                    return SlideTransition(
                        position: offsetAnimation, child: child);
                  },
                ),
              );
            });

            return AlertDialog(
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)),
              content: Padding(
                padding:
                const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    AnimatedSwitcher(
                      duration: const Duration(milliseconds: 500),
                      child: isVerified
                          ? const Icon(Iconsax.tick_circle,
                          key: ValueKey("check"),
                          size: 60,
                          color: Colors.green)
                          : const CircularProgressIndicator(
                        key: ValueKey("loader"),
                        valueColor:
                        AlwaysStoppedAnimation<Color>(Colors.green),
                      ),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      isVerified
                          ? "Verified Successfully!"
                          : "Verifying your code...",
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        height: 1.5,
                      ),
                    ),
                    if (isVerified) ...[
                      const SizedBox(height: 16),
                      const Text(
                        "Welcome to Greater Bulacan Livelihood Development Cooperative",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black54,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    for (var controller in _otpControllers) {
      controller.dispose();
    }
    for (var focus in _focusNodes) {
      focus.dispose();
    }
    super.dispose();
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
          "Enter OTP Code",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600)
        ),
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            children: [
              Center(
                child: Image.asset(
                  'assets/images/logocoop.png',
                  height: 70,
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                "Enter 6-digit OTP Code 🔐",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 15),
              const Text(
                "We've sent a 6-digit OTP to your email.\nPlease enter the code below to verify.",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey),
              ),
              const SizedBox(height: 30),
              // OTP Input Fields
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(6, (index) {
                  return SizedBox(
                    width: 48,
                    child: TextField(
                      controller: _otpControllers[index],
                      focusNode: _focusNodes[index],
                      textAlign: TextAlign.center,
                      maxLength: 1,
                      keyboardType: TextInputType.number,
                      obscureText: true,
                      style: const TextStyle(fontSize: 20),
                      decoration: InputDecoration(
                        counterText: '',
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(color: Colors.grey),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide:
                          const BorderSide(color: Colors.green, width: 2),
                        ),
                      ),
                      onChanged: (value) {
                        if (value.isNotEmpty && index < 5) {
                          FocusScope.of(context)
                              .requestFocus(_focusNodes[index + 1]);
                        } else if (value.isEmpty && index > 0) {
                          FocusScope.of(context)
                              .requestFocus(_focusNodes[index - 1]);
                        }
                      },
                    ),
                  );
                }),
              ),

              const SizedBox(height: 30),

              // Countdown
              Text(
                _canResend
                    ? "You can resend the code now"
                    : "Resend available in $_secondsRemaining seconds",
                style: TextStyle(
                  fontSize: 14,
                  color: _canResend ? Colors.black : Colors.grey,
                ),
              ),

              // Resend Button
              TextButton(
                onPressed: _canResend ? _resendCode : null,
                child: const Text(
                  "Resend Code",
                  style: TextStyle(
                    color: Colors.green,
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
                ),
              ),

              const Spacer(),

              // Verify Button
              ElevatedButton(
                onPressed: _verifyOtp,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Text(
                  "Verify",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}

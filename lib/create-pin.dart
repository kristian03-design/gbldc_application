import 'package:flutter/material.dart';
import 'landing_page.dart';
import 'package:iconsax/iconsax.dart';// Replace with your actual landing page

void main() {
  runApp(MaterialApp(
    home: CreatePinScreen(),
    debugShowCheckedModeBanner: false,
  ));
}

class CreatePinScreen extends StatefulWidget {
  @override
  _CreatePinScreenState createState() => _CreatePinScreenState();
}

class _CreatePinScreenState extends State<CreatePinScreen> {
  final List<TextEditingController> _controllers =
      List.generate(6, (_) => TextEditingController());
  final List<FocusNode> _focusNodes = List.generate(6, (_) => FocusNode());

  bool _isComplete = false;
  bool _isLoading = false;
  double _progress = 0.0;

  @override
  void initState() {
    super.initState();
    for (var controller in _controllers) {
      controller.addListener(_onPinChanged);
    }
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    for (var node in _focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  void _onPinChanged() {
    setState(() {
      _isComplete = _controllers.every((c) => c.text.isNotEmpty);
    });
  }

  void _moveFocus(int index, String value) {
    if (value.isNotEmpty && index < _focusNodes.length - 1) {
      _focusNodes[index + 1].requestFocus();
    } else if (value.isEmpty && index > 0) {
      _focusNodes[index - 1].requestFocus();
    }
  }

  Future<void> _handleContinue() async {
    setState(() {
      _isLoading = true;
      _progress = 0.0;
    });

    for (int i = 0; i <= 100; i++) {
      await Future.delayed(
          const Duration(milliseconds: 5)); // Increased speed by reducing delay
      setState(() {
        _progress = i / 100;
      });
    }

    setState(() {
      _isLoading = false;
    });

    await _showSuccessDialog();
    await _showWelcomeDialog();

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => LandingPage()),
    );
  }

  Future<void> _showSuccessDialog() async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        content: SizedBox(
          width: 380,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center, // Center icon horizontally
            children: [
              Center( // Center the icon
                child: Icon(
                  Iconsax.tick_circle,
                  color: Colors.green,
                  size: 80,
                ),
              ),
              SizedBox(height: 16),
              Text(
                'PIN Successfully Created!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF212529),
                ),
              ),
              SizedBox(height: 12),
              Text(
                'You can now securely access your account using your 6-digit PIN.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 15, color: Color(0xFF495057)),
              ),
            ],
          ),
        ),
      ),
    );
    await Future.delayed(const Duration(seconds: 2));
    Navigator.of(context).pop();
  }

  Future<void> _showWelcomeDialog() async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        content: SizedBox(
          width: 380,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: const [
              SizedBox(height: 16),
              Image(
                image: AssetImage('assets/images/logocoop.png'),
                height: 70,
              ),
              SizedBox(height: 20),
              Text(
                'Welcome to GBLDC Mobile!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1A1A1A),
                ),
              ),
              SizedBox(height: 12),
              Text(
                "Let’s get started on your financial journey.",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14, color: Color(0xFF495057)),
              ),
            ],
          ),
        ),
      ),
    );
    await Future.delayed(const Duration(seconds: 2));
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/logocoop.png',
                height: 80,
              ),
              const SizedBox(height: 36),
              const Text(
                "Create PIN",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF1A1A1A),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                "Set up a secure 6-digit PIN to protect your account.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(6, (index) {
                  return SizedBox(
                    width: 45,
                    child: TextField(
                      controller: _controllers[index],
                      focusNode: _focusNodes[index],
                      keyboardType: TextInputType.number,
                      obscureText: true,
                      maxLength: 1,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
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
                      onChanged: (value) => _moveFocus(index, value),
                    ),
                  );
                }),
              ),
              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: _isComplete && !_isLoading ? _handleContinue : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  disabledBackgroundColor: Colors.green.withOpacity(0.4),
                  minimumSize: const Size.fromHeight(52),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 0,
                ),
                child: _isLoading
                    ? SizedBox(
                        width: 24,
                        height: 24,
                        child: CircularProgressIndicator(
                          value: _progress,
                          color: Colors.white,
                          backgroundColor: Colors.green.shade100,
                          strokeWidth: 3.0,
                        ),
                      )
                    : const Text(
                        "Continue",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
              ),
              const SizedBox(height: 30),
              const Text(
                "Your PIN will remain private and secure.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

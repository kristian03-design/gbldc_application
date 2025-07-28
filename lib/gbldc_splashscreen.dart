import 'package:flutter/material.dart';
import 'main.dart'; // Adjust this if WelcomeScreen is in a different file

// --- Constants for this screen ---
const Color _kPrimaryGreenColor = Color(0xFF02883A);
const Color _kWhiteColor = Colors.white;
const Color _kWhite70Color = Colors.white70;
const Color _kWhite24Color = Colors.white24;

const TextStyle _kCooperativeNameStyle = TextStyle(
  color: _kWhiteColor,
  fontSize: 20,
  fontWeight: FontWeight.w600,
  letterSpacing: 0.5,
);

const TextStyle _kSloganStyle = TextStyle(
  color: _kWhite70Color,
  fontSize: 14,
  fontStyle: FontStyle.italic,
);

class _AppAssets {
  static const String logoCoop = 'assets/images/logocoop.png';
}

// --- Splash Screen Widget ---

class GbldcSplashScreen extends StatefulWidget { // Renamed for UpperCamelCase consistency
  const GbldcSplashScreen({super.key});

  @override
  State<GbldcSplashScreen> createState() => _GbldcSplashScreenState();
}

class _GbldcSplashScreenState extends State<GbldcSplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  final Duration _animationDuration = const Duration(seconds: 2);
  final Duration _postAnimationDelay = const Duration(seconds: 1); // Delay after animation before navigation

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      duration: _animationDuration,
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeIn, // Added a curve for smoother animation
      ),
    );

    // Start the animation
    _animationController.forward();

    // Navigate after the animation completes and the additional delay
    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Future.delayed(_postAnimationDelay, () {
          if (mounted) { // Crucial check before navigation
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const WelcomeScreen()),
            );
          }
        });
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _kPrimaryGreenColor,
      body: SafeArea(
        child: Center(
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Logo
                Image.asset(
                  _AppAssets.logoCoop, // Using constant for asset path
                  width: 120,
                  height: 120,
                ),
                const SizedBox(height: 20),

                // Cooperative Name
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30.0),
                  child: Text(
                    'Greater Bulacan Livelihood\nDevelopment Cooperative',
                    textAlign: TextAlign.center,
                    style: _kCooperativeNameStyle, // Using constant style
                  ),
                ),
                const SizedBox(height: 10),

                // Slogan
                const Text(
                  'Empowering lives through financial growth',
                  textAlign: TextAlign.center,
                  style: _kSloganStyle, // Using constant style
                ),
                const SizedBox(height: 50),

                // Custom Loading Animation
                const _CustomLoadingAnimation(), // Using the StatelessWidget
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// --- Helper Widget for Loading Animation ---

class _CustomLoadingAnimation extends StatelessWidget {
  const _CustomLoadingAnimation(); // Added key if it were public

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      width: 40,
      height: 40,
      child: CircularProgressIndicator(
        strokeWidth: 3.5,
        valueColor: AlwaysStoppedAnimation<Color>(_kWhiteColor), // Using constant color
        backgroundColor: _kWhite24Color, // Using constant color
      ),
    );
  }
}

// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'dart:math';
import 'package:iconsax/iconsax.dart';


void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: CreditScorePage(),
  ));
}

class CreditScorePage extends StatefulWidget {
  const CreditScorePage({Key? key}) : super(key: key);

  @override
  State<CreditScorePage> createState() => _CreditScorePageState();
}

class _CreditScorePageState extends State<CreditScorePage> {
  int _creditScore = 100;
  bool _isRefreshing = false;
  Key _animationKey = UniqueKey();

  Future<void> _refreshScore() async {
    setState(() {
      _isRefreshing = true;
    });

    // Simulate a network call to fetch the new score
    await Future.delayed(const Duration(seconds: 2));

    setState(() {
      _creditScore = (Random().nextDouble() * 100).round();
      _isRefreshing = false;
      _animationKey = UniqueKey(); // Change key to restart the animation
    });
  }

  @override
  Widget build(BuildContext context) {
    const int maxScore = 100;
    final double percent = _creditScore / maxScore;

    final Color scoreColor = percent >= 0.82
        ? Colors.green
        : (percent >= 0.7 ? Colors.orange : Colors.red);

    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FA),
      appBar: AppBar(
        title: const Text('Credit Score',
            style: TextStyle(fontWeight: FontWeight.w500)),
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 24.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 16),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.06),
                      blurRadius: 16,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                padding:
                    const EdgeInsets.symmetric(vertical: 32, horizontal: 70),
                child: Column(
                  children: [
                    const Text(
                      'Your Credit Score',
                      style: TextStyle(
                        fontSize: 16,
                        color: Color(0xFF7B8BB2),
                        fontWeight: FontWeight.w500,
                        letterSpacing: 0.2,
                      ),
                    ),
                    const SizedBox(height: 18),
                    SizedBox(
                      width: 120,
                      height: 120,
                      child: TweenAnimationBuilder<double>(
                        key: _animationKey, // Use the key here
                        tween: Tween<double>(begin: 0, end: percent),
                        duration: const Duration(milliseconds: 1000),
                        builder: (context, animatedPercent, _) {
                          final animatedScore =
                              (animatedPercent * maxScore).toInt();
                          return TweenAnimationBuilder<Color?>(
                            tween:
                                ColorTween(begin: Colors.grey, end: scoreColor),
                            duration: const Duration(milliseconds: 800),
                            builder: (context, animatedColor, _) {
                              return CustomPaint(
                                painter: _ArcPainter(
                                  percent: animatedPercent,
                                  color: animatedColor ?? Colors.grey,
                                ),
                                child: Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        '$animatedScore',
                                        style: const TextStyle(
                                          fontSize: 38,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                      ),
                                      const SizedBox(height: 2),
                                      Text(
                                        'of $maxScore',
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.grey[500],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 18),
                    Text(
                      percent >= 0.82
                          ? 'Excellent'
                          : (percent >= 0.7 ? 'Good' : 'Needs Improvement'),
                      style: TextStyle(
                        fontSize: 15,
                        color: scoreColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 28),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'What affects your score?',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                    color: Colors.black,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              _ExpandableScoreFactorCard(
                icon: Iconsax.tick_circle,
                iconColor: Colors.green,
                title: 'On-time payments',
                description:
                    'Making payments on time is the most important factor for your credit score.',
              ),
              const SizedBox(height: 10),
              _ExpandableScoreFactorCard(
                icon: Iconsax.diagram,
                iconColor: Colors.green,
                title: 'Low credit utilization',
                description:
                    'Keeping your credit card balances low compared to your limits helps your score.',
              ),
              const SizedBox(height: 10),
              _ExpandableScoreFactorCard(
                icon: Iconsax.warning_2,
                iconColor: Colors.red,
                title: 'Missed payments',
                description:
                    'Late or missed payments can significantly lower your score.',
              ),
              _ExpandableScoreFactorCard(
                icon: Iconsax.trend_up,
                iconColor: Colors.blue,
                title: 'Higher loan eligibility',
                description:
                    'A longer credit history can improve your score over time and may help you qualify for higher loan amounts.',
              ),
              const SizedBox(height: 10),
              _ExpandableScoreFactorCard(
                icon: Iconsax.timer,
                iconColor: Colors.orange,
                title: 'Credit history length',
                description:
                    'A longer credit history can improve your score over time.',
              ),
              const SizedBox(height: 10),
              _ExpandableScoreFactorCard(
                icon: Iconsax.document_text,
                iconColor: Colors.red,
                title: 'Hard inquiries',
                description:
                    'Multiple hard inquiries in a short time can negatively impact your score.',
              ),
              const SizedBox(height: 20),
              TextButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const LearnMoreCreditScorePage(),
                    ),
                  );
                },
                child: const Text(
                  'Learn more about credit scores',
                  style: TextStyle(
                    color: Colors.green,
                    fontWeight: FontWeight.w500,
                    fontSize: 15,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _isRefreshing ? null : _refreshScore,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF16A34A),
                  foregroundColor: Colors.white,
                  minimumSize: const Size.fromHeight(50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: _isRefreshing
                    ? const SizedBox(
                        height: 24,
                        width: 24,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 3,
                        ),
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(Iconsax.refresh, size: 20),
                          SizedBox(width: 8),
                          Text('Refresh Score', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                        ],
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ArcPainter extends CustomPainter {
  final double percent;
  final Color color;

  _ArcPainter({required this.percent, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final Paint base = Paint()
      ..color = Colors.grey[200]!
      ..strokeWidth = 10
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final Paint progress = Paint()
      ..color = color
      ..strokeWidth = 10
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final Rect rect = Offset(0, 0) & size;
    canvas.drawArc(rect, pi * 0.75, pi * 1.5, false, base);

    canvas.drawArc(rect, pi * 0.75, pi * 1.5 * percent, false, progress);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class _ExpandableScoreFactorCard extends StatefulWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final String description;

  const _ExpandableScoreFactorCard({
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.description,
    Key? key,
  }) : super(key: key);

  @override
  State<_ExpandableScoreFactorCard> createState() =>
      _ExpandableScoreFactorCardState();
}

class _ExpandableScoreFactorCardState extends State<_ExpandableScoreFactorCard>
    with SingleTickerProviderStateMixin {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {
          setState(() {
            _expanded = !_expanded;
          });
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(widget.icon, color: widget.iconColor, size: 20),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      widget.title,
                      style: const TextStyle(
                        fontSize: 15,
                        color: Colors.black87,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  AnimatedRotation(
                    turns: _expanded ? 0.5 : 0.0,
                    duration: const Duration(milliseconds: 300),
                    child: Icon(Icons.expand_more, color: Colors.grey[500]),
                  ),
                ],
              ),
              AnimatedCrossFade(
                firstChild: const SizedBox.shrink(),
                secondChild: Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Text(
                    widget.description,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.black54,
                    ),
                  ),
                ),
                crossFadeState: _expanded
                    ? CrossFadeState.showSecond
                    : CrossFadeState.showFirst,
                duration: const Duration(milliseconds: 300),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class LearnMoreCreditScorePage extends StatelessWidget {
  const LearnMoreCreditScorePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Color primary = Colors.green;
    final Color bg = const Color(0xFFF7F8FA);
    final TextStyle headingStyle = const TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w700,
      color: Colors.black,
      letterSpacing: 0.1,
    );
    final TextStyle subheadingStyle = TextStyle(
      fontSize: 15,
      fontWeight: FontWeight.w600,
      color: Colors.grey[900],
    );
    final TextStyle bodyStyle = TextStyle(
      fontSize: 15,
      color: Colors.grey[800],
      height: 1.5,
    );

    return Scaffold(
      backgroundColor: bg,
      appBar: AppBar(
        title: const Text(
          'About Credit Scores',
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
        ),
        backgroundColor: bg,
        foregroundColor: Colors.black,
        elevation: 0,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _MinimalSection(
                icon: Iconsax.information,
                iconColor: primary,
                title: 'What is a Credit Score?',
                titleStyle: headingStyle.copyWith(
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
                children: [
                  Text(
                    'A credit score is a three-digit number that reflects your overall creditworthiness. It is calculated based on your credit history and helps lenders assess how likely you are to repay borrowed money on time. A higher score increases your chances of being approved for loans and credit cards, often with better terms and lower interest rates.',
                    style: bodyStyle,
                  ),
                ],
              ),
              const SizedBox(height: 18),
              _MinimalSection(
                icon: Iconsax.diagram,
                iconColor: Colors.blue,
                title: 'How is it calculated?',
                titleStyle: headingStyle.copyWith(
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
                children: [
                  const SizedBox(height: 2),
                  _MinimalBullet(
                    text: 'Payment history',
                    icon: Iconsax.tick_circle,
                    iconColor: Colors.green,
                  ),
                  _MinimalBullet(
                    text: 'Amounts owed (credit utilization)',
                    icon: Iconsax.wallet,
                    iconColor: Colors.blue,
                  ),
                  _MinimalBullet(
                    text: 'Length of credit history',
                    icon: Iconsax.timer,
                    iconColor: Colors.orange,
                  ),
                  _MinimalBullet(
                    text: 'Types of credit used',
                    icon: Iconsax.card,
                    iconColor: Colors.purple,
                  ),
                  _MinimalBullet(
                    text: 'Recent credit inquiries',
                    icon: Iconsax.search_normal,
                    iconColor: Colors.red,
                  ),
                ],
              ),
              const SizedBox(height: 18),
              _MinimalSection(
                icon: Iconsax.star,
                iconColor: Colors.amber[700]!,
                title: 'Why does it matter?',
                titleStyle: headingStyle.copyWith(
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
                children: [
                  Text(
                    'A good credit score can help you qualify for better interest rates, higher credit limits, and more financial opportunities. A low score may limit your options and result in higher costs.',
                    style: bodyStyle,
                  ),
                ],
              ),
              const SizedBox(height: 18),
              _MinimalSection(
                icon: Iconsax.trend_up,
                iconColor: primary,
                title: 'How can you improve your score?',
                titleStyle: headingStyle.copyWith(
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
                children: [
                  _MinimalBullet(
                    text: 'Pay your bills on time',
                    icon: Iconsax.tick_square,
                    iconColor: Colors.green,
                  ),
                  _MinimalBullet(
                    text: 'Keep your credit card balances low',
                    icon: Iconsax.wallet,
                    iconColor: Colors.blue,
                  ),
                  _MinimalBullet(
                    text: 'Avoid opening too many new accounts at once',
                    icon: Iconsax.warning_2,
                    iconColor: Colors.orange,
                  ),
                  _MinimalBullet(
                    text: 'Check your credit report for errors',
                    icon: Iconsax.search_normal,
                    iconColor: Colors.red,
                  ),
                ],
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}

class _MinimalSection extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final TextStyle titleStyle;
  final List<Widget> children;

  const _MinimalSection({
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.titleStyle,
    required this.children,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 0),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: iconColor.withOpacity(0.12),
                  shape: BoxShape.circle,
                ),
                padding: const EdgeInsets.all(8),
                child: Icon(icon, color: iconColor, size: 22),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  title,
                  style: titleStyle,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ...children,
        ],
      ),
    );
  }
}

class _MinimalBullet extends StatelessWidget {
  final String text;
  final IconData icon;
  final Color iconColor;

  const _MinimalBullet({
    required this.text,
    required this.icon,
    required this.iconColor,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0, left: 2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: iconColor, size: 18),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                  fontSize: 15,
                  color: Colors.grey[900],
                  fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'how_to_get_loan_page.dart';
import 'landing_page.dart';
import 'profile.dart';
import 'loan-payment-page.dart';
import 'contact-support-page.dart';
import 'increase_your_loan_limit_page.dart';
import 'PaymentHistoryPage.dart';
import 'package:iconsax/iconsax.dart';

void main() {
  runApp(LoanPageHomepage());
}

class LoanPageHomepage extends StatefulWidget {
  @override
  _LoanPageHomepageState createState() => _LoanPageHomepageState();
}

class _LoanPageHomepageState extends State<LoanPageHomepage> {
  int _selectedIndex = 1;
  final GlobalKey<RefreshIndicatorState> _refreshKey =
      GlobalKey<RefreshIndicatorState>();
  List<String> notifications = [
    'Loan application approved',
    'New payment due date',
    'System maintenance scheduled',
    'New message from support',
    'Loan application is under review',
    'Loan application is rejected',
  ];
  Set<int> unreadNotificationIndexes = {0, 1, 2, 3, 4, 5};

  int get unreadCount => unreadNotificationIndexes.length;

  Future<void> _refreshData() async {
    // Simulate network/data fetching delay
    await Future.delayed(const Duration(seconds: 1));
    setState(() {
      // Example: Reset notifications or reload data here
      // notifications = [...]; // fetch or reset your notifications
      // unreadNotificationIndexes = {...}; // reset as needed
    });
  }

  void _onItemTapped(int index) {
    if (index == _selectedIndex) return;
    Widget targetPage;
    switch (index) {
      case 0:
        targetPage = LandingPage();
        break;
      case 2:
        targetPage = AccountPage();
        break;
      default:
        return;
    }

    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 800),
        pageBuilder: (context, animation, _) => targetPage,
        transitionsBuilder: (context, animation, _, child) {
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
  }

  @override
  Widget build(BuildContext context) {
    final loanLimit = NumberFormat('#,###').format(20000);
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: _buildBottomNavigationBar(),
      body: SafeArea(
        child: RefreshIndicator(
          key: _refreshKey,
          onRefresh: _refreshData,
          color: Colors.green,
          backgroundColor: Colors.white,
          strokeWidth: 3.0,
          displacement: 60.0,
          edgeOffset: 15.0,
          semanticsLabel: 'Pull to refresh loan page',
          semanticsValue: 'Refreshing content',
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(),
                const SizedBox(height: 24),
                _buildLoanLimitCard(loanLimit),
                const SizedBox(height: 24),
                const Text(
                  "Your Loan Details",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 12),
                _buildLoanStatusCard(),
                const SizedBox(height: 24),
                const Text(
                  "Quick Actions",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 12),
                _buildGridOptions(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBottomNavigationBar() {
    return BottomNavigationBar(
      currentIndex: _selectedIndex,
      selectedItemColor: Colors.green,
      unselectedItemColor: Colors.black,
      backgroundColor: Colors.white,
      type: BottomNavigationBarType.fixed,
      elevation: 10,
      selectedFontSize: 14,
      unselectedFontSize: 13,
      items: const [
        BottomNavigationBarItem(icon: Icon(Iconsax.home), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Iconsax.money), label: 'Loan'),
        BottomNavigationBarItem(
            icon: Icon(Iconsax.profile_circle), label: 'Profile'),
      ],
      onTap: _onItemTapped,
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        Image.asset('assets/images/logocoop.png', height: 50, width: 50),
        const SizedBox(width: 10),
        Expanded(
          child: Center(
            child: Text(
              'GBLDC',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
            ),
          ),
        ),
        Stack(
          children: [
            CircleAvatar(
              backgroundColor: Colors.green[50],
              child: IconButton(
                icon: const Icon(Iconsax.notification,
                    color: Colors.green, size: 25),
                onPressed: () => showNotificationsPopup(context),
              ),
            ),
            if (unreadCount > 0)
              Positioned(
                right: 6,
                top: 6,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: const BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                  child: Text(
                    '$unreadCount',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ],
    );
  }

  Widget _buildLoanLimitCard(String loanLimit) {
    // Define styles for consistency and reusability
    const cardBackgroundColor = Color(0xFFE8F5E9); // Softer green
    const primaryTextColor = Colors.green;
    const secondaryTextColor = Colors.black;
    const tertiaryTextColor = Colors.grey;
    const progressColor = Colors.green;
    const buttonBackgroundColor = Colors.green;
    const buttonTextColor = Colors.white;

    const titleTextStyle = TextStyle(
      color: primaryTextColor,
      fontSize: 16,
      fontWeight: FontWeight.w600,
    );
    const amountTextStyle = TextStyle(
      fontSize: 32,
      fontWeight: FontWeight.bold,
      color: secondaryTextColor,
    );
    const subtitleTextStyle = TextStyle(
      fontSize: 14,
      color: tertiaryTextColor,
    );
    const buttonLabelStyle = TextStyle(
      fontSize: 16,
      color: buttonTextColor,
    );

    return Card(
      elevation: 4,
      margin: EdgeInsets
          .zero, // Remove default card margin if padding is handled by parent
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      color: cardBackgroundColor,
      child: Container(
        padding: const EdgeInsets.all(20),
        child: Stack(
          children: [
            Positioned(
              top: -2, // Adjusted for better visual balance
              right: -2, // Adjusted for better visual balance
              child: Opacity(
                opacity: 0.4, // Slightly more subtle
                child:
                    Icon(Iconsax.wallet_3, size: 80, color: primaryTextColor),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Available Loan Limit', style: titleTextStyle),
                const SizedBox(height: 10),
                TweenAnimationBuilder<double>(
                  tween: Tween<double>(
                      begin: 0, end: 20000), // Your final loan value
                  duration: const Duration(seconds: 2),
                  curve: Curves.easeOut,
                  builder: (context, value, _) {
                    final animatedText =
                        NumberFormat.currency(locale: 'en_PH', symbol: '₱')
                            .format(value.round());
                    return Text(animatedText, style: amountTextStyle);
                  },
                ),
                const SizedBox(height: 8),
                const Text('Up to your current approved limit',
                    style: subtitleTextStyle),
                const SizedBox(height: 20), // Increased spacing
                TweenAnimationBuilder<double>(
                  tween: Tween(
                      begin: 0.0,
                      end: 0.4), // Example value, adjust dynamically
                  duration: const Duration(
                      milliseconds: 1500), // Slightly faster animation
                  curve: Curves.easeOutCubic, // Smoother curve
                  builder: (context, value, _) {
                    return ClipRRect(
                      // Ensures the border radius is applied to the progress indicator
                      borderRadius: BorderRadius.circular(14),
                      child: LinearProgressIndicator(
                        value: value,
                        backgroundColor: Colors.green[100],
                        valueColor:
                            const AlwaysStoppedAnimation<Color>(progressColor),
                        minHeight: 10,
                        borderRadius:
                            BorderRadius.circular(6), // Slightly thicker //
                      ),
                    );
                  },
                ),
                TweenAnimationBuilder<double>(
                  tween: Tween(begin: 0.0, end: 0.4), // Same tween as above
                  duration: const Duration(milliseconds: 1500), // Same duration
                  curve: Curves.easeOutCubic, // Same curve
                  builder: (context, value, _) {
                    // Now 'value' directly gives the progress from this TweenAnimationBuilder
                    return Column(
                      children: [
                        const SizedBox(height: 4),
                        Text("${(value * 100).toStringAsFixed(0)}% Paid",
                            style: const TextStyle(
                                fontSize: 12, color: Colors.black54)),
                      ],
                    );
                  },
                ),
                const SizedBox(height: 20),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLoanStatusCard() {
    // Define text styles and colors for consistency and easier modification
    const titleStyle = TextStyle(
        fontSize: 16, fontWeight: FontWeight.w600, color: Colors.black87);
    const detailStyle = TextStyle(fontSize: 14, color: Colors.black54);
    const spacing = SizedBox(height: 8); // Consistent spacing

    // Define button styles locally
    const buttonBackgroundColor = Colors.green;
    const buttonTextColor = Colors.white;
    const buttonLabelStyle = TextStyle(
      fontSize: 16,
      color: buttonTextColor,
    );

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white, // Using white for a cleaner look, can be adjusted
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.15),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(2, 8), // changes position of shadow
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: const [
              Icon(Iconsax.activity, color: Colors.blueAccent, size: 20),
              SizedBox(width: 8),
              Text('Status: Active', style: titleStyle),
            ],
          ),
          spacing,
          Row(
            children: const [
              Icon(Iconsax.calendar, color: Colors.orangeAccent, size: 18),
              SizedBox(width: 8),
              Text('Next payment due: Aug 15, 2025', style: detailStyle),
            ],
          ),
          spacing,
          Row(
            children: const [
              Icon(Iconsax.wallet_check, color: Colors.green, size: 18),
              SizedBox(width: 8),
              Text('Remaining balance: ₱11,500', style: detailStyle),
            ],
          ),
          const SizedBox(height: 16),
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      PageRouteBuilder(
                        transitionDuration: const Duration(milliseconds: 800),
                        pageBuilder: (context, animation, _) =>
                            LoanPaymentPage(),
                        transitionsBuilder: (context, animation, _, child) {
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
                  label: Text('Pay Loan', style: buttonLabelStyle),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: buttonBackgroundColor,
                    minimumSize: const Size(double.infinity, 50), // Full width
                    padding:
                        const EdgeInsets.symmetric(horizontal: 35, vertical: 8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    elevation: 2, // Added slight elevation to button
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  "You can make a partial payment or pay the full amount.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 13,
                      color: Colors.black54,
                      fontStyle: FontStyle.italic),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGridOptions() {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      mainAxisSpacing: 16,
      crossAxisSpacing: 16,
      childAspectRatio: 1.5,
      children: [
        _optionCard('How to Get a Loan?', 'Easy steps', Iconsax.information,
            () {
          Navigator.push(
              context, MaterialPageRoute(builder: (_) => HowToGetLoanPage()));
        }),
        _optionCard('Increase Your Limit', 'Learn More', Iconsax.trend_up, () {
          Navigator.push(
              context, MaterialPageRoute(builder: (_) => IncreaseLimitPage()));
        }),
        _optionCard('Payment History', 'Track past payments', Iconsax.clock,
            () {
          Navigator.push(
              context, MaterialPageRoute(builder: (_) => PaymentHistoryPage()));
        }),
        _optionCard('Contact Support', 'Need help?', Iconsax.message_question,
            () {
          Navigator.push(
              context, MaterialPageRoute(builder: (_) => LiveChatPage()));
        }),
      ],
    );
  }

  Widget _optionCard(
      String title, String subtitle, IconData icon, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Row(
          children: [
            Icon(icon, size: 30, color: Colors.green),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: const TextStyle(fontWeight: FontWeight.w600)),
                  const SizedBox(height: 2),
                  Text(subtitle,
                      style: TextStyle(fontSize: 12, color: Colors.grey[600])),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void showNotificationsPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(builder: (context, setStateDialog) {
          return AlertDialog(
            insetPadding: const EdgeInsets.symmetric(horizontal: 13.0),
            backgroundColor: Colors.white,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(13)),
            title: const Text('Notifications',
                style: TextStyle(fontWeight: FontWeight.w400)),
            content: SizedBox(
              width: double.maxFinite,
              child: notifications.isEmpty
                  ? const Text('No notifications')
                  : ListView.separated(
                      shrinkWrap: true,
                      itemCount: notifications.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 8),
                      itemBuilder: (context, index) {
                        bool isUnread =
                            unreadNotificationIndexes.contains(index);
                        return Dismissible(
                          key: Key(notifications[index]),
                          direction: DismissDirection.endToStart,
                          background: Container(
                            margin: const EdgeInsets.symmetric(vertical: 4),
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            alignment: Alignment.centerRight,
                            padding: const EdgeInsets.only(right: 20),
                            child:
                                const Icon(Iconsax.trash, color: Colors.white),
                          ),
                          onDismissed: (_) {
                            setStateDialog(() {
                              unreadNotificationIndexes.remove(index);
                              notifications.removeAt(index);
                              unreadNotificationIndexes =
                                  unreadNotificationIndexes
                                      .where((i) => i != index)
                                      .map((i) => i > index ? i - 1 : i)
                                      .toSet();
                            });
                          },
                          child: Container(
                            margin: const EdgeInsets.symmetric(vertical: 4),
                            decoration: BoxDecoration(
                              color: isUnread
                                  ? Colors.green.shade50
                                  : Colors.grey.shade100,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: ListTile(
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 16),
                              leading: Icon(Iconsax.notification,
                                  color: isUnread ? Colors.green : Colors.grey),
                              title: Text(
                                notifications[index],
                                style: TextStyle(
                                  fontWeight: isUnread
                                      ? FontWeight.w400
                                      : FontWeight.normal,
                                  color: isUnread
                                      ? Colors.black
                                      : Colors.grey[400],
                                ),
                              ),
                              trailing: isUnread
                                  ? Container(
                                      width: 12,
                                      height: 12,
                                      decoration: const BoxDecoration(
                                        color: Colors.red,
                                        shape: BoxShape.circle,
                                      ),
                                    )
                                  : null,
                              onTap: () => setStateDialog(() =>
                                  unreadNotificationIndexes.remove(index)),
                            ),
                          ),
                        );
                      },
                    ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Close',
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight.w400)),
              ),
              TextButton(
                onPressed: () => setStateDialog(() {
                  unreadNotificationIndexes.clear();
                }),
                child: const Text('Mark all as read',
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.green,
                        fontWeight: FontWeight.w400)),
              ),
            ],
          );
        });
      },
    );
  }
}

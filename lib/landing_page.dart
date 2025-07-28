import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'loan-page.dart';
import 'online-application.dart';
import 'profile.dart';
import 'explore_services_page.dart';
import 'smart_money_tips_page.dart';
import 'news_details_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Poppins',
        primarySwatch: Colors.green,
      ),
    );
  }
}

class LandingPage extends StatefulWidget {
  // Added this wrapper back
  const LandingPage({super.key});

  @override
  _LandingPageState createState() => _LandingPageState();
}

// --- Constants (assuming these are defined elsewhere or at the top of your file) ---
const Duration kDefaultTransitionDuration = Duration(milliseconds: 800);
const double kDefaultPadding = 16.0;
const Color kPrimaryColor = Colors.green; // Assuming this is your primary color
const Color kAppBarTextColor = Colors.black;
const Color kScaffoldBackgroundColor = Color(0xFFF4F6F9);

class NewsEvent {
  final String title;
  final String description;
  final String imagePath;
  final List<String>? imagePaths;

  const NewsEvent({
    required this.title,
    required this.description,
    required this.imagePath,
    this.imagePaths,
  });
}

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

// --- Navigation Helper (assuming it's defined as before) ---
Future<void> navigateWithFade(BuildContext context, Widget page) {
  return Navigator.push(
    context,
    PageRouteBuilder(
      transitionDuration: kDefaultTransitionDuration,
      pageBuilder: (context, animation, _) => page,
      transitionsBuilder: (context, animation, _, child) {
        final curved =
            CurvedAnimation(parent: animation, curve: Curves.easeInOut);
        return FadeTransition(opacity: curved, child: child);
      },
    ),
  );
}

class _LandingPageState extends State<LandingPage> {
  int _selectedIndex = 0;
  bool _showGreeting = true;

  final GlobalKey<RefreshIndicatorState> _refreshKey =
      GlobalKey<RefreshIndicatorState>();

  final List<NewsEvent> _newsAndEvents = const [
    NewsEvent(
      title: 'Annual General Assembly',
      description: 'Join us for our annual meeting and updates.',
      imagePath: 'assets/images/event1.jpg',
      imagePaths: [
        'assets/images/event1.jpg',
        'assets/images/event2.jpg',
        'assets/images/event3.jpg',
        'assets/images/event4.jpg'
      ],
    ),
    NewsEvent(
      title: 'Community Outreach Program',
      description:
          'Serving the barangay together through health and donation drives.',
      imagePath: 'assets/images/event4.jpg',
    ),
    NewsEvent(
      title: 'Kick-Off Ceremony and Launching of Go Koop',
      description:
          'Empowering Cooperatives in line with the Celebration of Cooperative Month 2023',
      imagePath: 'assets/images/event2.jpg',
    ),
    NewsEvent(
      title: 'GBLDC - Team Building',
      description:
          'Strengthening teamwork through fun and engaging activities with all departments.',
      imagePath: 'assets/images/event3.jpg',
    ),
  ];
  Future<void> _refreshData() async {
    // Simulate network/data fetching delay
    await Future.delayed(const Duration(seconds: 1));

    // Example: Reset greeting and notifications (customize as needed)
    setState(() {
      _showGreeting = true;
      // Optionally reset notifications or reload data here
      // notifications = [...]; // fetch or reset your notifications
      // unreadNotificationIndexes = {...}; // reset as needed
    });
  }

  void _onItemTapped(int index) {
    if (index == 0 && _selectedIndex == 0) {
      _refreshKey.currentState?.show(); // Programmatically trigger refresh
      return;
    }
    if (index == 0) {
      setState(() {
        _selectedIndex = index;
      });
    } else if (index == 1) {
      navigateWithFade(context, LoanPageHomepage());
    } else if (index == 2) {
      navigateWithFade(context, AccountPage());
    }
  }

  String _getGreeting() {
    final hour = DateTime.now().hour;
    if (hour >= 5 && hour < 12) return 'Good Morning!';
    if (hour >= 12 && hour < 17) return 'Good Afternoon!';
    return 'Good Evening!';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kScaffoldBackgroundColor,
      bottomNavigationBar: _buildBottomNavigationBar(),
      body: SafeArea(
        child: Container(
          color: Colors
              .white, // Or kScaffoldBackgroundColor if you want consistency
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
            child: RefreshIndicator(
              key: _refreshKey,
              onRefresh: _refreshData, // Your updated refresh logic
              color: kPrimaryColor, // Spinner color
              backgroundColor: Colors.white, // Background of the spinner circle
              strokeWidth:
                  3.0, // Thickness of the spinner line (default is 2.0)
              displacement:
                  60.0, // Distance from child's top edge to trigger (default is 40.0)
              edgeOffset:
                  15.0, // Distance from the edge of scrollable content where indicator appears
              semanticsLabel:
                  'Pull to refresh home screen', // For accessibility
              semanticsValue: 'Refreshing content', // For accessibility
              child: ListView(
                children: [
                  const SizedBox(height: 20),
                  _buildAppBarContent(),
                  const SizedBox(height: 12),
                  if (_showGreeting)
                    _GreetingCard(
                      greeting: _getGreeting(),
                      onDismissed: () {
                        setState(() {
                          _showGreeting = false;
                        });
                      },
                    ),
                  const SizedBox(height: 12),
                  _buildNewsAndEventsCarousel(), // Using the version from your snippet, adapted
                  const SizedBox(height: 18),
                  _buildMainActionCards(),
                  const SizedBox(height: 20), // Padding at the bottom
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBottomNavigationBar() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 5,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: BottomNavigationBar(
        currentIndex: _selectedIndex,
        selectedItemColor: kPrimaryColor,
        unselectedItemColor: kAppBarTextColor.withOpacity(0.7),
        backgroundColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        elevation: 0,
        selectedLabelStyle:
            const TextStyle(fontWeight: FontWeight.w500, fontSize: 13),
        unselectedLabelStyle:
            const TextStyle(fontWeight: FontWeight.w400, fontSize: 12),
        items: const [
          BottomNavigationBarItem(icon: Icon(Iconsax.home_1), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Iconsax.money_4), label: 'Loan'),
          BottomNavigationBarItem(
              icon: Icon(Iconsax.profile_circle5), label: 'Profile'),
        ],
        onTap: _onItemTapped,
      ),
    );
  }

  Widget _buildAppBarContent() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Image.asset('assets/images/logocoop.png', height: 45, width: 45),
        const Text(
          'GBLDC',
          style: TextStyle(
              fontSize: 22,
              color: kAppBarTextColor,
              fontWeight: FontWeight.w600),
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

  Widget _buildNewsAndEventsCarousel() {
    // Adapted from your snippet
    if (_newsAndEvents.isEmpty) {
      return const Center(
          child: Padding(
        padding: EdgeInsets.symmetric(vertical: 20.0),
        child: Text("No news or events at the moment.",
            style: TextStyle(color: Colors.grey)),
      ));
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 4.0, bottom: 12.0),
          child: Text(
            'News & Events',
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: kAppBarTextColor),
          ),
        ),
        CarouselSlider(
          options: CarouselOptions(
            height: 180.0,
            autoPlay: true,
            enlargeCenterPage: true,
            aspectRatio: 16 / 9,
            autoPlayCurve: Curves.fastOutSlowIn,
            enableInfiniteScroll: true,
            autoPlayAnimationDuration: const Duration(milliseconds: 900),
            viewportFraction: 0.85,
          ),
          items: _newsAndEvents.map((eventItem) {
            return Builder(
              builder: (BuildContext context) {
                return GestureDetector(
                  onTap: () {
                    navigateWithFade(
                      context,
                      NewsDetailPage(
                        title: eventItem.title,
                        description: eventItem.description,
                        imagePath:
                            eventItem.imagePaths ?? [eventItem.imagePath],
                      ),
                    );
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.symmetric(horizontal: 5.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      image: DecorationImage(
                        image: AssetImage(eventItem.imagePath),
                        fit: BoxFit.cover,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.15),
                          blurRadius: 6,
                          offset: const Offset(0, 3),
                        )
                      ],
                    ),
                    child: Container(
                      padding: const EdgeInsets.all(12.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          colors: [
                            Colors.black.withOpacity(0.8),
                            Colors.black.withOpacity(0.0)
                          ],
                          stops: const [0.0, 0.7],
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            eventItem.title,
                            style: const TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            eventItem.description,
                            style: TextStyle(
                              fontSize: 13.0,
                              color: Colors.white.withOpacity(0.9),
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildMainActionCards() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 4.0, bottom: 12.0, top: 10.0),
          child: Text(
            'Quick Actions',
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: kAppBarTextColor),
          ),
        ),
        _ActionCard(
          title: 'Borrow Your Way',
          subtitle: 'Apply once for continuous access to cash.',
          imagePath: 'assets/images/gbldc-borrow-money.png',
          buttons: [
            ElevatedButton(
              onPressed: () =>
                  navigateWithFade(context, const RegistrationForm()),
              style: ElevatedButton.styleFrom(
                backgroundColor: kPrimaryColor,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                padding:
                    const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
              ),
              child: const Text('Online Application',
                  style: TextStyle(fontSize: 13)),
            ),
          ],
        ),
        _ActionCard(
          title: 'Explore Our Services',
          subtitle: 'Microloans, livelihood programs, and more.',
          imagePath: 'assets/images/gbldc-explore-services.png',
          buttons: [
            TextButton(
              onPressed: () =>
                  navigateWithFade(context, const ExploreServicesPage()),
              style: TextButton.styleFrom(
                backgroundColor: kPrimaryColor.withOpacity(0.1),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                padding:
                    const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
              ),
              child: const Text('EXPLORE',
                  style: TextStyle(
                      color: kPrimaryColor,
                      fontSize: 13,
                      fontWeight: FontWeight.w600)),
            ),
          ],
        ),
        _ActionCard(
          title: 'Smart Money Tips',
          subtitle: 'Save, budget, and manage your finances.',
          imagePath: 'assets/images/finance-tips.png',
          buttons: [
            TextButton(
              onPressed: () =>
                  navigateWithFade(context, const SmartMoneyTipsPage()),
              style: TextButton.styleFrom(
                backgroundColor: kPrimaryColor.withOpacity(0.1),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                padding:
                    const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
              ),
              child: const Text('LEARN MORE',
                  style: TextStyle(
                      color: kPrimaryColor,
                      fontSize: 13,
                      fontWeight: FontWeight.w600)),
            ),
          ],
        ),
      ],
    );
  }
}

class _GreetingCard extends StatelessWidget {
  final String greeting;
  final VoidCallback onDismissed;

  const _GreetingCard({required this.greeting, required this.onDismissed});

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: const Key('greetingCard'),
      direction: DismissDirection.horizontal,
      onDismissed: (_) => onDismissed(),
      background: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
            color: Colors.red, borderRadius: BorderRadius.circular(12)),
        alignment: Alignment.centerLeft,
        child: const Icon(Iconsax.trash, color: Colors.white),
      ),
      secondaryBackground: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
            color: Colors.red, borderRadius: BorderRadius.circular(12)),
        alignment: Alignment.centerRight,
        child: const Icon(Iconsax.trash, color: Colors.white),
      ),
      child: Container(
        padding: const EdgeInsets.all(kDefaultPadding),
        decoration: BoxDecoration(
          color: kPrimaryColor.withOpacity(0.05),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: kPrimaryColor.withOpacity(0.2)),
        ),
        child: Row(
          children: [
            Icon(Iconsax.sun_1, color: kPrimaryColor, size: 36),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    greeting,
                    style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: kPrimaryColor),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'Welcome to Greater Bulacan Livelihood Development Cooperative',
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: kAppBarTextColor),
                  ),
                ],
              ),
            ),
            IconButton(
              icon: Icon(Icons.close,
                  color: kPrimaryColor.withOpacity(0.7), size: 20),
              onPressed: onDismissed,
              tooltip: 'Dismiss greeting',
            )
          ],
        ),
      ),
    );
  }
}

class _NotificationBell extends StatelessWidget {
  final int unreadCount;
  final VoidCallback onPressed;

  const _NotificationBell(
      {super.key, required this.unreadCount, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    final Color iconColor = kPrimaryColor;
    final Color avatarBackgroundColor = kPrimaryColor.withOpacity(0.08);
    final Color badgeBackgroundColor = Colors.red;
    const double iconSize = 25.0;

    return Stack(
      alignment: Alignment.center,
      children: [
        CircleAvatar(
          backgroundColor: avatarBackgroundColor,
          radius: 20,
          child: IconButton(
            icon: Icon(Iconsax.notification, color: iconColor, size: iconSize),
            onPressed: onPressed,
            splashRadius: 24,
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
          ),
        ),
        if (unreadCount > 0)
          Positioned(
            right: 4,
            top: 4,
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                  color: badgeBackgroundColor,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 1.0)),
              constraints: const BoxConstraints(minWidth: 16, minHeight: 16),
              child: Center(
                child: Text(
                  unreadCount > 99 ? '99+' : '$unreadCount',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.w500,
                      height: 1.1),
                ),
              ),
            ),
          ),
      ],
    );
  }
}

class _ActionCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String imagePath;
  final List<Widget> buttons;

  const _ActionCard({
    required this.title,
    required this.subtitle,
    required this.imagePath,
    required this.buttons,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8,
              offset: const Offset(0, 2))
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: kAppBarTextColor)),
                const SizedBox(height: 4),
                Text(subtitle,
                    style: TextStyle(fontSize: 13, color: Colors.grey[700])),
                const SizedBox(height: 12),
                Wrap(spacing: 8, runSpacing: 8, children: buttons),
              ],
            ),
          ),
          const SizedBox(width: 16),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset(
              imagePath,
              width: 90,
              height: 90,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) =>
                  const Icon(Icons.error, size: 90),
            ),
          ),
        ],
      ),
    );
  }
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
                      bool isUnread = unreadNotificationIndexes.contains(index);
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
                          child: const Icon(Iconsax.trash, color: Colors.white),
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
                                color:
                                    isUnread ? Colors.black : Colors.grey[400],
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
                            onTap: () => setStateDialog(
                                () => unreadNotificationIndexes.remove(index)),
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

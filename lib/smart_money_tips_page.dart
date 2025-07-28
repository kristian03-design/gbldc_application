import 'package:flutter/material.dart';
import 'tip_detail_page.dart';
import 'package:iconsax/iconsax.dart';

void main() {
  runApp(const SmartMoneyTipsPage());
}

class SmartMoneyTipsPage extends StatefulWidget {
  const SmartMoneyTipsPage({super.key});

  @override
  State<SmartMoneyTipsPage> createState() => _SmartMoneyTipsPageState();
}

class _SmartMoneyTipsPageState extends State<SmartMoneyTipsPage> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  String _selectedCategory = 'All Categories';

  final List<Tip> tips = [
    Tip(
      title: "Budgeting 101",
      icon: Iconsax.wallet_3,
      description: "Track your income and expenses monthly to avoid overspending.",
      category: "Budgeting",
      examples: [
        "List your monthly income and all expenses in categories.",
        "Use budgeting apps like Spendee, GoodBudget, or Monefy.",
        "Follow the 50/30/20 rule: 50% needs, 30% wants, 20% savings.",
        "Review your expenses weekly to see where your money goes.",
        "Set spending limits for food, transport, and shopping.",
        "Track even small expenses like snacks or coffee.",
        "Use cash envelopes for better discipline on categories.",
        "Compare actual vs. planned spending at the end of each month.",
      ],
    ),
    Tip(
      title: "Emergency Fund",
      icon: Iconsax.safe_home,
      description: "Save 3-6 months' worth of expenses for financial security.",
      category: "Saving",
      examples: [
        "Save at least 3–6 months’ worth of expenses.",
        "If you spend ₱15,000/month, target ₱45,000–₱90,000 in savings.",
        "Start small: ₱1,000/month adds up over time.",
        "Keep it in a separate savings account, not with daily-use money.",
        "Avoid using your emergency fund unless truly needed.",
        "Automate saving a fixed amount from each paycheck.",
        "Replenish the fund immediately after use.",
        "Track medical, job loss, or urgent repair costs that might require it.",
      ],
    ),
    Tip(
      title: "Avoid Impulse Spending",
      icon: Iconsax.timer_start,
      description: "Use the 24-hour rule before buying anything non-essential.",
      category: "Spending",
      examples: [
        "Use the 24-hour rule before non-essential purchases.",
        "Unsubscribe from marketing emails that tempt you.",
        "Avoid shopping when emotional or bored.",
        "Stick to a list when shopping—no extras.",
        "Wait for sales or compare prices before buying.",
        "Leave items in your online cart for a day before checking out.",
        "Set spending limits on your e-wallet or debit card.",
        "Track impulse buys monthly and reflect on them.",
      ],
    ),
    Tip(
      title: "Smart Borrowing",
      icon: Iconsax.receipt_2,
      description: "Only borrow what you can repay. Check interest rates first.",
      category: "Borrowing",
      examples: [
        "Only borrow what you can afford to repay monthly.",
        "Compare interest rates between lenders before borrowing.",
        "Avoid payday loans with high interest and short terms.",
        "Check if the lender is registered with the SEC (Philippines).",
        "Understand all loan fees (processing, late, penalty, etc.).",
        "Borrow for needs, not wants (e.g. medical vs. gadgets).",
        "Use loan calculators to check how much you’ll pay back.",
        "Pay on time to avoid damage to your credit reputation.",
      ],
    ),
    Tip(
      title: "Set Saving Goals",
      icon: Iconsax.flag,
      description: "Have clear targets like ₱10k in 6 months. Use autosave tools.",
      category: "Saving",
      examples: [
        "Set SMART goals: Specific, Measurable, Achievable, Relevant, Time-bound.",
        "Example: Save ₱10,000 for tuition in 5 months (₱2,000/month).",
        "Write down your goals and put them where you’ll see them.",
        "Break goals into smaller weekly or bi-weekly targets.",
        "Celebrate small wins when you reach milestones.",
        "Use apps or spreadsheets to monitor your progress.",
        "Label separate accounts for each savings goal.",
        "Make it visual: Use trackers or savings thermometers.",
      ],
    ),
    Tip(
      title: "Spotting Scams",
      icon: Iconsax.shield_tick,
      description: "Don’t share personal info. Always verify loan offers.",
      category: "Security",
      examples: [
        "Never share your OTP, PIN, or account details with anyone.",
        "Check if a loan app is registered with BSP or SEC.",
        "Beware of offers that sound too good to be true.",
        "Look for poor grammar or suspicious sender emails.",
        "Don’t click on unknown links in SMS or emails.",
        "Ask the company to send proof or call their hotline.",
        "Search for online reviews or scam warnings about the lender.",
        "Report phishing attempts to your bank or the National Privacy Commission.",
      ],
    ),
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _showFilterDialog() async {
    final categories = [
      'All Categories',
      ...tips.map((e) => e.category).toSet().toList()
    ];

    await showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          backgroundColor: Colors.white,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Filter by Category',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 10),
                ...categories.map((category) {
                  final isSelected = category == _selectedCategory;
                  return ListTile(
                    title: Text(
                      category,
                      style: TextStyle(
                        fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                        color: isSelected ? Colors.green : Colors.black,
                      ),
                    ),
                    leading: Icon(
                      isSelected ? Icons.radio_button_checked : Icons.radio_button_off,
                      color: isSelected ? Colors.green : Colors.grey,
                    ),
                    onTap: () {
                      setState(() => _selectedCategory = category);
                      Navigator.pop(context);
                    },
                  );
                }).toList(),
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("Cancel", style: TextStyle(color: Colors.black),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final filteredTips = tips.where((tip) {
      final matchesSearch = tip.title.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          tip.description.toLowerCase().contains(_searchQuery.toLowerCase());
      final matchesCategory = _selectedCategory == 'All Categories' || tip.category == _selectedCategory;
      return matchesSearch && matchesCategory;
    }).toList();

    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(
        title: const Text("Smart Money Tips", style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: const BackButton(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 5,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: TextField(
                      controller: _searchController,
                      onChanged: (value) => setState(() => _searchQuery = value),
                      decoration: InputDecoration(
                        hintText: "Search tips...",
                        prefixIcon: const Icon(Iconsax.search_normal, color: Colors.grey),
                        suffixIcon: _searchController.text.isNotEmpty
                            ? IconButton(
                          icon: const Icon(Iconsax.close_circle),
                          onPressed: () {
                            _searchController.clear();
                            setState(() => _searchQuery = '');
                          },
                        )
                            : null,
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 5,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: IconButton(
                    icon: Icon(
                      Iconsax.filter,
                      color: _selectedCategory == 'All Categories'
                          ? Colors.grey
                          : Colors.green,
                    ),
                    onPressed: _showFilterDialog,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Expanded(
              child: filteredTips.isNotEmpty
                  ? ListView.builder(
                itemCount: filteredTips.length,
                itemBuilder: (context, index) => _buildTipCard(filteredTips[index]),
              )
                  : const Center(child: Text("No tips found")),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTipCard(Tip tip) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 5)],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(tip.icon, size: 30, color: Colors.green),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(tip.title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                const SizedBox(height: 6),
                Text(tip.description),
                const SizedBox(height: 8),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => TipDetailPage(tip: tip)),
                    );
                  },
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.green,
                    backgroundColor: Colors.green.withOpacity(0.1),
                    shape: const StadiumBorder(),
                  ),
                  child: const Text("Learn more"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class Tip {
  final String title;
  final IconData icon;
  final String description;
  final String category;
  final List<String> examples;

  Tip({
    required this.title,
    required this.icon,
    required this.description,
    required this.category,
    required this.examples,
  });
}

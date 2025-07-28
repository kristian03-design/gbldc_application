import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'savings_investment_page.dart';
import 'online-application.dart';
import 'insurance_page.dart';
import 'cooperative_member_benefits_page.dart';

void main() {
  runApp(const ExploreServicesPage());
}

class ExploreServicesPage extends StatefulWidget {
  const ExploreServicesPage({super.key});

  @override
  State<ExploreServicesPage> createState() => _ExploreServicesPageState();
}

class _ExploreServicesPageState extends State<ExploreServicesPage> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  String _selectedCategory = 'All Categories';

  final List<ServiceCategory> _allSections = [
    ServiceCategory(
      icon: Iconsax.dollar_circle,
      title: "Loan Products",
      services: [
        "Personal Loan – Everyday needs",
        "Salary Loan – Until payday",
        "Business Loan – Grow your venture",
      ],
      buttonLabel: "Apply Now",
    ),
    ServiceCategory(
      icon: Iconsax.save_2,
      title: "Savings & Investments",
      services: [
        "Savings Account – Secure & grow",
        "Time Deposit – Higher returns",
        "Micro-Investments – Start small",
      ],
      buttonLabel: "Start Saving",
    ),
    ServiceCategory(
      icon: Iconsax.shield_tick,
      title: "Insurance",
      services: [
        "Life Insurance – Family protection",
        "Accident Coverage – Be prepared",
      ],
      buttonLabel: "Get Covered",
    ),
    ServiceCategory(
      icon: Iconsax.gift,
      title: "Cooperative Member Benefits",
      services: [
        "Dividend Sharing – Annual profit distribution",
        "Patronage Refund – Rewards for using services",
        "Educational Seminars – Financial literacy programs",
        "Community Programs – Participate and contribute",
      ],
      buttonLabel: "Explore Benefits",
    ),
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _showFilterDialog() async {
    final categories = ['All Categories', ..._allSections.map((e) => e.title)];

    await showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          elevation: 6,
          backgroundColor: Colors.white,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Filter by Category',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 10),
                ...categories.map((category) {
                  final bool isSelected = category == _selectedCategory;
                  return Container(
                    margin: const EdgeInsets.symmetric(vertical: 4),
                    decoration: BoxDecoration(
                      color: isSelected ? Colors.green.withOpacity(0.1) : Colors.transparent,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ListTile(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      title: Text(
                        category,
                        style: TextStyle(
                          fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                          color: isSelected ? Colors.green : Colors.black87,
                        ),
                      ),
                      leading: Icon(
                        isSelected ? Icons.radio_button_checked : Icons.radio_button_off,
                        color: isSelected ? Colors.green : Colors.grey,
                      ),
                      onTap: () {
                        setState(() => _selectedCategory = category);
                        Navigator.pop(context); // Close dialog immediately
                      },
                    ),
                  );
                }).toList(),
                const SizedBox(height: 10),
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text(
                    "Cancel",
                    style: TextStyle(color: Colors.black),
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
    final displayedSections = _getDisplayedSections();

    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(
        title: const Text(
          "Explore Services",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: const BackButton(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
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
                          blurRadius: 6,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: TextField(
                      controller: _searchController,
                      onChanged: (value) => setState(() => _searchQuery = value),
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Iconsax.search_normal, color: Colors.grey),
                        hintText: "Search services...",
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(vertical: 14),
                        suffixIcon: _searchController.text.isNotEmpty
                            ? IconButton(
                          icon: const Icon(Iconsax.close_circle),
                          onPressed: () {
                            _searchController.clear();
                            setState(() => _searchQuery = '');
                          },
                        )
                            : null,
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
                        blurRadius: 6,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: IconButton(
                    icon: Icon(
                      Iconsax.filter,
                      color: _selectedCategory == 'All Categories' ? Colors.grey : Colors.green,
                    ),
                    onPressed: _showFilterDialog,
                    padding: const EdgeInsets.all(12),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: displayedSections.length,
                itemBuilder: (context, index) => _buildServiceCard(displayedSections[index]),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<ServiceCategory> _getDisplayedSections() {
    List<ServiceCategory> sections = List.from(_allSections);

    if (_selectedCategory != 'All Categories') {
      sections = sections.where((section) => section.title == _selectedCategory).toList();
    }

    if (_searchQuery.isNotEmpty) {
      sections = sections
          .map((section) {
        final filteredServices = section.services
            .where((s) => s.toLowerCase().contains(_searchQuery.toLowerCase()))
            .toList();
        return ServiceCategory(
          title: section.title,
          services: filteredServices,
          buttonLabel: section.buttonLabel,
          icon: section.icon,
        );
      })
          .where((section) => section.services.isNotEmpty)
          .toList();
    }

    return sections;
  }

  Widget _buildServiceCard(ServiceCategory section) {
    return Container(
      margin: const EdgeInsets.only(bottom: 18),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(section.icon, color: Colors.green, size: 28),
              const SizedBox(width: 12),
              Text(
                section.title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ...section.services.map((s) => Padding(
            padding: const EdgeInsets.only(bottom: 6),
            child: Row(
              children: [
                const Icon(Iconsax.tick_circle, color: Colors.green, size: 18),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    s,
                    style: const TextStyle(fontSize: 14.5, color: Colors.black87),
                  ),
                ),
              ],
            ),
          )),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                if (section.title == "Savings & Investments") {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const SavingsAndInvestmentPage()),
                  );
                } else if (section.title == "Loan Products") {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) =>  RegistrationForm()),
                  );
                  Navigator.pushNamed(context, '/loan_products');
                } else if (section.title == "Insurance") {
                 Navigator.push(context,
                 MaterialPageRoute(builder: (context) => const InsurancePage()),
                  );
                  Navigator.pushNamed(context, '/insurance');
                } else if (section.title == "Cooperative Member Benefits") {
                 Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const CooperativeMemberBenefitsPage()),
                  );
                  Navigator.pushNamed(context, '/member_benefits');
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("${section.buttonLabel} tapped"),
                      backgroundColor: Colors.green,
                    ),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text(section.buttonLabel, style: const TextStyle(color: Colors.white)),
            ),
          ),
        ],
      ),
    );
  }
}

class ServiceCategory {
  final IconData icon;
  final String title;
  final List<String> services;
  final String buttonLabel;

  ServiceCategory({
    required this.icon,
    required this.title,
    required this.services,
    required this.buttonLabel,
  });
}

import 'package:flutter/material.dart';
import 'online_application_step3.dart';
import 'package:iconsax/iconsax.dart';

class JobInformationForm extends StatefulWidget {
  const JobInformationForm({super.key});

  @override
  State<JobInformationForm> createState() => _JobInformationFormState();
}

class _JobInformationFormState extends State<JobInformationForm> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController jobTitleController = TextEditingController();
  final TextEditingController employerController = TextEditingController();
  final TextEditingController salaryController = TextEditingController();
  final TextEditingController incomeDescriptionController =
      TextEditingController();

  String? selectedEmploymentType;
  String? selectedSalaryFrequency;

  List<String> employmentTypes = ['Full-time', 'Part-time', 'Freelancer'];
  List<String> salaryFrequencies = ['Monthly', 'Bi-weekly', 'Weekly'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF1F5F9),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF1F5F9),
        elevation: 0,
        leading: const BackButton(color: Colors.black),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: Center(
              child: Text("Step 2 of 5",
                  style: TextStyle(color: Colors.black, fontSize: 14)),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                const LinearProgressIndicator(
                  value: 0.4,
                  color: Colors.green,
                  backgroundColor: Colors.grey,
                ),
                const SizedBox(height: 20),
                const Text(
                  "Job Information",
                  style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  "Please provide details about your current job and proof of income.",
                  style: TextStyle(
                      fontSize: 14, color: Colors.grey, fontFamily: 'Poppins'),
                ),
                const SizedBox(height: 30),
                _buildLabel("Job Title"),
                _buildInput(
                  controller: jobTitleController,
                  hint: "Enter your job title",
                ),
                const SizedBox(height: 20),
                _buildLabel("Employer Name"),
                _buildInput(
                  controller: employerController,
                  hint: "Enter your employer's name",
                ),
                const SizedBox(height: 20),
                _buildLabel("Employment Type"),
                _buildDropdown(
                  value: selectedEmploymentType,
                  items: employmentTypes,
                  onChanged: (value) =>
                      setState(() => selectedEmploymentType = value),
                  hint: 'Select employment type',
                ),
                const SizedBox(height: 20),
                _buildLabel("Salary"),
                _buildInput(
                  controller: salaryController,
                  hint: "Enter your salary",
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 20),
                _buildLabel("Salary Frequency"),
                _buildDropdown(
                  value: selectedSalaryFrequency,
                  items: salaryFrequencies,
                  onChanged: (value) =>
                      setState(() => selectedSalaryFrequency = value),
                  hint: 'Select salary frequency',
                ),
                const SizedBox(height: 20),
                _buildLabel("Proof of Income (Text Description)"),
                _buildInput(
                  controller: incomeDescriptionController,
                  hint: "Describe your proof of income",
                ),
                const SizedBox(height: 30),
                SizedBox(
                  width: double.infinity,
                  child:  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size.fromHeight(50),
                      backgroundColor: Colors.green,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        PageRouteBuilder(
                          transitionDuration: const Duration(milliseconds: 800),
                          pageBuilder: (context, animation, _) =>
                          const EmergencyContactsPage(),
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
                    icon: const Icon(Iconsax.arrow_right_2, color: Colors.white),
                    label: const Text(
                      "Continue",
                      style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Text(
      text,
      style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
    );
  }

  Widget _buildInput({
    required TextEditingController controller,
    required String hint,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.grey),
        filled: true,
        fillColor: Colors.white,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.grey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.green, width: 1.5),
        ),
      ),
    );
  }

  Widget _buildDropdown({
    required String? value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
    required String hint,
  }) {
    return DropdownButtonFormField<String>(
      value: value,
      onChanged: onChanged,
      items: items
          .map((item) => DropdownMenuItem(value: item, child: Text(item)))
          .toList(),
      decoration: InputDecoration(
        hintText: hint,
        filled: true,
        fillColor: Colors.white,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.grey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.green, width: 1.5),
        ),
      ),
    );
  }
}

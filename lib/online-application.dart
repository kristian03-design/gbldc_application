// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'online_application_step2.dart';
import 'package:intl/intl.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:iconsax/iconsax.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: RegistrationForm(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class RegistrationForm extends StatefulWidget {
  const RegistrationForm({super.key});

  @override
  State<RegistrationForm> createState() => RegistrationFormState();
}

class RegistrationFormState extends State<RegistrationForm> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController dobController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController birthPlaceController = TextEditingController();
  final TextEditingController provinceController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController barangayController = TextEditingController();
  final TextEditingController yearsOfStayController = TextEditingController();

  String? selectedSalutation;
  String? selectedGender;
  String? selectedCivilStatus;
  String? selectedReligion;
  String? selectedNationality;

  final List<String> religions = [
    'Roman Catholic',
    'Islam',
    'Iglesia ni Cristo',
    'Evangelical',
    'Buddhism',
    'Hinduism',
    'Other'
  ];

  final List<String> nationalities = ['Filipino', 'American', 'Other'];

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime(1995, 12, 27),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        dobController.text = DateFormat('dd-MM-yyyy').format(picked);
      });
    }
  }

  Future<void> _getCurrentLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Location services are disabled.')),
      );
      return;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Location permission denied.')),
        );
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Location permissions are permanently denied.')),
      );
      return;
    }

    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      if (placemarks.isNotEmpty) {
        Placemark place = placemarks.first;

        String fullAddress = [
          place.street,
          place.subLocality,
          place.locality,
          place.administrativeArea,
          place.country
        ].where((e) => e != null && e.isNotEmpty).join(', ');

        setState(() {
          addressController.text = fullAddress; // Fill with full address
          barangayController.text = place.subLocality ?? '';
          cityController.text = place.locality ?? '';
          provinceController.text = place.administrativeArea ?? '';
        });

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Location filled successfully!')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to get address: $e')),
      );
    }
  }

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
              child: Text("Step 1 of 5",
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
                  value: 0.2,
                  color: Colors.green,
                  backgroundColor: Colors.grey,
                ),
                const SizedBox(height: 25),
                const Text(
                  "Personal Information",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 6),
                const Text(
                  "Tell us a bit about yourself. Don’t worry, your data is secure.",
                  style: TextStyle(color: Colors.black54, fontSize: 13),
                ),
                const SizedBox(height: 30),

                // Example improved layout
                _buildLabel("Salutation"),
                _buildDropdown(
                  value: selectedSalutation,
                  items: ['Mr.', 'Ms.', 'Mrs.', 'Dr.'],
                  onChanged: (value) =>
                      setState(() => selectedSalutation = value),
                  hint: 'Select salutation',
                ),

                const SizedBox(height: 16),
                _buildLabel("Full Name"),
                _buildInput(
                    controller: fullNameController, hint: "Enter full name"),

                const SizedBox(height: 16),
                _buildLabel("Gender"),
                _buildDropdown(
                  value: selectedGender,
                  items: ['Male', 'Female', 'Other'],
                  onChanged: (value) => setState(() => selectedGender = value),
                  hint: 'Select gender',
                ),

                const SizedBox(height: 16),
                _buildLabel("Civil Status"),
                _buildDropdown(
                  value: selectedCivilStatus,
                  items: ['Single', 'Married', 'Divorced', 'Widowed'],
                  onChanged: (value) =>
                      setState(() => selectedCivilStatus = value),
                  hint: 'Select civil status',
                ),

                const SizedBox(height: 16),
                _buildLabel("Date of Birth"),
                GestureDetector(
                  onTap: () => _selectDate(context),
                  child: AbsorbPointer(
                    child: _buildInput(
                      controller: dobController,
                      hint: "DD-MM-YYYY",
                      suffixIcon: Icons.calendar_today,
                    ),
                  ),
                ),

                const SizedBox(height: 16),
                _buildLabel("Place of Birth"),
                _buildInput(
                    controller: birthPlaceController,
                    hint: "Enter place of birth"),

                const SizedBox(height: 16),
                _buildLabel("Email Address"),
                _buildInput(
                    controller: emailController, hint: "Enter email address"),

                const SizedBox(height: 16),
                _buildLabel("Phone Number"),
                IntlPhoneField(
                  decoration: InputDecoration(
                    labelText: 'Phone Number',
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide:
                          const BorderSide(color: Colors.green, width: 1.5),
                    ),
                  ),
                  initialCountryCode: 'PH',
                  onChanged: (phone) =>
                      phoneController.text = phone.completeNumber,
                  onSaved: (phone) =>
                      phoneController.text = phone!.completeNumber,
                ),

                const SizedBox(height: 16),
                _buildLabel("Religion"),
                _buildDropdown(
                  value: selectedReligion,
                  items: religions,
                  onChanged: (value) =>
                      setState(() => selectedReligion = value),
                  hint: 'Select your religion',
                ),

                const SizedBox(height: 16),
                _buildLabel("Nationality"),
                _buildDropdown(
                  value: selectedNationality,
                  items: nationalities,
                  onChanged: (value) =>
                      setState(() => selectedNationality = value),
                  hint: 'Select your nationality',
                ),

                const SizedBox(height: 16),
                _buildLabel("Home Address"),
                _buildInput(
                    controller: addressController, hint: "Enter address"),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton.icon(
                    onPressed: _getCurrentLocation,
                    icon: const Icon(Iconsax.location, color: Colors.green),
                    label: const Text(
                      "Use Current Location",
                      style: TextStyle(color: Colors.green)),
                    ),
                  ),

                const SizedBox(height: 16),
                _buildLabel("Province"),
                _buildInput(
                    controller: provinceController, hint: "Enter province"),

                const SizedBox(height: 16),
                _buildLabel("City"),
                _buildInput(controller: cityController, hint: "Enter city"),

                const SizedBox(height: 16),
                _buildLabel("Barangay"),
                _buildInput(
                    controller: barangayController, hint: "Enter barangay"),

                const SizedBox(height: 16),
                _buildLabel("Years of Stay"),
                _buildInput(
                    controller: yearsOfStayController,
                    hint: "Enter years of stay"),

                const SizedBox(height: 30),
                ElevatedButton.icon(
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
                        const JobInformationForm(),
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
                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Text(
        text,
        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
      ),
    );
  }

  Widget _buildInput({
    required TextEditingController controller,
    required String hint,
    String? prefixText,
    IconData? suffixIcon,
  }) {
    return TextFormField(
      controller: controller,
      style: const TextStyle(fontSize: 14),
      decoration: InputDecoration(
        hintText: hint,
        prefixText: prefixText,
        suffixIcon: suffixIcon != null
            ? Icon(suffixIcon, size: 18, color: Colors.grey)
            : null,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
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
      ),
    );
  }
}


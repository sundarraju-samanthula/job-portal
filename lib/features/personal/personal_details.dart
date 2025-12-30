// // import 'package:flutter/material.dart';
// // import 'package:get/get.dart';
// // import 'package:firebase_auth/firebase_auth.dart';
// // import 'package:cloud_firestore/cloud_firestore.dart';

// // class PersonalDetailsScreen extends StatefulWidget {
// //   const PersonalDetailsScreen({super.key});

// //   @override
// //   State<PersonalDetailsScreen> createState() => _PersonalDetailsScreenState();
// // }

// // class _PersonalDetailsScreenState extends State<PersonalDetailsScreen> {
// //   final _formKey = GlobalKey<FormState>();

// //   final nameCtrl = TextEditingController();
// //   final phoneCtrl = TextEditingController();

// //   bool isSaving = false;

// //   @override
// //   Widget build(BuildContext context) {
// //     final user = FirebaseAuth.instance.currentUser!;

// //     return Scaffold(
// //       appBar: AppBar(
// //         title: const Text('Complete Your Profile'),
// //         automaticallyImplyLeading: false, // 🚫 prevent back
// //       ),
// //       body: Padding(
// //         padding: const EdgeInsets.all(20),
// //         child: Form(
// //           key: _formKey,
// //           child: Column(
// //             children: [
// //               TextFormField(
// //                 controller: nameCtrl,
// //                 decoration: const InputDecoration(labelText: 'Full Name'),
// //                 validator: (v) => v == null || v.isEmpty ? 'Required' : null,
// //               ),
// //               const SizedBox(height: 16),

// //               TextFormField(
// //                 initialValue: user.email,
// //                 readOnly: true,
// //                 decoration: const InputDecoration(labelText: 'Email'),
// //               ),
// //               const SizedBox(height: 16),

// //               TextFormField(
// //                 controller: phoneCtrl,
// //                 keyboardType: TextInputType.phone,
// //                 decoration: const InputDecoration(labelText: 'Phone Number'),
// //                 validator: (v) =>
// //                     v == null || v.length < 10 ? 'Invalid phone' : null,
// //               ),

// //               const Spacer(),

// //               SizedBox(
// //                 width: double.infinity,
// //                 height: 50,
// //                 child: ElevatedButton(
// //                   onPressed: isSaving ? null : _saveProfile,
// //                   child: isSaving
// //                       ? const CircularProgressIndicator()
// //                       : const Text('Continue'),
// //                 ),
// //               ),
// //             ],
// //           ),
// //         ),
// //       ),
// //     );
// //   }

// //   Future<void> _saveProfile() async {
// //     if (!_formKey.currentState!.validate()) return;

// //     setState(() => isSaving = true);

// //     final user = FirebaseAuth.instance.currentUser!;

// //     await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
// //       'uid': user.uid,
// //       'name': nameCtrl.text.trim(),
// //       'email': user.email,
// //       'phone': phoneCtrl.text.trim(),
// //       'role': 'job_seeker',
// //       'profileCompleted': true,
// //       'createdAt': FieldValue.serverTimestamp(),
// //     });

// //     Get.offAllNamed('/home');
// //   }
// // }
// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:get/get.dart';

// class PersonalDetailsScreen extends StatefulWidget {
//   const PersonalDetailsScreen({super.key});

//   @override
//   State<PersonalDetailsScreen> createState() => _PersonalDetailsScreenState();
// }

// class _PersonalDetailsScreenState extends State<PersonalDetailsScreen> {
//   final _formKey = GlobalKey<FormState>();

//   // Controllers
//   final fullNameCtrl = TextEditingController();
//   final ageCtrl = TextEditingController();
//   final phoneCtrl = TextEditingController();
//   final addressCtrl = TextEditingController();
//   final roleCtrl = TextEditingController();
//   final salaryCtrl = TextEditingController();

//   // Selections
//   String gender = '';
//   String educationQualification = '';
//   String experienceType = 'fresher';
//   String experienceYears = '';
//   String selectedState = '';
//   String selectedDistrict = '';

//   bool isLoading = false;

//   // Sample India data (extend anytime)
//   final Map<String, List<String>> indiaData = {
//     'Tamil Nadu': ['Chennai', 'Coimbatore', 'Madurai'],
//     'Karnataka': ['Bangalore', 'Mysore', 'Mangalore'],
//     'Kerala': ['Kochi', 'Trivandrum', 'Calicut'],
//   };

//   @override
//   Widget build(BuildContext context) {
//     final user = FirebaseAuth.instance.currentUser!;

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Complete Profile'),
//         automaticallyImplyLeading: false,
//       ),
//       body: SafeArea(
//         child: Form(
//           key: _formKey,
//           child: SingleChildScrollView(
//             padding: const EdgeInsets.all(16),
//             child: Column(
//               children: [
//                 /// =======================
//                 /// 1️⃣ PERSONAL DETAILS
//                 /// =======================
//                 _block(
//                   title: 'Personal Details',
//                   child: Column(
//                     children: [
//                       _textField(fullNameCtrl, 'Full Name'),
//                       _readOnlyField(user.email ?? '', 'Email'),
//                       _textField(
//                         ageCtrl,
//                         'Age',
//                         keyboardType: TextInputType.number,
//                       ),
//                       _textField(
//                         phoneCtrl,
//                         'Phone Number',
//                         keyboardType: TextInputType.phone,
//                       ),
//                       _choiceChips(
//                         title: 'Gender',
//                         options: ['Male', 'Female', 'Other'],
//                         selected: gender,
//                         onSelect: (v) => setState(() => gender = v),
//                       ),
//                       _textField(addressCtrl, 'Address'),
//                     ],
//                   ),
//                 ),

//                 /// =======================
//                 /// 2️⃣ EDUCATION & EXPERIENCE
//                 /// =======================
//                 _block(
//                   title: 'Education & Experience',
//                   child: Column(
//                     children: [
//                       _choiceChips(
//                         title: 'Highest Qualification',
//                         options: [
//                           '10th',
//                           'Inter',
//                           'ITI',
//                           'Diploma',
//                           'Graduate',
//                           'Post Graduate',
//                         ],
//                         selected: educationQualification,
//                         onSelect: (v) =>
//                             setState(() => educationQualification = v),
//                       ),

//                       _choiceChips(
//                         title: 'Experience',
//                         options: ['Fresher', 'Experienced'],
//                         selected: experienceType,
//                         onSelect: (v) =>
//                             setState(() => experienceType = v.toLowerCase()),
//                       ),

//                       if (experienceType == 'experienced') ...[
//                         _choiceChips(
//                           title: 'Years of Experience',
//                           options: ['0-1', '1-3', '3+'],
//                           selected: experienceYears,
//                           onSelect: (v) => setState(() => experienceYears = v),
//                         ),
//                         _textField(roleCtrl, 'Previous Role'),
//                         _textField(
//                           salaryCtrl,
//                           'Previous Salary',
//                           keyboardType: TextInputType.number,
//                         ),
//                       ],
//                     ],
//                   ),
//                 ),

//                 /// =======================
//                 /// 3️⃣ LOCATION
//                 /// =======================
//                 _block(
//                   title: 'Location',
//                   child: Column(
//                     children: [
//                       _dropdown(
//                         hint: 'Select State',
//                         value: selectedState.isEmpty ? null : selectedState,
//                         items: indiaData.keys.toList(),
//                         onChanged: (v) {
//                           setState(() {
//                             selectedState = v!;
//                             selectedDistrict = '';
//                           });
//                         },
//                       ),
//                       if (selectedState.isNotEmpty)
//                         _dropdown(
//                           hint: 'Select District',
//                           value: selectedDistrict.isEmpty
//                               ? null
//                               : selectedDistrict,
//                           items: indiaData[selectedState]!,
//                           onChanged: (v) =>
//                               setState(() => selectedDistrict = v!),
//                         ),
//                     ],
//                   ),
//                 ),

//                 const SizedBox(height: 20),

//                 /// CONTINUE BUTTON
//                 SizedBox(
//                   width: double.infinity,
//                   height: 52,
//                   child: ElevatedButton(
//                     onPressed: isLoading ? null : _saveProfile,
//                     child: isLoading
//                         ? const CircularProgressIndicator(color: Colors.white)
//                         : const Text('Continue'),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   /// =======================
//   /// SAVE TO FIRESTORE
//   /// =======================
//   Future<void> _saveProfile() async {
//     if (!_formKey.currentState!.validate()) return;

//     if (gender.isEmpty ||
//         educationQualification.isEmpty ||
//         selectedState.isEmpty ||
//         selectedDistrict.isEmpty) {
//       Get.snackbar('Missing Info', 'Please complete all required fields');
//       return;
//     }

//     if (experienceType == 'experienced' &&
//         (experienceYears.isEmpty ||
//             roleCtrl.text.isEmpty ||
//             salaryCtrl.text.isEmpty)) {
//       Get.snackbar(
//         'Missing Experience Info',
//         'Please complete experience details',
//       );
//       return;
//     }

//     setState(() => isLoading = true);

//     final user = FirebaseAuth.instance.currentUser!;

//     final Map<String, dynamic> userData = {
//       'fullName': fullNameCtrl.text.trim(),
//       'email': user.email,
//       'age': int.parse(ageCtrl.text.trim()),
//       'phone': phoneCtrl.text.trim(),
//       'gender': gender,
//       'address': addressCtrl.text.trim(),
//       'educationQualification': educationQualification,
//       'experienceType': experienceType,
//       'state': selectedState,
//       'district': selectedDistrict,
//       'profileCompleted': true,
//       'createdAt': FieldValue.serverTimestamp(),
//     };

//     if (experienceType == 'experienced') {
//       userData['experienceDetails'] = {
//         'years': experienceYears,
//         'role': roleCtrl.text.trim(),
//         'salary': salaryCtrl.text.trim(),
//       };
//     } else {
//       userData['experienceDetails'] = null;
//     }

//     await FirebaseFirestore.instance
//         .collection('users')
//         .doc(user.uid)
//         .set(userData, SetOptions(merge: true));

//     Get.offAllNamed('/home');
//   }

//   /// =======================
//   /// UI HELPERS
//   /// =======================
//   Widget _block({required String title, required Widget child}) {
//     return Container(
//       margin: const EdgeInsets.only(bottom: 16),
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(14),
//         boxShadow: const [
//           BoxShadow(
//             color: Colors.black12,
//             blurRadius: 10,
//             offset: Offset(0, 6),
//           ),
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             title,
//             style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
//           ),
//           const SizedBox(height: 12),
//           child,
//         ],
//       ),
//     );
//   }

//   Widget _textField(
//     TextEditingController controller,
//     String label, {
//     TextInputType keyboardType = TextInputType.text,
//   }) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 12),
//       child: TextFormField(
//         controller: controller,
//         keyboardType: keyboardType,
//         validator: (v) => v == null || v.isEmpty ? 'Required field' : null,
//         decoration: InputDecoration(labelText: label),
//       ),
//     );
//   }

//   Widget _readOnlyField(String value, String label) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 12),
//       child: TextFormField(
//         initialValue: value,
//         readOnly: true,
//         decoration: InputDecoration(labelText: label),
//       ),
//     );
//   }

//   Widget _choiceChips({
//     required String title,
//     required List<String> options,
//     required String selected,
//     required Function(String) onSelect,
//   }) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           title,
//           style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
//         ),
//         const SizedBox(height: 8),
//         Wrap(
//           spacing: 8,
//           children: options
//               .map(
//                 (e) => ChoiceChip(
//                   label: Text(e),
//                   selected: selected == e,
//                   onSelected: (_) => onSelect(e),
//                 ),
//               )
//               .toList(),
//         ),
//         const SizedBox(height: 12),
//       ],
//     );
//   }

//   Widget _dropdown({
//     required String hint,
//     required List<String> items,
//     required ValueChanged<String?> onChanged,
//     String? value,
//   }) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 12),
//       child: DropdownButtonFormField<String>(
//         value: value,
//         hint: Text(hint),
//         items: items
//             .map((e) => DropdownMenuItem(value: e, child: Text(e)))
//             .toList(),
//         onChanged: onChanged,
//         validator: (v) => v == null ? 'Required field' : null,
//       ),
//     );
//   }
// }
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class PersonalDetailsScreen extends StatefulWidget {
  const PersonalDetailsScreen({super.key});

  @override
  State<PersonalDetailsScreen> createState() => _PersonalDetailsScreenState();
}

class _PersonalDetailsScreenState extends State<PersonalDetailsScreen>
    with TickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();

  /// Controllers
  final fullNameCtrl = TextEditingController();
  final ageCtrl = TextEditingController();
  final phoneCtrl = TextEditingController();
  final addressCtrl = TextEditingController();
  final roleCtrl = TextEditingController();
  final salaryCtrl = TextEditingController();

  /// State
  int step = 0;
  bool isLoading = false;

  /// Selections
  String gender = '';
  String educationQualification = '';
  String experienceType = 'fresher';
  String experienceYears = '';
  String selectedState = '';
  String selectedDistrict = '';

  final Map<String, List<String>> indiaData = {
    'Tamil Nadu': ['Chennai', 'Coimbatore', 'Madurai'],
    'Karnataka': ['Bangalore', 'Mysore', 'Mangalore'],
    'Kerala': ['Kochi', 'Trivandrum', 'Calicut'],
  };

  void nextStep() {
    if (step < 2) {
      setState(() => step++);
    } else {
      _saveProfile();
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF020617), Color(0xFF0F172A), Color(0xFF020617)],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 20),

              /// HEADER
              Text(
                'Complete Your Profile',
                style: GoogleFonts.inter(
                  fontSize: 26,
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                ),
              ),

              const SizedBox(height: 6),

              Text(
                'Step ${step + 1} of 3',
                style: GoogleFonts.inter(color: Colors.white70),
              ),

              const SizedBox(height: 24),

              /// ANIMATED BLOCK
              Expanded(
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 700),
                  transitionBuilder: (child, animation) {
                    return SlideTransition(
                      position: Tween(
                        begin: const Offset(0.3, 0),
                        end: Offset.zero,
                      ).animate(animation),
                      child: FadeTransition(opacity: animation, child: child),
                    );
                  },
                  child: _buildStep(user),
                ),
              ),

              /// BUTTON
              Padding(
                padding: const EdgeInsets.all(20),
                child: _PremiumButton(
                  text: step == 2 ? 'Continue' : 'Next',
                  isLoading: isLoading,
                  onTap: nextStep,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// =======================
  /// STEP CONTENT
  /// =======================
  Widget _buildStep(User user) {
    switch (step) {
      case 0:
        return _GlassCard(
          key: const ValueKey(0),
          title: 'Personal Details',
          child: ListView(
            children: [
              _glassInput(fullNameCtrl, 'Full Name'),
              _readOnly(user.email ?? '', 'Email'),
              _glassInput(ageCtrl, 'Age', type: TextInputType.number),
              _glassInput(phoneCtrl, 'Phone Number', type: TextInputType.phone),
              _choice(
                'Gender',
                ['Male', 'Female', 'Other'],
                gender,
                (v) => setState(() => gender = v),
              ),
              _glassInput(addressCtrl, 'Address'),
            ],
          ),
        );

      case 1:
        return _GlassCard(
          key: const ValueKey(1),
          title: 'Education & Experience',
          child: ListView(
            children: [
              _choice(
                'Highest Qualification',
                [
                  '10th',
                  'Inter',
                  'ITI',
                  'Diploma',
                  'Graduate',
                  'Post Graduate',
                ],
                educationQualification,
                (v) => setState(() => educationQualification = v),
              ),
              _choice(
                'Experience',
                ['Fresher', 'Experienced'],
                experienceType,
                (v) => setState(() => experienceType = v.toLowerCase()),
              ),
              if (experienceType == 'experienced') ...[
                _choice(
                  'Years of Experience',
                  ['0-1', '1-3', '3+'],
                  experienceYears,
                  (v) => setState(() => experienceYears = v),
                ),
                _glassInput(roleCtrl, 'Previous Role'),
                _glassInput(
                  salaryCtrl,
                  'Previous Salary',
                  type: TextInputType.number,
                ),
              ],
            ],
          ),
        );

      default:
        return _GlassCard(
          key: const ValueKey(2),
          title: 'Location',
          child: ListView(
            children: [
              _dropdown(
                'Select State',
                indiaData.keys.toList(),
                selectedState,
                (v) => setState(() {
                  selectedState = v!;
                  selectedDistrict = '';
                }),
              ),
              if (selectedState.isNotEmpty)
                _dropdown(
                  'Select District',
                  indiaData[selectedState]!,
                  selectedDistrict,
                  (v) => setState(() => selectedDistrict = v!),
                ),
            ],
          ),
        );
    }
  }

  /// =======================
  /// SAVE TO FIRESTORE
  /// =======================
  Future<void> _saveProfile() async {
    if (gender.isEmpty ||
        educationQualification.isEmpty ||
        selectedState.isEmpty ||
        selectedDistrict.isEmpty) {
      Get.snackbar('Missing Info', 'Please complete all fields');
      return;
    }

    setState(() => isLoading = true);

    final user = FirebaseAuth.instance.currentUser!;

    final data = {
      'fullName': fullNameCtrl.text.trim(),
      'email': user.email,
      'age': ageCtrl.text.trim(),
      'phone': phoneCtrl.text.trim(),
      'gender': gender,
      'address': addressCtrl.text.trim(),
      'educationQualification': educationQualification,
      'experienceType': experienceType,
      'experienceDetails': experienceType == 'experienced'
          ? {
              'years': experienceYears,
              'role': roleCtrl.text.trim(),
              'salary': salaryCtrl.text.trim(),
            }
          : null,
      'state': selectedState,
      'district': selectedDistrict,
      'profileCompleted': true,
      'createdAt': FieldValue.serverTimestamp(),
    };

    await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .set(data, SetOptions(merge: true));

    Get.offAllNamed('/home');
  }

  /// =======================
  /// UI COMPONENTS
  /// =======================

  Widget _GlassCard({required String title, required Widget child, Key? key}) {
    return Padding(
      key: key,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(28),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.08),
              borderRadius: BorderRadius.circular(28),
              border: Border.all(color: Colors.white.withOpacity(0.15)),
              boxShadow: [
                BoxShadow(
                  color: Colors.blueAccent.withOpacity(0.25),
                  blurRadius: 30,
                ),
              ],
            ),
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 16),
                Expanded(child: child),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _glassInput(
    TextEditingController ctrl,
    String label, {
    TextInputType type = TextInputType.text,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: TextField(
        controller: ctrl,
        keyboardType: type,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(color: Colors.white70),
          filled: true,
          fillColor: Colors.white.withOpacity(0.08),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }

  Widget _readOnly(String value, String label) {
    return _glassInput(TextEditingController(text: value), label);
  }

  Widget _choice(
    String title,
    List<String> options,
    String selected,
    Function(String) onTap,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.inter(
            color: Colors.white70,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 10,
          children: options.map((e) {
            final active = selected == e;
            return GestureDetector(
              onTap: () => onTap(e),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14),
                  color: active
                      ? Colors.blueAccent
                      : Colors.white.withOpacity(0.08),
                  boxShadow: active
                      ? [
                          BoxShadow(
                            color: Colors.blueAccent.withOpacity(0.6),
                            blurRadius: 16,
                          ),
                        ]
                      : [],
                ),
                child: Text(
                  e,
                  style: TextStyle(
                    color: active ? Colors.white : Colors.white70,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
        const SizedBox(height: 14),
      ],
    );
  }

  Widget _dropdown(
    String hint,
    List<String> items,
    String value,
    ValueChanged<String?> onChanged,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: DropdownButtonFormField<String>(
        value: value.isEmpty ? null : value,
        hint: Text(hint),
        items: items
            .map((e) => DropdownMenuItem(value: e, child: Text(e)))
            .toList(),
        onChanged: onChanged,
      ),
    );
  }
}

/// =======================
/// PREMIUM BUTTON
/// =======================
class _PremiumButton extends StatelessWidget {
  final String text;
  final bool isLoading;
  final VoidCallback onTap;

  const _PremiumButton({
    required this.text,
    required this.onTap,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isLoading ? null : onTap,
      child: Container(
        height: 56,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: const LinearGradient(
            colors: [Color(0xFF2563EB), Color(0xFF38BDF8), Color(0xFF6366F1)],
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.blueAccent.withOpacity(0.6),
              blurRadius: 24,
            ),
          ],
        ),
        child: Center(
          child: isLoading
              ? const CircularProgressIndicator(color: Colors.white)
              : Text(
                  text,
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
        ),
      ),
    );
  }
}

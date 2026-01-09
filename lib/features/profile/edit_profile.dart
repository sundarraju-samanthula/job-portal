// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:get/get.dart';

// class EditProfileScreen extends StatefulWidget {
//   final String uid;
//   final Map<String, dynamic> initialData;

//   const EditProfileScreen({
//     super.key,
//     required this.uid,
//     required this.initialData,
//   });

//   @override
//   State<EditProfileScreen> createState() => _EditProfileScreenState();
// }

// class _EditProfileScreenState extends State<EditProfileScreen> {
//   final _formKey = GlobalKey<FormState>();

//   late TextEditingController fullName;
//   late TextEditingController phone;
//   late TextEditingController age;
//   late TextEditingController address;
//   late TextEditingController qualification;
//   late TextEditingController state;
//   late TextEditingController district;

//   bool saving = false;

//   @override
//   void initState() {
//     super.initState();

//     fullName = TextEditingController(text: widget.initialData['fullName']);
//     phone = TextEditingController(text: widget.initialData['phone']);
//     age = TextEditingController(text: widget.initialData['age']?.toString());
//     address = TextEditingController(text: widget.initialData['address']);
//     qualification = TextEditingController(
//       text: widget.initialData['educationQualification'],
//     );
//     state = TextEditingController(text: widget.initialData['state']);
//     district = TextEditingController(text: widget.initialData['district']);
//   }

//   @override
//   void dispose() {
//     fullName.dispose();
//     phone.dispose();
//     age.dispose();
//     address.dispose();
//     qualification.dispose();
//     state.dispose();
//     district.dispose();
//     super.dispose();
//   }

//   Future<void> _saveProfile() async {
//     if (!_formKey.currentState!.validate()) return;

//     setState(() => saving = true);

//     await FirebaseFirestore.instance
//         .collection('users')
//         .doc(widget.uid)
//         .update({
//           'fullName': fullName.text.trim(),
//           'phone': phone.text.trim(),
//           'age': int.tryParse(age.text.trim()),
//           'address': address.text.trim(),
//           'educationQualification': qualification.text.trim(),
//           'state': state.text.trim(),
//           'district': district.text.trim(),
//           'updatedAt': FieldValue.serverTimestamp(),
//         });

//     setState(() => saving = false);
//     Get.back(); // return to profile
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Edit Profile'), centerTitle: true),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(22),
//         child: Form(
//           key: _formKey,
//           child: Column(
//             children: [
//               _field(fullName, 'Full Name'),
//               _field(phone, 'Phone', keyboard: TextInputType.phone),
//               _field(age, 'Age', keyboard: TextInputType.number),
//               _field(address, 'Address'),
//               _field(qualification, 'Qualification'),
//               _field(state, 'State'),
//               _field(district, 'District'),

//               const SizedBox(height: 30),

//               SizedBox(
//                 width: double.infinity,
//                 height: 50,
//                 child: ElevatedButton(
//                   onPressed: saving ? null : _saveProfile,
//                   style: ElevatedButton.styleFrom(
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(16),
//                     ),
//                   ),
//                   child: saving
//                       ? const CircularProgressIndicator(color: Colors.white)
//                       : const Text(
//                           'Save Changes',
//                           style: TextStyle(
//                             fontSize: 16,
//                             fontWeight: FontWeight.w800,
//                           ),
//                         ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _field(
//     TextEditingController controller,
//     String label, {
//     TextInputType keyboard = TextInputType.text,
//   }) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 18),
//       child: TextFormField(
//         controller: controller,
//         keyboardType: keyboard,
//         validator: (v) => v == null || v.isEmpty ? 'Required' : null,
//         decoration: InputDecoration(
//           labelText: label,
//           border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class EditProfileScreen extends StatefulWidget {
  final String uid;
  final Map<String, dynamic> initialData;

  const EditProfileScreen({
    super.key,
    required this.uid,
    required this.initialData,
  });

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController fullNameCtrl;
  late TextEditingController phoneCtrl;
  late TextEditingController ageCtrl;
  late TextEditingController addressCtrl;
  late TextEditingController qualificationCtrl;
  late TextEditingController stateCtrl;
  late TextEditingController districtCtrl;

  String gender = 'Male';
  String experienceType = 'fresher';
  bool isSaving = false;

  @override
  void initState() {
    super.initState();

    final d = widget.initialData;

    fullNameCtrl = TextEditingController(text: d['fullName'] ?? '');
    phoneCtrl = TextEditingController(text: d['phone'] ?? '');
    ageCtrl = TextEditingController(text: d['age']?.toString() ?? '');
    addressCtrl = TextEditingController(text: d['address'] ?? '');
    qualificationCtrl = TextEditingController(
      text: d['educationQualification'] ?? '',
    );
    stateCtrl = TextEditingController(text: d['state'] ?? '');
    districtCtrl = TextEditingController(text: d['district'] ?? '');

    gender = d['gender'] ?? 'Male';
    experienceType = d['experienceType'] ?? 'fresher';
  }

  /// 🔢 PROFILE COMPLETION CALC
  int _calculateCompletion(Map<String, dynamic> data) {
    const fields = [
      'fullName',
      'phone',
      'gender',
      'age',
      'address',
      'educationQualification',
      'experienceType',
      'state',
      'district',
      'photoUrl',
    ];

    int filled = 0;
    for (final f in fields) {
      if (data[f] != null && data[f].toString().isNotEmpty) {
        filled++;
      }
    }

    return ((filled / fields.length) * 100).round();
  }

  Future<void> _saveProfile() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => isSaving = true);

    final payload = {
      'fullName': fullNameCtrl.text.trim(),
      'phone': phoneCtrl.text.trim(),
      'gender': gender,
      'age': int.tryParse(ageCtrl.text.trim()),
      'address': addressCtrl.text.trim(),
      'educationQualification': qualificationCtrl.text.trim(),
      'experienceType': experienceType,
      'state': stateCtrl.text.trim(),
      'district': districtCtrl.text.trim(),
      'updatedAt': FieldValue.serverTimestamp(),
    };

    payload['profileCompletion'] = _calculateCompletion({
      ...widget.initialData,
      ...payload,
    });

    await FirebaseFirestore.instance
        .collection('users')
        .doc(widget.uid)
        .update(payload);

    setState(() => isSaving = false);

    Get.back();
    Get.snackbar(
      'Profile Updated',
      'Your profile has been saved',
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Edit Profile')),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              _input(fullNameCtrl, 'Full Name'),
              _input(phoneCtrl, 'Phone', keyboard: TextInputType.phone),
              _input(ageCtrl, 'Age', keyboard: TextInputType.number),
              _input(addressCtrl, 'Address'),

              _dropdown(
                label: 'Gender',
                value: gender,
                items: const ['Male', 'Female', 'Other'],
                onChanged: (v) => setState(() => gender = v),
              ),

              _input(qualificationCtrl, 'Qualification'),

              _dropdown(
                label: 'Experience',
                value: experienceType,
                items: const ['fresher', 'experienced'],
                onChanged: (v) => setState(() => experienceType = v),
              ),

              _input(stateCtrl, 'State'),
              _input(districtCtrl, 'District'),

              const SizedBox(height: 30),

              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: isSaving ? null : _saveProfile,
                  child: isSaving
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text(
                          'Save Profile',
                          style: TextStyle(fontWeight: FontWeight.w800),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _input(
    TextEditingController ctrl,
    String label, {
    TextInputType keyboard = TextInputType.text,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: TextFormField(
        controller: ctrl,
        keyboardType: keyboard,
        validator: (v) => v == null || v.isEmpty ? 'Required' : null,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
        ),
      ),
    );
  }

  Widget _dropdown({
    required String label,
    required String value,
    required List<String> items,
    required Function(String) onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: DropdownButtonFormField<String>(
        value: value,
        items: items
            .map((e) => DropdownMenuItem(value: e, child: Text(e)))
            .toList(),
        onChanged: (v) => onChanged(v!),
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
        ),
      ),
    );
  }
}

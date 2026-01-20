import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ServiceDetailsFormScreen extends StatefulWidget {
  const ServiceDetailsFormScreen({super.key});

  @override
  State<ServiceDetailsFormScreen> createState() =>
      _ServiceDetailsFormScreenState();
}

class _ServiceDetailsFormScreenState extends State<ServiceDetailsFormScreen> {
  final _formKey = GlobalKey<FormState>();

  final nameCtrl = TextEditingController();
  final phoneCtrl = TextEditingController();
  final companyCtrl = TextEditingController();
  final addressCtrl = TextEditingController();
  final cityCtrl = TextEditingController();
  final businessTypeCtrl = TextEditingController();

  bool isLoading = false;

  Future<void> _saveDetails() async {
    if (!_formKey.currentState!.validate()) return;

    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    try {
      setState(() => isLoading = true);

      await FirebaseFirestore.instance
          .collection('service_recruiters')
          .doc(user.uid)
          .update({
            'fullName': nameCtrl.text.trim(),
            'phone': phoneCtrl.text.trim(),
            'companyName': companyCtrl.text.trim(),
            'address': addressCtrl.text.trim(),
            'city': cityCtrl.text.trim(),
            'businessType': businessTypeCtrl.text.trim(),
            'profileCompleted': true,
            'updatedAt': FieldValue.serverTimestamp(),
          });

      Get.offAllNamed('/service-home');
    } catch (e) {
      Get.snackbar('Error', e.toString(), snackPosition: SnackPosition.BOTTOM);
    } finally {
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Complete Your Profile'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(22),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              _field(nameCtrl, 'Full Name'),
              _field(phoneCtrl, 'Phone Number', keyboard: TextInputType.phone),
              _field(companyCtrl, 'Company / Shop Name'),
              _field(addressCtrl, 'Address'),
              _field(cityCtrl, 'City'),
              _field(businessTypeCtrl, 'Business Type'),

              const SizedBox(height: 30),

              SizedBox(
                width: double.infinity,
                height: 54,
                child: ElevatedButton(
                  onPressed: isLoading ? null : _saveDetails,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2563EB),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: isLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text(
                          'Continue',
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 16,
                          ),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _field(
    TextEditingController controller,
    String label, {
    TextInputType keyboard = TextInputType.text,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboard,
        validator: (v) => v == null || v.isEmpty ? 'Required' : null,
        decoration: InputDecoration(
          labelText: label,
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}

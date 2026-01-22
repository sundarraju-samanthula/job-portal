import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:jobportal/core/role.dart';

class ServiceProfileController extends GetxController {
  final _db = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;

  RxBool isLoading = true.obs;

  final nameCtrl = TextEditingController();
  final phoneCtrl = TextEditingController();
  final companyCtrl = TextEditingController();
  final cityCtrl = TextEditingController();

  String uid = '';

  @override
  void onInit() {
    super.onInit();
    fetchProfile();
  }

  Future<void> fetchProfile() async {
    final user = _auth.currentUser;
    if (user == null) return;

    uid = user.uid;

    final doc = await _db.collection('service_recruiters').doc(uid).get();

    if (doc.exists) {
      final data = doc.data()!;
      nameCtrl.text = data['fullName'] ?? '';
      phoneCtrl.text = data['phone'] ?? '';
      companyCtrl.text = data['companyName'] ?? '';
      cityCtrl.text = data['city'] ?? '';
    }

    isLoading.value = false;
  }

  Future<void> updateProfile() async {
    try {
      isLoading.value = true;

      await _db.collection('service_recruiters').doc(uid).update({
        'fullName': nameCtrl.text.trim(),
        'phone': phoneCtrl.text.trim(),
        'companyName': companyCtrl.text.trim(),
        'city': cityCtrl.text.trim(),
        'updatedAt': FieldValue.serverTimestamp(),
      });

      Get.snackbar("Success", "Profile updated");
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> logout() async {
    final googleSignIn = GoogleSignIn();
    await _auth.signOut();
    RoleStore.clearRole();

    await FirebaseAuth.instance.signOut();
    await googleSignIn.disconnect(); // important

    Get.offAllNamed('/role');
  }

  // Future<void> logout() async {
  //   await _auth.signOut();
  //   RoleStore.clearRole();
  //   Get.offAllNamed('/role');
  // }

  //import 'package:get_storage/get_storage.dart';

  // Future<void> logout() async {
  //   await _auth.signOut();
  //   await GetStorage().remove('role');
  //   Get.offAllNamed('/role');
  // }
}

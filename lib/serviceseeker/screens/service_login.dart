import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:jobportal/core/role.dart';

class ServiceLoginScreen extends StatefulWidget {
  const ServiceLoginScreen({super.key});

  @override
  State<ServiceLoginScreen> createState() => _ServiceLoginScreenState();
}

class _ServiceLoginScreenState extends State<ServiceLoginScreen> {
  bool _loading = false;

  Future<void> _signInWithGoogle() async {
    try {
      setState(() => _loading = true);

      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) {
        setState(() => _loading = false);
        return;
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final userCredential = await FirebaseAuth.instance.signInWithCredential(
        credential,
      );

      final user = userCredential.user;
      if (user == null) {
        setState(() => _loading = false);
        return;
      }

      final ref = FirebaseFirestore.instance
          .collection('service_recruiters')
          .doc(user.uid);

      final doc = await ref.get();

      if (!doc.exists) {
        await ref.set({
          'uid': user.uid,
          'fullName': user.displayName ?? '',
          'email': user.email ?? '',
          'phone': user.phoneNumber ?? '',
          'photoUrl': user.photoURL ?? '',
          'createdAt': FieldValue.serverTimestamp(),
          'profileCompleted': false,
          'role': 'service_recruiter',
        });
      }
      //final doc = await ref.get();

      // if (!doc.exists || doc.data()?['profileCompleted'] != true) {
      //   Get.offAllNamed('/service-details-form');
      // } else {
      //   Get.offAllNamed('/service-home');
      // }

      RoleStore.setRole('service');

      if (!doc.exists || doc.data()?['profileCompleted'] != true) {
        Get.offAllNamed('/service-details-form');
      } else {
        Get.offAllNamed('/service-home');
      }

      // Get.offAllNamed('/service-details-form');
    } catch (e) {
      Get.snackbar(
        'Login Failed',
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(24),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFF4F7FF), Color(0xFFFFFFFF)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.home_repair_service, size: 90),
            const SizedBox(height: 20),
            const Text(
              'Find Workers Easily',
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              'Login to hire electricians, plumbers, and more',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.black54),
            ),
            const SizedBox(height: 40),

            /// GOOGLE BUTTON
            SizedBox(
              height: 52,
              child: ElevatedButton.icon(
                onPressed: _loading ? null : _signInWithGoogle,
                icon: _loading
                    ? const SizedBox(
                        height: 18,
                        width: 18,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                    : const Icon(Icons.login),
                label: Text(
                  _loading ? "Signing in..." : "Continue with Google",
                ),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 26,
                    vertical: 14,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

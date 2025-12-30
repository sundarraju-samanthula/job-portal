// import 'package:get/get.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import '../services/auth_service.dart';

// class AuthController extends GetxController {
//   final AuthService _authService = AuthService();
//   final FirebaseFirestore _db = FirebaseFirestore.instance;

//   RxBool isLoading = false.obs;

//   Future<void> googleSignIn() async {
//     try {
//       isLoading.value = true;

//       final userCredential = await _authService.signInWithGoogle();

//       if (userCredential == null) return;

//       final user = userCredential.user!;
//       final userDoc = await _db.collection('users').doc(user.uid).get();

//       if (userDoc.exists && userDoc['profileCompleted'] == true) {
//         // OLD USER
//         Get.offAllNamed('/home');
//       } else {
//         // NEW USER
//         Get.offAllNamed('/personal-details');
//       }
//     } catch (e) {
//       Get.snackbar('Login Failed', e.toString());
//     } finally {
//       isLoading.value = false;
//     }
//   }
// }
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  RxBool isLoading = false.obs;

  Future<void> signInWithGoogle() async {
    try {
      isLoading.value = true;

      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      if (googleUser == null) {
        isLoading.value = false;
        return; // User cancelled
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final userCredential = await _auth.signInWithCredential(credential);

      final uid = userCredential.user!.uid;

      /// CHECK IF USER EXISTS IN FIRESTORE
      final doc = await _db.collection('users').doc(uid).get();

      if (doc.exists) {
        Get.offAllNamed('/home');
      } else {
        Get.offAllNamed('/personal-details');
      }
    } catch (e) {
      Get.snackbar(
        'Login Failed',
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }
}

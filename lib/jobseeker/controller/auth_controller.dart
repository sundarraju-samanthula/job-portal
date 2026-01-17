// // // // import 'package:get/get.dart';
// // // // import 'package:firebase_auth/firebase_auth.dart';
// // // // import 'package:cloud_firestore/cloud_firestore.dart';
// // // // import '../services/auth_service.dart';

// // // // class AuthController extends GetxController {
// // // //   final AuthService _authService = AuthService();
// // // //   final FirebaseFirestore _db = FirebaseFirestore.instance;

// // // //   RxBool isLoading = false.obs;

// // // //   Future<void> googleSignIn() async {
// // // //     try {
// // // //       isLoading.value = true;

// // // //       final userCredential = await _authService.signInWithGoogle();

// // // //       if (userCredential == null) return;

// // // //       final user = userCredential.user!;
// // // //       final userDoc = await _db.collection('users').doc(user.uid).get();

// // // //       if (userDoc.exists && userDoc['profileCompleted'] == true) {
// // // //         // OLD USER
// // // //         Get.offAllNamed('/home');
// // // //       } else {
// // // //         // NEW USER
// // // //         Get.offAllNamed('/personal-details');
// // // //       }
// // // //     } catch (e) {
// // // //       Get.snackbar('Login Failed', e.toString());
// // // //     } finally {
// // // //       isLoading.value = false;
// // // //     }
// // // //   }
// // // // }
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
// // import 'package:cloud_firestore/cloud_firestore.dart';
// // import 'package:firebase_auth/firebase_auth.dart';
// // import 'package:flutter/material.dart';
// // import 'package:get/get.dart';
// // import 'package:google_sign_in/google_sign_in.dart';

// // class AuthController extends GetxController {
// //   final FirebaseAuth _auth = FirebaseAuth.instance;

// //   final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);

// //   final FirebaseFirestore _db = FirebaseFirestore.instance;

// //   RxBool isLoading = false.obs;

// //   Future<void> signInWithGoogle() async {
// //     if (isLoading.value) return; // 🚫 prevent double tap
// //     isLoading.value = true;

// //     try {
// //       // 🔥 FORCE ACCOUNT PICKER EVERY TIME
// //       await _googleSignIn.signOut();
// //       await _googleSignIn.disconnect();

// //       final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

// //       if (googleUser == null) {
// //         // User cancelled login
// //         isLoading.value = false;
// //         return;
// //       }

// //       final GoogleSignInAuthentication googleAuth =
// //           await googleUser.authentication;

// //       final credential = GoogleAuthProvider.credential(
// //         accessToken: googleAuth.accessToken,
// //         idToken: googleAuth.idToken,
// //       );

// //       final userCredential = await _auth.signInWithCredential(credential);

// //       final user = userCredential.user!;
// //       final uid = user.uid;

// //       /// 🔎 CHECK FIRESTORE PROFILE
// //       final doc = await _db.collection('users').doc(uid).get();

// //       if (doc.exists && doc.data()?['profileCompleted'] == true) {
// //         // ✅ OLD USER
// //         Get.offAllNamed('/home');
// //       } else {
// //         // 🆕 NEW USER
// //         Get.offAllNamed('/personal-details');
// //       }
// //     } catch (e) {
// //       Get.snackbar(
// //         'Login Failed',
// //         'Please try again',
// //         snackPosition: SnackPosition.BOTTOM,
// //       );
// //     } finally {
// //       isLoading.value = false;
// //     }
// //   }

// //   /// 🚪 LOGOUT (IMPORTANT)
// //   Future<void> logout() async {
// //     try {
// //       await _auth.signOut();
// //       await _googleSignIn.signOut();
// //       await _googleSignIn.disconnect();
// //       Get.offAllNamed('/login');
// //     } catch (e) {
// //       debugPrint('Logout error: $e');
// //     }
// //   }
// // }
// import 'package:get/get_state_manager/src/simple/get_controllers.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:google_sign_in/google_sign_in.dart';

// class AuthController extends GetxController {
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   final FirebaseFirestore _db = FirebaseFirestore.instance;

//   final GoogleSignIn _googleSignIn = GoogleSignIn(
//     scopes: ['email'],
//     signInOption: SignInOption.standard,
//   );

//   RxBool isLoading = false.obs;

//   Future<void> signInWithGoogle() async {
//     if (isLoading.value) return;
//     isLoading.value = true;

//     try {
//       // 🔥 FORCE ACCOUNT SELECTION
//       await _googleSignIn.signOut();
//       await _googleSignIn.disconnect();

//       final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

//       if (googleUser == null) {
//         // user cancelled
//         isLoading.value = false;
//         return;
//       }

//       final googleAuth = await googleUser.authentication;

//       final credential = GoogleAuthProvider.credential(
//         idToken: googleAuth.idToken,
//         accessToken: googleAuth.accessToken,
//       );

//       final userCredential = await _auth.signInWithCredential(credential);

//       final user = userCredential.user!;
//       final doc = await _db.collection('users').doc(user.uid).get();

//       if (doc.exists && doc.data()?['profileCompleted'] == true) {
//         Get.offAllNamed('/home');
//       } else {
//         Get.offAllNamed('/personal-details');
//       }
//     } catch (e) {
//       debugPrint('❌ LOGIN ERROR: $e');
//       Get.snackbar(
//         'Login Failed',
//         'Google sign-in failed. Please try again.',
//         snackPosition: SnackPosition.BOTTOM,
//       );
//     } finally {
//       isLoading.value = false;
//     }
//   }

//   Future<void> logout() async {
//     await _auth.signOut();
//     await _googleSignIn.signOut();
//     await _googleSignIn.disconnect();
//     Get.offAllNamed('/login');
//   }
// }
// class AuthController extends GetxController {
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   final FirebaseFirestore _db = FirebaseFirestore.instance;

//   final GoogleSignIn _googleSignIn = GoogleSignIn(
//     scopes: ['email'],
//     signInOption: SignInOption.standard,
//   );

//   RxBool isLoading = false.obs;

//   Future<void> signInWithGoogle() async {
//     if (isLoading.value) return;
//     isLoading.value = true;

//     try {
//       // 🔥 FORCE ACCOUNT PICKER EVERY TIME
//       await _googleSignIn.signOut();
//       await _googleSignIn.disconnect();

//       final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

//       if (googleUser == null) {
//         isLoading.value = false;
//         return;
//       }

//       final googleAuth = await googleUser.authentication;

//       final credential = GoogleAuthProvider.credential(
//         idToken: googleAuth.idToken,
//         accessToken: googleAuth.accessToken,
//       );

//       final userCredential = await _auth.signInWithCredential(credential);

//       final user = userCredential.user!;
//       final doc = await _db.collection('users').doc(user.uid).get();

//       if (doc.exists && doc.data()?['profileCompleted'] == true) {
//         Get.offAllNamed('/home');
//       } else {
//         Get.offAllNamed('/personal-details');
//       }
//     } catch (e) {
//       debugPrint('❌ GOOGLE LOGIN ERROR: $e');

//       Get.snackbar(
//         'Login Failed',
//         'Google sign-in failed. Please try again.',
//         snackPosition: SnackPosition.BOTTOM,
//       );
//     } finally {
//       isLoading.value = false;
//     }
//   }

//   Future<void> logout() async {
//     await _auth.signOut();
//     await _googleSignIn.signOut();
//     await _googleSignIn.disconnect();
//     Get.offAllNamed('/login');
//   }
// }

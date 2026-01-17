// // import 'package:firebase_auth/firebase_auth.dart';
// // import 'package:flutter/material.dart';
// // import 'package:get/get_core/src/get_main.dart';
// // import 'package:get/get_navigation/src/extension_navigation.dart';
// // import 'package:google_sign_in/google_sign_in.dart';

// // class AuthService {
// //   final FirebaseAuth _auth = FirebaseAuth.instance;

// //   final GoogleSignIn googleSignIn = GoogleSignIn(scopes: ['email']);

// //   Future<UserCredential?> signInWithGoogle() async {
// //     final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

// //     if (googleUser == null) return null;

// //     final GoogleSignInAuthentication googleAuth =
// //         await googleUser.authentication;

// //     final OAuthCredential credential = GoogleAuthProvider.credential(
// //       accessToken: googleAuth.accessToken,
// //       idToken: googleAuth.idToken,
// //     );

// //     return await _auth.signInWithCredential(credential);
// //   }

// //   Future<void> logout() async {
// //   try {
// //     // 1️⃣ Sign out from Firebase
// //     await FirebaseAuth.instance.signOut();

// //     // 2️⃣ Sign out from Google
// //     await googleSignIn.signOut();

// //     // 3️⃣ OPTIONAL (stronger) – removes cached account
// //     await googleSignIn.disconnect();

// //     // 4️⃣ Navigate to login
// //     Get.offAllNamed('/login');
// //   } catch (e) {
// //     debugPrint('Logout error: $e');
// //   }
// // }

// // }
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:google_sign_in/google_sign_in.dart';

// class AuthService {
//   final FirebaseAuth _auth = FirebaseAuth.instance;

//   final GoogleSignIn googleSignIn = GoogleSignIn(scopes: ['email']);

//   // 🔐 GOOGLE SIGN-IN (FORCE ACCOUNT PICKER)
//   Future<UserCredential?> signInWithGoogle() async {
//     try {
//       // 🚨 CRITICAL LINE — clears cached Google account
//       await googleSignIn.signOut();

//       final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

//       if (googleUser == null) return null;

//       final GoogleSignInAuthentication googleAuth =
//           await googleUser.authentication;

//       final OAuthCredential credential = GoogleAuthProvider.credential(
//         accessToken: googleAuth.accessToken,
//         idToken: googleAuth.idToken,
//       );

//       return await _auth.signInWithCredential(credential);
//     } catch (e) {
//       debugPrint('Google Sign-In error: $e');
//       return null;
//     }
//   }

//   // 🚪 LOGOUT (COMPLETE & SAFE)
//   Future<void> logout() async {
//     try {
//       // 1️⃣ Firebase logout
//       await _auth.signOut();

//       // 2️⃣ Google logout
//       await googleSignIn.signOut();

//       // 3️⃣ Strong cleanup (removes permission)
//       await googleSignIn.disconnect();

//       // 4️⃣ Redirect to login
//       Get.offAllNamed('/login');
//     } catch (e) {
//       debugPrint('Logout error: $e');
//     }
//   }
// }
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  /// ⚠️ IMPORTANT: force account picker
  final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);

  /// -------------------------------
  /// GOOGLE SIGN-IN (FORCE PICKER)
  /// -------------------------------
  Future<UserCredential?> signInWithGoogle() async {
    try {
      /// 🚨 CRITICAL STEP
      await _googleSignIn.signOut();
      await _googleSignIn.disconnect();

      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      if (googleUser == null) {
        debugPrint('User cancelled Google Sign-In');
        return null;
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      return await _auth.signInWithCredential(credential);
    } catch (e) {
      debugPrint('Google Sign-In error: $e');
      return null;
    }
  }

  /// -------------------------------
  /// LOGOUT (FULL CLEAN)
  /// -------------------------------
  Future<void> logout() async {
    try {
      await _auth.signOut();

      /// 🔥 FULL GOOGLE CLEANUP
      await _googleSignIn.signOut();
      await _googleSignIn.disconnect();

      /// 🔄 Navigate to login
      Get.offAllNamed('/login');
    } catch (e) {
      debugPrint('Logout error: $e');
    }
  }
}

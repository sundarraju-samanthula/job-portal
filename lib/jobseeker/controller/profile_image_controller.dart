// import 'dart:io';
// import 'package:get/get.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:image_cropper/image_cropper.dart';
// import 'package:flutter/material.dart';

// class ProfileImageController extends GetxController {
//   final picker = ImagePicker();

//   RxDouble uploadProgress = 0.0.obs;
//   RxBool isUploading = false.obs;

//   /// PICK + CROP + UPLOAD
//   Future<void> pickAndUploadImage() async {
//     final user = FirebaseAuth.instance.currentUser;
//     if (user == null) return;

//     final picked = await picker.pickImage(source: ImageSource.gallery);
//     if (picked == null) return;

//     /// ✂️ CROP
//     final cropped = await ImageCropper().cropImage(
//       sourcePath: picked.path,
//       compressQuality: 85,
//       aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
//       uiSettings: [
//         AndroidUiSettings(
//           toolbarTitle: 'Crop Profile Image',
//           toolbarColor: const Color(0xFF2563EB),
//           toolbarWidgetColor: Colors.white,
//           lockAspectRatio: true,
//         ),
//         IOSUiSettings(title: 'Crop Image'),
//       ],
//     );

//     if (cropped == null) return;

//     final file = File(cropped.path);

//     try {
//       isUploading.value = true;
//       uploadProgress.value = 0;

//       final ref = FirebaseStorage.instance.ref().child(
//         'profile_images/${user.uid}.jpg',
//       );

//       final uploadTask = ref.putFile(file);

//       uploadTask.snapshotEvents.listen((event) {
//         uploadProgress.value = event.bytesTransferred / event.totalBytes;
//       });

//       await uploadTask;

//       final imageUrl = await ref.getDownloadURL();

//       await FirebaseFirestore.instance.collection('users').doc(user.uid).update(
//         {'photoUrl': imageUrl},
//       );
//     } finally {
//       isUploading.value = false;
//       uploadProgress.value = 0;
//     }
//   }

//   Future<void> deleteProfileImage() async {
//     final user = FirebaseAuth.instance.currentUser;
//     if (user == null) return;

//     try {
//       isUploading.value = true;

//       final ref = FirebaseStorage.instance.ref().child(
//         'profile_images/${user.uid}.jpg',
//       );

//       // Delete from storage (ignore if already deleted)
//       await ref.delete().catchError((_) {});

//       // Remove from Firestore
//       await FirebaseFirestore.instance.collection('users').doc(user.uid).update(
//         {'photoUrl': FieldValue.delete()},
//       );

//       Get.snackbar(
//         'Profile Image Removed',
//         'Your profile photo has been deleted',
//         snackPosition: SnackPosition.BOTTOM,
//       );
//     } catch (e) {
//       Get.snackbar(
//         'Error',
//         'Failed to delete image',
//         snackPosition: SnackPosition.BOTTOM,
//       );
//     } finally {
//       isUploading.value = false;
//     }
//   }
// }
import 'dart:io';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:flutter/material.dart';

class ProfileImageController extends GetxController {
  final ImagePicker _picker = ImagePicker();

  RxDouble uploadProgress = 0.0.obs;
  RxBool isUploading = false.obs;

  /// 📸 PICK → ✂️ CROP → ☁️ UPLOAD
  Future<void> pickAndUploadImage() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    /// 1️⃣ PICK IMAGE
    final picked = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 90,
    );
    if (picked == null) return;

    /// 2️⃣ CROP IMAGE (PROFILE STYLE)
    final cropped = await ImageCropper().cropImage(
      sourcePath: picked.path,
      compressQuality: 85,
      aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: 'Crop Profile Image',
          toolbarColor: const Color(0xFF2563EB),
          toolbarWidgetColor: Colors.white,
          lockAspectRatio: true,
          hideBottomControls: true,
          initAspectRatio: CropAspectRatioPreset.square,
        ),
        IOSUiSettings(
          title: 'Crop Profile Image',
          aspectRatioLockEnabled: true,
        ),
      ],
    );

    if (cropped == null) return;

    final file = File(cropped.path);

    try {
      isUploading.value = true;
      uploadProgress.value = 0;

      /// 3️⃣ UPLOAD TO FIREBASE STORAGE
      final ref = FirebaseStorage.instance.ref().child(
        'profile_images/${user.uid}.jpg',
      );

      final uploadTask = ref.putFile(file);

      uploadTask.snapshotEvents.listen((event) {
        if (event.totalBytes > 0) {
          uploadProgress.value = event.bytesTransferred / event.totalBytes;
        }
      });

      await uploadTask;

      /// 4️⃣ SAVE IMAGE URL TO FIRESTORE
      final imageUrl = await ref.getDownloadURL();

      await FirebaseFirestore.instance.collection('users').doc(user.uid).update(
        {'photoUrl': imageUrl},
      );

      Get.snackbar(
        'Success',
        'Profile image updated',
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e) {
      Get.snackbar(
        'Upload Failed',
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isUploading.value = false;
      uploadProgress.value = 0;
    }
  }

  /// 🗑 DELETE PROFILE IMAGE
  Future<void> deleteProfileImage() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    try {
      isUploading.value = true;

      final ref = FirebaseStorage.instance.ref().child(
        'profile_images/${user.uid}.jpg',
      );

      // Delete from storage (ignore if not found)
      await ref.delete().catchError((_) {});

      // Remove URL from Firestore
      await FirebaseFirestore.instance.collection('users').doc(user.uid).update(
        {'photoUrl': FieldValue.delete()},
      );

      Get.snackbar(
        'Profile Image Removed',
        'Your profile photo has been deleted',
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to delete image',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isUploading.value = false;
      uploadProgress.value = 0;
    }
  }
}

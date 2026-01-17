// // // // import 'package:cloud_firestore/cloud_firestore.dart';
// // // // import 'package:firebase_auth/firebase_auth.dart';
// // // // import 'package:get/get.dart';
// // // // import '../models/job_model.dart';

// // // // class SavedJobsController extends GetxController {
// // // //   final _db = FirebaseFirestore.instance;
// // // //   final _auth = FirebaseAuth.instance;

// // // //   RxList<JobModel> savedJobs = <JobModel>[].obs;
// // // //   RxBool isLoading = true.obs;

// // // //   @override
// // // //   void onInit() {
// // // //     super.onInit();
// // // //     fetchSavedJobs();
// // // //   }

// // // //   void fetchSavedJobs() {
// // // //     final user = _auth.currentUser;
// // // //     if (user == null) return;

// // // //     isLoading.value = true;

// // // //     _db
// // // //         .collection('users')
// // // //         .doc(user.uid)
// // // //         .collection('savedJobs')
// // // //         .snapshots()
// // // //         .listen((snapshot) async {
// // // //           final jobIds = snapshot.docs.map((e) => e.id).toList();

// // // //           if (jobIds.isEmpty) {
// // // //             savedJobs.clear();
// // // //             isLoading.value = false;
// // // //             return;
// // // //           }

// // // //           final jobsSnapshot = await _db
// // // //               .collection('jobs')
// // // //               .where(FieldPath.documentId, whereIn: jobIds)
// // // //               .get();

// // // //           final list = jobsSnapshot.docs
// // // //               .map((doc) => JobModel.fromFirestore(doc.data(), doc.id))
// // // //               .toList();

// // // //           savedJobs.value = list;
// // // //           isLoading.value = false;
// // // //         });
// // // //   }

// // // //   Future<void> toggleSave(JobModel job) async {
// // // //     final user = _auth.currentUser;
// // // //     if (user == null) return;

// // // //     final ref = _db
// // // //         .collection('users')
// // // //         .doc(user.uid)
// // // //         .collection('savedJobs')
// // // //         .doc(job.id);

// // // //     final exists = await ref.get();

// // // //     if (exists.exists) {
// // // //       await ref.delete();
// // // //     } else {
// // // //       await ref.set({'jobId': job.id, 'savedAt': FieldValue.serverTimestamp()});
// // // //     }
// // // //   }

// // // //   Future<void> removeSavedJob(String jobId) async {
// // // //     final user = _auth.currentUser;
// // // //     if (user == null) return;

// // // //     await _db
// // // //         .collection('users')
// // // //         .doc(user.uid)
// // // //         .collection('savedJobs')
// // // //         .doc(jobId)
// // // //         .delete();
// // // //   }
// // // // }
// // // import 'package:cloud_firestore/cloud_firestore.dart';
// // // import 'package:firebase_auth/firebase_auth.dart';
// // // import 'package:get/get.dart';
// // // import '../models/job_model.dart';

// // // class SavedJobsController extends GetxController {
// // //   final _db = FirebaseFirestore.instance;
// // //   final _auth = FirebaseAuth.instance;

// // //   RxList<JobModel> savedJobs = <JobModel>[].obs;
// // //   RxList<String> savedJobIds = <String>[].obs; // 🔥 For quick lookup
// // //   RxBool isLoading = true.obs;

// // //   @override
// // //   void onInit() {
// // //     super.onInit();
// // //     fetchSavedJobs();
// // //   }

// // //   /// ✅ CHECK IF JOB IS SAVED
// // //   bool isSaved(String jobId) {
// // //     return savedJobIds.contains(jobId);
// // //   }

// // //   void fetchSavedJobs() {
// // //     final user = _auth.currentUser;
// // //     if (user == null) return;

// // //     isLoading.value = true;

// // //     _db
// // //         .collection('users')
// // //         .doc(user.uid)
// // //         .collection('savedJobs')
// // //         .snapshots()
// // //         .listen((snapshot) async {
// // //           final jobIds = snapshot.docs.map((e) => e.id).toList();
// // //           savedJobIds.value = jobIds;

// // //           if (jobIds.isEmpty) {
// // //             savedJobs.clear();
// // //             isLoading.value = false;
// // //             return;
// // //           }

// // //           final jobsSnapshot = await _db
// // //               .collection('jobs')
// // //               .where(FieldPath.documentId, whereIn: jobIds)
// // //               .get();

// // //           final list = jobsSnapshot.docs
// // //               .map((doc) => JobModel.fromFirestore(doc.data(), doc.id))
// // //               .toList();

// // //           savedJobs.value = list;
// // //           isLoading.value = false;
// // //         });
// // //   }

// // //   Future<void> toggleSave(JobModel job) async {
// // //     final user = _auth.currentUser;
// // //     if (user == null) return;

// // //     final ref = _db
// // //         .collection('users')
// // //         .doc(user.uid)
// // //         .collection('savedJobs')
// // //         .doc(job.id);

// // //     if (isSaved(job.id)) {
// // //       await ref.delete();
// // //     } else {
// // //       await ref.set({'jobId': job.id, 'savedAt': FieldValue.serverTimestamp()});
// // //     }
// // //   }

// // //   Future<void> removeSavedJob(String jobId) async {
// // //     final user = _auth.currentUser;
// // //     if (user == null) return;

// // //     await _db
// // //         .collection('users')
// // //         .doc(user.uid)
// // //         .collection('savedJobs')
// // //         .doc(jobId)
// // //         .delete();
// // //   }
// // // }
// // import 'package:cloud_firestore/cloud_firestore.dart';
// // import 'package:firebase_auth/firebase_auth.dart';
// // import 'package:get/get_rx/src/rx_types/rx_types.dart';
// // import 'package:get/get_state_manager/src/simple/get_controllers.dart';
// // import 'package:jobportal/models/job_model.dart';

// // class SavedJobsController extends GetxController {
// //   final _db = FirebaseFirestore.instance;
// //   final _auth = FirebaseAuth.instance;

// //   RxList<JobModel> savedJobs = <JobModel>[].obs;
// //   RxBool isLoading = true.obs;

// //   @override
// //   void onInit() {
// //     super.onInit();
// //     fetchSavedJobs();
// //   }

// //   void fetchSavedJobs() {
// //     final user = _auth.currentUser;
// //     if (user == null) {
// //       isLoading.value = false;
// //       return;
// //     }

// //     isLoading.value = true;

// //     _db
// //         .collection('saved_jobs')
// //         .where('userId', isEqualTo: user.uid)
// //         .snapshots()
// //         .listen((snapshot) async {
// //           if (snapshot.docs.isEmpty) {
// //             savedJobs.clear();
// //             isLoading.value = false;
// //             return;
// //           }

// //           final jobIds = snapshot.docs
// //               .map((e) => e['jobId'] as String)
// //               .toList();

// //           final jobsSnapshot = await _db
// //               .collection('jobs')
// //               .where(FieldPath.documentId, whereIn: jobIds)
// //               .get();

// //           final list = jobsSnapshot.docs
// //               .map((doc) => JobModel.fromFirestore(doc.data(), doc.id))
// //               .toList();

// //           savedJobs.value = list;
// //           isLoading.value = false;
// //         });
// //   }

// //   bool isSaved(String jobId) {
// //     return savedJobs.any((job) => job.id == jobId);
// //   }

// //   Future<void> toggleSave(JobModel job) async {
// //     final user = _auth.currentUser;
// //     if (user == null) return;

// //     final docId = '${user.uid}-${job.id}';
// //     final ref = _db.collection('saved_jobs').doc(docId);

// //     final exists = await ref.get();

// //     if (exists.exists) {
// //       await ref.delete();
// //     } else {
// //       await ref.set({
// //         'jobId': job.id,
// //         'userId': user.uid,
// //         'savedAt': FieldValue.serverTimestamp(),
// //       });
// //     }
// //   }

// //   Future<void> removeSavedJob(String jobId) async {
// //     final user = _auth.currentUser;
// //     if (user == null) return;

// //     final docId = '${user.uid}-$jobId';
// //     await _db.collection('saved_jobs').doc(docId).delete();
// //   }
// // }
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import '../models/job_model.dart';

// class SavedJobsController extends GetxController {
//   final _db = FirebaseFirestore.instance;
//   final _auth = FirebaseAuth.instance;

//   RxList<JobModel> savedJobs = <JobModel>[].obs;
//   RxBool isLoading = false.obs;

//   @override
//   void onInit() {
//     super.onInit();
//     fetchSavedJobs();
//   }

//   void fetchSavedJobs() {
//     final user = _auth.currentUser;
//     if (user == null) return;

//     isLoading.value = true;

//     _db
//         .collection('saved_jobs')
//         .where('userId', isEqualTo: user.uid)
//         .snapshots()
//         .listen((snapshot) async {
//           if (snapshot.docs.isEmpty) {
//             savedJobs.clear();
//             isLoading.value = false;
//             return;
//           }

//           final jobIds = snapshot.docs.map((e) => e['jobId']).toList();

//           final jobsSnapshot = await _db
//               .collection('jobs')
//               .where(FieldPath.documentId, whereIn: jobIds)
//               .get();

//           final list = jobsSnapshot.docs
//               .map((doc) => JobModel.fromFirestore(doc.data(), doc.id))
//               .toList();

//           savedJobs.value = list;
//           isLoading.value = false;
//         });
//   }

//   bool isSaved(String jobId) {
//     return savedJobs.any((job) => job.id == jobId);
//   }

//   Future<void> toggleSave(JobModel job) async {
//     final user = _auth.currentUser;
//     if (user == null) return;

//     final docId = '${user.uid}-${job.id}';
//     final ref = _db.collection('saved_jobs').doc(docId);

//     final snap = await ref.get();

//     if (snap.exists) {
//       await ref.delete();
//     } else {
//       await ref.set({
//         'jobId': job.id,
//         'userId': user.uid,
//         'savedAt': FieldValue.serverTimestamp(),
//       });
//     }
//   }
// }
class SavedJobsController extends GetxController {
  final _db = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;

  RxList<JobModel> savedJobs = <JobModel>[].obs;
  RxBool isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchSavedJobs();
  }

  bool isSaved(String jobId) {
    return savedJobs.any((job) => job.id == jobId);
  }

  void fetchSavedJobs() {
    final user = _auth.currentUser;
    if (user == null) return;

    isLoading.value = true;

    _db
        .collection('saved_jobs')
        .where('userId', isEqualTo: user.uid)
        .snapshots()
        .listen((snapshot) async {
          if (snapshot.docs.isEmpty) {
            savedJobs.clear();
            isLoading.value = false;
            return;
          }

          final jobIds = snapshot.docs.map((e) => e['jobId']).toList();

          final jobsSnapshot = await _db
              .collection('jobs')
              .where(FieldPath.documentId, whereIn: jobIds)
              .get();

          final list = jobsSnapshot.docs
              .map((doc) => JobModel.fromFirestore(doc.data(), doc.id))
              .toList();

          savedJobs.value = list;
          isLoading.value = false;
        });
  }

  Future<void> toggleSave(JobModel job) async {
    final user = _auth.currentUser;
    if (user == null) return;

    final docId = '${user.uid}-${job.id}';

    final ref = _db.collection('saved_jobs').doc(docId);

    final exists = await ref.get();

    if (exists.exists) {
      await ref.delete();
    } else {
      await ref.set({
        'userId': user.uid,
        'jobId': job.id,
        'savedAt': FieldValue.serverTimestamp(),
      });
    }
  }

  Future<void> removeSavedJob(String jobId) async {
    final user = _auth.currentUser;
    if (user == null) return;

    final docId = '${user.uid}-$jobId';

    await _db.collection('saved_jobs').doc(docId).delete();
  }
}

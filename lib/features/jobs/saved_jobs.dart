// // // import 'package:cloud_firestore/cloud_firestore.dart';
// // // import 'package:firebase_auth/firebase_auth.dart';
// // // import 'package:get/get.dart';
// // // import 'package:jobportal/models/job_model.dart';
// // // //import '../models/job_model.dart';

// // // class SavedJobsController extends GetxController {
// // //   final FirebaseFirestore _db = FirebaseFirestore.instance;
// // //   final FirebaseAuth _auth = FirebaseAuth.instance;

// // //   RxList<JobModel> savedJobs = <JobModel>[].obs;
// // //   RxSet<String> savedJobIds = <String>{}.obs;

// // //   RxBool isLoading = false.obs;

// // //   @override
// // //   void onInit() {
// // //     super.onInit();
// // //     listenToSavedJobs();
// // //   }

// // //   /// 🔁 Realtime listener for saved jobs
// // //   void listenToSavedJobs() {
// // //     final uid = _auth.currentUser?.uid;
// // //     if (uid == null) return;

// // //     _db
// // //         .collection('saved_jobs')
// // //         .where('userId', isEqualTo: uid)
// // //         .snapshots()
// // //         .listen((snapshot) async {
// // //           final ids = snapshot.docs.map((d) => d['jobId'] as String).toList();
// // //           savedJobIds.value = ids.toSet();

// // //           if (ids.isEmpty) {
// // //             savedJobs.clear();
// // //             return;
// // //           }

// // //           await fetchSavedJobs(ids);
// // //         });
// // //   }

// // //   /// 📥 Fetch full job documents
// // //   Future<void> fetchSavedJobs(List<String> ids) async {
// // //     try {
// // //       isLoading.value = true;

// // //       final snap = await _db
// // //           .collection('jobs')
// // //           .where(FieldPath.documentId, whereIn: ids)
// // //           .get();

// // //       savedJobs.value = snap.docs
// // //           .map((doc) => JobModel.fromFirestore(doc.data(), doc.id))
// // //           .toList();
// // //     } catch (e) {
// // //       print("Error fetching saved jobs: $e");
// // //     } finally {
// // //       isLoading.value = false;
// // //     }
// // //   }

// // //   /// ❤️ Save job
// // //   Future<void> saveJob(String jobId) async {
// // //     final uid = _auth.currentUser!.uid;
// // //     final docId = "${uid}_$jobId";

// // //     await _db.collection('saved_jobs').doc(docId).set({
// // //       'userId': uid,
// // //       'jobId': jobId,
// // //       'savedAt': FieldValue.serverTimestamp(),
// // //     });
// // //   }

// // //   /// ❌ Remove saved job
// // //   Future<void> removeSavedJob(String jobId) async {
// // //     final uid = _auth.currentUser!.uid;
// // //     final docId = "${uid}_$jobId";

// // //     await _db.collection('saved_jobs').doc(docId).delete();
// // //   }

// // //   /// 🔁 Toggle save
// // //   Future<void> toggleSave(String jobId) async {
// // //     if (savedJobIds.contains(jobId)) {
// // //       await removeSavedJob(jobId);
// // //     } else {
// // //       await saveJob(jobId);
// // //     }
// // //   }

// // //   /// ❓ Check if saved
// // //   bool isSaved(String jobId) {
// // //     return savedJobIds.contains(jobId);
// // //   }
// // // }
// // import 'package:flutter/material.dart';
// // import 'package:get/get.dart';
// // import 'package:jobportal/features/home/job_card.dart';
// // import '../../controller/saved_jobs_controller.dart';
// // //import '../../models/job_model.dart';
// // //import '../../widgets/animated_job_card.dart'; // adjust import

// // class SavedJobsScreen extends StatelessWidget {
// //   const SavedJobsScreen({super.key});

// //   @override
// //   Widget build(BuildContext context) {
// //     final controller = Get.put(SavedJobsController());

// //     return Scaffold(
// //       appBar: AppBar(
// //         title: const Text('Saved Jobs'),
// //         backgroundColor: Colors.white,
// //         foregroundColor: Colors.black,
// //         elevation: 0,
// //       ),
// //       body: Container(
// //         decoration: const BoxDecoration(
// //           gradient: LinearGradient(
// //             begin: Alignment.topCenter,
// //             end: Alignment.bottomCenter,
// //             colors: [Color(0xFFF7FAFF), Color(0xFFEFF4FF)],
// //           ),
// //         ),
// //         child: Obx(() {
// //           if (controller.isLoading.value) {
// //             return const Center(child: CircularProgressIndicator());
// //           }

// //           if (controller.savedJobs.isEmpty) {
// //             return const _EmptySavedJobs();
// //           }

// //           return ListView.builder(
// //             padding: const EdgeInsets.all(22),
// //             itemCount: controller.savedJobs.length,
// //             itemBuilder: (context, index) {
// //               final job = controller.savedJobs[index];

// //               return Dismissible(
// //                 key: ValueKey(job.id),
// //                 direction: DismissDirection.endToStart,
// //                 onDismissed: (_) {
// //                   controller.removeSavedJob(job.id);
// //                 },
// //                 background: Container(
// //                   alignment: Alignment.centerRight,
// //                   padding: const EdgeInsets.only(right: 20),
// //                   decoration: BoxDecoration(
// //                     borderRadius: BorderRadius.circular(22),
// //                     color: Colors.red.shade400,
// //                   ),
// //                   child: const Icon(Icons.delete, color: Colors.white),
// //                 ),
// //                 child: AnimatedJobCard(index: index, job: job),
// //               );
// //             },
// //           );
// //         }),
// //       ),
// //     );
// //   }
// // }

// // class _EmptySavedJobs extends StatelessWidget {
// //   const _EmptySavedJobs();

// //   @override
// //   Widget build(BuildContext context) {
// //     return Center(
// //       child: Column(
// //         mainAxisSize: MainAxisSize.min,
// //         children: const [
// //           Icon(Icons.bookmark_border, size: 80, color: Colors.grey),
// //           SizedBox(height: 16),
// //           Text(
// //             'No saved jobs yet',
// //             style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
// //           ),
// //           SizedBox(height: 6),
// //           Text(
// //             'Save jobs to view them later',
// //             style: TextStyle(color: Colors.grey),
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// // }
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:jobportal/controller/saved_jobs_controller.dart';
// //import '../controller/saved_jobs_controller.dart';
// //import '../widgets/animated_job_card.dart'; // or your existing card

// // class SavedJobsScreen extends StatelessWidget {
// //   const SavedJobsScreen({super.key});

// //   @override
// //   Widget build(BuildContext context) {
// //     final controller = Get.find<SavedJobsController>();

// //     return Scaffold(
// //       appBar: AppBar(title: const Text("Saved Jobs"), centerTitle: true),
// //       body: Obx(() {
// //         if (controller.isLoading.value) {
// //           return const Center(child: CircularProgressIndicator());
// //         }

// //         if (controller.savedJobs.isEmpty) {
// //           return const _EmptySavedView();
// //         }

// //         return ListView.builder(
// //           padding: const EdgeInsets.all(16),
// //           itemCount: controller.savedJobs.length,
// //           itemBuilder: (context, index) {
// //             final job = controller.savedJobs[index];

// //             return Dismissible(
// //               key: ValueKey(job.id),
// //               direction: DismissDirection.endToStart,
// //               background: Container(
// //                 alignment: Alignment.centerRight,
// //                 padding: const EdgeInsets.only(right: 20),
// //                 color: Colors.red,
// //                 child: const Icon(Icons.delete, color: Colors.white),
// //               ),
// //               onDismissed: (_) {
// //                 controller.removeSavedJob(job.id);
// //               },
// //               child: AnimatedJobCard(index: index, job: job),
// //             );
// //           },
// //         );
// //       }),
// //     );
// //   }
// // }
// class SavedJobsScreen extends StatelessWidget {
//   const SavedJobsScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final controller = Get.put(SavedJobsController());

//     return Scaffold(
//       appBar: AppBar(title: const Text("Saved Jobs")),
//       body: Obx(() {
//         if (controller.isLoading.value) {
//           return const Center(child: CircularProgressIndicator());
//         }

//         if (controller.savedJobs.isEmpty) {
//           return const Center(child: Text("No saved jobs yet"));
//         }

//         return ListView.builder(
//           itemCount: controller.savedJobs.length,
//           itemBuilder: (_, index) {
//             final job = controller.savedJobs[index];
//             return ListTile(
//               title: Text(job.jobTitle),
//               subtitle: Text(job.companyName),
//               trailing: IconButton(
//                 icon: const Icon(Icons.delete),
//                 onPressed: () => controller.toggleSave(job),
//               ),
//             );
//           },
//         );
//       }),
//     );
//   }
// }

// class _EmptySavedView extends StatelessWidget {
//   const _EmptySavedView();

//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: const [
//           Icon(Icons.bookmark_border, size: 80, color: Colors.grey),
//           SizedBox(height: 14),
//           Text(
//             "No saved jobs yet",
//             style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
//           ),
//           SizedBox(height: 6),
//           Text(
//             "Save jobs to view them later",
//             style: TextStyle(color: Colors.grey),
//           ),
//         ],
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:get/get.dart';
//import 'package:jobportal/controller/saved_jobs_controller.dart';
import 'package:jobportal/jobseeker/controller/saved_jobs_controller.dart';
import 'package:jobportal/jobseeker/features/home/job_details.dart';
//import 'package:jobportal/features/home/job_details.dart';
import 'package:jobportal/jobseeker/models/job_model.dart';
//import 'package:jobportal/models/job_model.dart';
//import '../controller/saved_jobs_controller.dart';
//import '../models/job_model.dart';
//import 'job_details_screen.dart';

class SavedJobsScreen extends StatelessWidget {
  const SavedJobsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<SavedJobsController>();

    return Scaffold(
      appBar: AppBar(title: const Text('Saved Jobs'), centerTitle: true),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.savedJobs.isEmpty) {
          return const Center(
            child: Text('No saved jobs yet', style: TextStyle(fontSize: 16)),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: controller.savedJobs.length,
          itemBuilder: (context, index) {
            final job = controller.savedJobs[index];
            return _SavedJobCard(job: job);
          },
        );
      }),
    );
  }
}

class _SavedJobCard extends StatelessWidget {
  final JobModel job;

  const _SavedJobCard({required this.job});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<SavedJobsController>();

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.white,
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.08), blurRadius: 12),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            job.jobTitle,
            style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 16),
          ),
          const SizedBox(height: 6),
          Text(job.companyName),
          const SizedBox(height: 6),
          Text(job.location, style: const TextStyle(color: Colors.grey)),

          const SizedBox(height: 12),

          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    Get.to(() => JobDetailsScreen(job: job));
                  },
                  child: const Text("View"),
                ),
              ),
              const SizedBox(width: 12),
              IconButton(
                onPressed: () => controller.removeSavedJob(job.id),
                icon: const Icon(Icons.delete, color: Colors.red),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

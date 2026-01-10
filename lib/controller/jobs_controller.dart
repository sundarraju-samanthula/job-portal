// import 'dart:async';

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:get/get_rx/src/rx_types/rx_types.dart';
// import 'package:get/get_state_manager/src/simple/get_controllers.dart';
// import 'package:jobportal/models/job_model.dart';

// class JobsController extends GetxController {
//   final FirebaseFirestore _db = FirebaseFirestore.instance;

//   RxList<JobModel> jobs = <JobModel>[].obs;
//   RxList<JobModel> filteredJobs = <JobModel>[].obs;

//   RxBool isLoading = true.obs;

//   RxString searchQuery = ''.obs;
//   RxString selectedExperience = ''.obs;
//   RxString selectedJobType = ''.obs;
//   RxString selectedWorkMode = ''.obs;

//   Timer? _debounce;

//   @override
//   void onInit() {
//     super.onInit();
//     fetchJobs();
//   }

//   void onSearchChanged(String value) {
//     searchQuery.value = value;

//     if (_debounce?.isActive ?? false) _debounce!.cancel();

//     _debounce = Timer(const Duration(milliseconds: 350), () {
//       applyFilters();
//     });
//   }

//   void clearSearch() {
//     searchQuery.value = '';
//     applyFilters();
//   }

//   void fetchJobs() {
//     _db
//         .collection('jobs')
//         .where('isActive', isEqualTo: true)
//         .orderBy('createdAt', descending: true)
//         .snapshots()
//         .listen((snapshot) {
//           final list = snapshot.docs
//               .map((doc) => JobModel.fromFirestore(doc.data(), doc.id))
//               .toList();

//           jobs.value = list;
//           applyFilters();
//           isLoading.value = false;
//         });
//   }

//   void applyFilters() {
//     final q = searchQuery.value.toLowerCase();
//     final exp = selectedExperience.value.toLowerCase();
//     final type = selectedJobType.value.toLowerCase();
//     final mode = selectedWorkMode.value.toLowerCase();

//     filteredJobs.value = jobs.where((job) {
//       final matchesSearch =
//           q.isEmpty ||
//           job.jobTitle.toLowerCase().contains(q) ||
//           job.companyName.toLowerCase().contains(q) ||
//           job.location.toLowerCase().contains(q);

//       final matchesExp =
//           exp.isEmpty || job.experience.toLowerCase().contains(exp);

//       final matchesType =
//           type.isEmpty || job.jobType.toLowerCase().contains(type);

//       final matchesMode =
//           mode.isEmpty || job.workMode.toLowerCase().contains(mode);

//       return matchesSearch && matchesExp && matchesType && matchesMode;
//     }).toList();
//   }

//   void resetFilters() {
//     selectedExperience.value = '';
//     selectedJobType.value = '';
//     selectedWorkMode.value = '';
//     applyFilters();
//   }
// }
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import '../models/job_model.dart';

class JobsController extends GetxController {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  RxList<JobModel> jobs = <JobModel>[].obs;
  RxList<JobModel> filteredJobs = <JobModel>[].obs;

  RxBool isLoading = true.obs;

  RxString searchQuery = ''.obs;
  RxString selectedExperience = ''.obs;
  RxString selectedWorkMode = ''.obs;

  Timer? _debounce;

  @override
  void onInit() {
    super.onInit();
    fetchJobs();
  }

  void fetchJobs() {
    _db
        .collection('jobs')
        .where('isActive', isEqualTo: true)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .listen((snapshot) {
          final list = snapshot.docs
              .map((doc) => JobModel.fromFirestore(doc.data(), doc.id))
              .toList();

          jobs.value = list;
          applyFilters();
          isLoading.value = false;
        });
  }

  void onSearchChanged(String value) {
    searchQuery.value = value;

    if (_debounce?.isActive ?? false) _debounce!.cancel();

    _debounce = Timer(const Duration(milliseconds: 350), () {
      applyFilters();
    });
  }

  void clearSearch() {
    searchQuery.value = '';
    applyFilters();
  }

  void applyFilters() {
    final q = searchQuery.value.toLowerCase();
    final exp = selectedExperience.value.toLowerCase();
    final mode = selectedWorkMode.value.toLowerCase();

    filteredJobs.value = jobs.where((job) {
      final matchesSearch =
          q.isEmpty ||
          job.jobTitle.toLowerCase().contains(q) ||
          job.companyName.toLowerCase().contains(q) ||
          job.location.toLowerCase().contains(q);

      final matchesExp =
          exp.isEmpty || job.experience.toLowerCase().contains(exp);

      final matchesMode =
          mode.isEmpty || job.workMode.toLowerCase().contains(mode);

      return matchesSearch && matchesExp && matchesMode;
    }).toList();
  }

  void resetFilters() {
    selectedExperience.value = '';
    selectedWorkMode.value = '';
    applyFilters();
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import '../models/job_model.dart';

class JobsController extends GetxController {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  RxList<JobModel> jobs = <JobModel>[].obs;
  RxBool isLoading = true.obs;

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
          jobs.value = snapshot.docs
              .map((doc) => JobModel.fromFirestore(doc.data(), doc.id))
              .toList();

          isLoading.value = false;
        });
  }
}

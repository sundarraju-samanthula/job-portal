import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'package:jobportal/app.dart';
//import 'package:jobportal/controller/saved_jobs_controller.dart';
import 'package:jobportal/firebase_options.dart';
import 'package:jobportal/jobseeker/controller/auth_controller.dart';
import 'package:jobportal/jobseeker/controller/jobs_controller.dart';
import 'package:jobportal/jobseeker/controller/saved_jobs_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // Register AuthController globally
  Get.put(AuthController(), permanent: true);
  Get.put(JobsController(), permanent: true);
  Get.put(SavedJobsController(), permanent: true);
  await GetStorage.init();

  runApp(const JobFinderApp());
}

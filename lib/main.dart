import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';

import 'package:jobportal/app.dart';
import 'package:jobportal/controller/auth_controller.dart';
import 'package:jobportal/controller/jobs_controller.dart';
import 'package:jobportal/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // Register AuthController globally
  Get.put(AuthController(), permanent: true);
  Get.put(JobsController(), permanent: true);

  runApp(const JobFinderApp());
}

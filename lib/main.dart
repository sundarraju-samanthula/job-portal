// import 'package:flutter/material.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:get/get.dart';

// import 'package:jobportal/app.dart';
// import 'package:jobportal/controller/auth_controller.dart';
// import 'package:jobportal/firebase_options.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();

//   await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

//   // Register AuthController globally
//   Get.put(AuthController(), permanent: true);

//   runApp(const JobFinderApp());
// }
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:jobportal/features/personal/personal_details.dart';
import 'firebase_options.dart';
//import 'features/personal_details/personal_details_screen.dart';
import 'app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  const bool isWebDemo = true; // 🔴 SET FALSE FOR REAL BUILD

  if (isWebDemo) {
    runApp(
      const GetMaterialApp(
        debugShowCheckedModeBanner: false,
        home: PersonalDetailsScreen(),
      ),
    );
  } else {
    runApp(const JobFinderApp());
  }
}

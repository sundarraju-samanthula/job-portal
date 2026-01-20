// // import 'package:flutter/material.dart';
// // import 'package:get/get.dart';
// // import 'package:jobportal/jobseeker/features/home/home.dart';
// // import 'package:jobportal/jobseeker/features/login/login.dart';
// // import 'package:jobportal/jobseeker/features/onboarding/onboarding_screen.dart';
// // import 'package:jobportal/jobseeker/features/personal/personal_details.dart';
// // import 'package:jobportal/jobseeker/features/role_selection/role_selection.dart';
// // import 'package:jobportal/jobseeker/features/splash/splash_screen.dart';

// // // FEATURES
// // //import 'features/jobs/job_list_screen.dart';

// // class JobFinderApp extends StatelessWidget {
// //   const JobFinderApp({super.key});

// //   @override
// //   Widget build(BuildContext context) {
// //     return GetMaterialApp(
// //       debugShowCheckedModeBanner: false,
// //       title: 'Job Portal',

// //       /// 🌈 Optional theme (you can enhance later)
// //       theme: ThemeData(
// //         useMaterial3: true,
// //         scaffoldBackgroundColor: const Color(0xFFF8FAFF),
// //         colorSchemeSeed: Colors.blue,
// //       ),

// //       /// 🚀 App always starts from Splash
// //       initialRoute: '/',

// //       getPages: [
// //         /// SPLASH
// //         GetPage(name: '/', page: () => const SplashScreen()),

// //         /// ONBOARDING
// //         GetPage(name: '/onboarding', page: () => const OnboardingScreen()),

// //         /// ROLE SELECTION
// //         GetPage(name: '/role', page: () => const RoleSelectionScreen()),

// //         /// LOGIN
// //         GetPage(name: '/login', page: () => const LoginScreen()),

// //         /// PERSONAL DETAILS (ONLY FOR NEW USERS)
// //         GetPage(
// //           name: '/personal-details',
// //           page: () => const PersonalDetailsScreen(),
// //         ),

// //         /// HOME / JOB LIST
// //         GetPage(name: '/home', page: () => const HomeShell()),
// //       ],

// //       /// 🛟 Safety: if route not found
// //       unknownRoute: GetPage(
// //         name: '/not-found',
// //         page: () => const Scaffold(
// //           body: Center(
// //             child: Text('Page not found', style: TextStyle(fontSize: 18)),
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// // }
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// // JOB SEEKER
// import 'package:jobportal/jobseeker/features/home/home.dart';
// import 'package:jobportal/jobseeker/features/login/login.dart';
// import 'package:jobportal/jobseeker/features/onboarding/onboarding_screen.dart';
// import 'package:jobportal/jobseeker/features/personal/personal_details.dart';
// import 'package:jobportal/jobseeker/features/role_selection/role_selection.dart';
// import 'package:jobportal/jobseeker/features/splash/splash_screen.dart';
// import 'package:jobportal/serviceseeker/screens/home.dart';
// import 'package:jobportal/serviceseeker/screens/service_details.dart';
// import 'package:jobportal/serviceseeker/screens/service_login.dart';
// import 'package:jobportal/serviceseeker/screens/service_profile_screen.dart';

// // SERVICE FLOW (you will create these)

// class JobFinderApp extends StatelessWidget {
//   const JobFinderApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return GetMaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Job Portal',

//       theme: ThemeData(
//         useMaterial3: true,
//         scaffoldBackgroundColor: const Color(0xFFF8FAFF),
//         colorSchemeSeed: Colors.blue,
//       ),

//       /// 🚀 Start from Splash
//       initialRoute: '/',

//       getPages: [
//         // ---------------- SPLASH & ONBOARDING ----------------
//         GetPage(name: '/', page: () => const SplashScreen()),
//         GetPage(name: '/onboarding', page: () => const OnboardingScreen()),

//         // ---------------- ROLE SELECTION ----------------
//         GetPage(name: '/role', page: () => const RoleSelectionScreen()),

//         // ---------------- JOB SEEKER FLOW ----------------
//         GetPage(name: '/login', page: () => const LoginScreen()),
//         GetPage(
//           name: '/personal-details',
//           page: () => const PersonalDetailsScreen(),
//         ),
//         GetPage(name: '/home', page: () => const HomeShell()),

//         // ---------------- SERVICE FLOW ----------------
//         GetPage(name: '/service-login', page: () => const ServiceLoginScreen()),
//         GetPage(
//           name: '/service-details-form',
//           page: () => const ServiceDetailsFormScreen(),
//         ),
//         GetPage(name: '/service-home', page: () => const ServiceHomeScreen()),
//         GetPage(
//           name: '/service-profile',
//           page: () => const ServiceProfileScreen(),
//         ),
//       ],

//       /// 🛟 Safety
//       unknownRoute: GetPage(
//         name: '/not-found',
//         page: () => const Scaffold(
//           body: Center(
//             child: Text('Page not found', style: TextStyle(fontSize: 18)),
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ---------------- JOB SEEKER ----------------
import 'package:jobportal/jobseeker/features/home/home.dart';
import 'package:jobportal/jobseeker/features/login/login.dart';
import 'package:jobportal/jobseeker/features/onboarding/onboarding_screen.dart';
import 'package:jobportal/jobseeker/features/personal/personal_details.dart';
import 'package:jobportal/jobseeker/features/role_selection/role_selection.dart';
import 'package:jobportal/jobseeker/features/splash/splash_screen.dart';

// ---------------- SERVICE SEEKER ----------------
import 'package:jobportal/serviceseeker/screens/home.dart';
import 'package:jobportal/serviceseeker/screens/service_details.dart';
import 'package:jobportal/serviceseeker/screens/service_login.dart';
import 'package:jobportal/serviceseeker/screens/service_profile_screen.dart';
import 'package:jobportal/serviceseeker/screens/woker_profile_screen.dart';
//import 'package:jobportal/serviceseeker/screens/worker_profile_screen.dart';

class JobFinderApp extends StatelessWidget {
  const JobFinderApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Job Portal',

      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFFF8FAFF),
        colorSchemeSeed: Colors.blue,
      ),

      /// 🚀 App always starts from Splash
      initialRoute: '/',

      getPages: [
        // ---------------- SPLASH & ONBOARDING ----------------
        GetPage(name: '/', page: () => const SplashScreen()),
        GetPage(name: '/onboarding', page: () => const OnboardingScreen()),

        // ---------------- ROLE SELECTION ----------------
        GetPage(name: '/role', page: () => const RoleSelectionScreen()),

        // ---------------- JOB SEEKER FLOW ----------------
        GetPage(name: '/login', page: () => const LoginScreen()),
        GetPage(
          name: '/personal-details',
          page: () => const PersonalDetailsScreen(),
        ),
        GetPage(name: '/home', page: () => const HomeShell()),

        // ---------------- SERVICE SEEKER FLOW ----------------
        GetPage(name: '/service-login', page: () => const ServiceLoginScreen()),
        GetPage(
          name: '/service-details-form',
          page: () => const ServiceDetailsFormScreen(),
        ),
        GetPage(name: '/service-home', page: () => const ServiceHomeScreen()),

        // ---------------- SERVICE PROFILE ----------------
        GetPage(
          name: '/service-profile',
          page: () => const ServiceProfileScreen(),
        ),

        // ---------------- WORKER PROFILE + REVIEWS ----------------
        GetPage(
          name: '/worker-profile',
          page: () {
            final worker = Get.arguments;
            return WorkerProfileScreen(worker: worker);
          },
        ),
      ],

      /// 🛟 Fallback
      unknownRoute: GetPage(
        name: '/not-found',
        page: () => const Scaffold(
          body: Center(
            child: Text('Page not found', style: TextStyle(fontSize: 18)),
          ),
        ),
      ),
    );
  }
}

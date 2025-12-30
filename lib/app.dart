import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jobportal/features/personal/personal_details.dart';

import 'features/splash/splash_screen.dart';
import 'features/onboarding/onboarding_screen.dart';
import 'features/role_selection/role_selection.dart';
import 'features/login/login.dart';
//import 'features/personal_details/personal_details_screen.dart';
import 'features/jobs/jobs_list_screen.dart';

class JobFinderApp extends StatelessWidget {
  const JobFinderApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,

      // App always starts from Splash
      initialRoute: '/',

      getPages: [
        GetPage(name: '/', page: () => const SplashScreen()),

        GetPage(name: '/onboarding', page: () => const OnboardingScreen()),

        GetPage(name: '/role', page: () => const RoleSelectionScreen()),

        GetPage(name: '/login', page: () => const LoginScreen()),

        // NEW USERS ONLY
        GetPage(
          name: '/personal-details',
          page: () => const PersonalDetailsScreen(),
        ),

        // HOME / JOB LIST
        GetPage(name: '/home', page: () => const JobListScreen()),
      ],
    );
  }
}

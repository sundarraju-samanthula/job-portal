import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jobportal/features/jobs/jobs_list_screen.dart';
import 'package:jobportal/features/role_selection/role_selection.dart';
import 'features/splash/splash_screen.dart';
import 'features/onboarding/onboarding_screen.dart';

class JobFinderApp extends StatelessWidget {
  const JobFinderApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: () => const SplashScreen()),
        GetPage(name: '/onboarding', page: () => const OnboardingScreen()),
        GetPage(name: '/jobs', page: () => const JobListScreen()),
        GetPage(name: '/role', page: () => const RoleSelectionScreen()),

        // later → jobs route
      ],
    );
  }
}

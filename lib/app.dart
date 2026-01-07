import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jobportal/features/home/home.dart';

// FEATURES
import 'features/splash/splash_screen.dart';
import 'features/onboarding/onboarding_screen.dart';
import 'features/role_selection/role_selection.dart';
import 'features/login/login.dart';
import 'features/personal/personal_details.dart';
//import 'features/jobs/job_list_screen.dart';

class JobFinderApp extends StatelessWidget {
  const JobFinderApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Job Portal',

      /// 🌈 Optional theme (you can enhance later)
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFFF8FAFF),
        colorSchemeSeed: Colors.blue,
      ),

      /// 🚀 App always starts from Splash
      initialRoute: '/',

      getPages: [
        /// SPLASH
        GetPage(name: '/', page: () => const SplashScreen()),

        /// ONBOARDING
        GetPage(name: '/onboarding', page: () => const OnboardingScreen()),

        /// ROLE SELECTION
        GetPage(name: '/role', page: () => const RoleSelectionScreen()),

        /// LOGIN
        GetPage(name: '/login', page: () => const LoginScreen()),

        /// PERSONAL DETAILS (ONLY FOR NEW USERS)
        GetPage(
          name: '/personal-details',
          page: () => const PersonalDetailsScreen(),
        ),

        /// HOME / JOB LIST
        GetPage(name: '/home', page: () => const HomeShell()),
      ],

      /// 🛟 Safety: if route not found
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

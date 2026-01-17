// import 'package:flutter/material.dart';
// import 'package:jobportal/features/applications/application_screen.dart';
// import 'package:jobportal/features/jobs/job_list_screen.dart';
// //import 'package:jobportal/features/applications/applications_screen.dart';
// import 'package:jobportal/features/notifications/notification_screen.dart';
// //import 'package:jobportal/features/notifications/notifications_screen.dart';
// import 'package:jobportal/features/profile/profile_screen.dart';

// class HomeShell extends StatefulWidget {
//   const HomeShell({super.key});

//   @override
//   State<HomeShell> createState() => _HomeShellState();
// }

// class _HomeShellState extends State<HomeShell> {
//   int _currentIndex = 0;

//   final pages = const [
//     JobListScreen(),
//     ApplicationsScreen(),
//     NotificationsScreen(),
//     ProfileScreen(),
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: pages[_currentIndex],
//       bottomNavigationBar: BottomNavigationBar(
//         currentIndex: _currentIndex,
//         onTap: (i) => setState(() => _currentIndex = i),
//         type: BottomNavigationBarType.fixed,
//         selectedItemColor: const Color(0xFF2563EB),
//         unselectedItemColor: Colors.grey,
//         items: const [
//           BottomNavigationBarItem(
//             icon: Icon(Icons.work_outline),
//             label: 'Jobs',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.description_outlined),
//             label: 'Applications',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.notifications_none),
//             label: 'Notifications',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.person_outline),
//             label: 'Profile',
//           ),
//         ],
//       ),
//     );
//   }
// }

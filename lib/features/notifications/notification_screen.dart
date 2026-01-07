// import 'package:flutter/material.dart';

// class NotificationsScreen extends StatelessWidget {
//   const NotificationsScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           /// HEADER
//           const Padding(
//             padding: EdgeInsets.all(16),
//             child: Text(
//               'Notifications',
//               style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800),
//             ),
//           ),

//           /// EMPTY STATE
//           Expanded(
//             child: Center(
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   Icon(
//                     Icons.notifications_none,
//                     size: 80,
//                     color: Colors.grey.shade400,
//                   ),
//                   const SizedBox(height: 16),
//                   const Text(
//                     'No notifications',
//                     style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
//                   ),
//                   const SizedBox(height: 8),
//                   Text(
//                     'You’ll be notified about job updates',
//                     style: TextStyle(color: Colors.grey.shade600),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:jobportal/controller/jobs_controller.dart';
// import 'package:jobportal/features/home/job_card.dart';
// import 'package:jobportal/models/job_model.dart';
// import '../controllers/jobs_controller.dart';
// import '../models/job_model.dart';

// class JobListScreen extends StatelessWidget {
//   const JobListScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final JobsController controller = Get.put(JobsController());

//     return Container(
//       decoration: const BoxDecoration(
//         gradient: LinearGradient(
//           begin: Alignment.topCenter,
//           end: Alignment.bottomCenter,
//           colors: [Color(0xFFF7FAFF), Color(0xFFEFF4FF)],
//         ),
//       ),
//       child: SafeArea(
//         child: Column(
//           children: [
//             const SizedBox(height: 18),

//             /// HEADER
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 22),
//               child: Row(
//                 children: const [
//                   Expanded(
//                     child: Text(
//                       'Find Jobs',
//                       style: TextStyle(
//                         fontSize: 26,
//                         fontWeight: FontWeight.w800,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),

//             const SizedBox(height: 16),
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 22),
//               child: _GlassSearchBar(),
//             ),
//             const SizedBox(height: 22),

//             /// JOB LIST
//             Expanded(
//               child: Obx(() {
//                 if (controller.isLoading.value) {
//                   return const Center(child: CircularProgressIndicator());
//                 }

//                 if (controller.jobs.isEmpty) {
//                   return const Center(child: Text('No jobs available'));
//                 }

//                 return ListView.builder(
//                   padding: const EdgeInsets.symmetric(horizontal: 22),
//                   itemCount: controller.jobs.length,
//                   itemBuilder: (context, index) {
//                     final JobModel job = controller.jobs[index];

//                     return AnimatedJobCard(
//                       index: index,
//                       job: job,
//                     );
//                   },
//                 );
//               }),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// // import 'package:flutter/material.dart';
// // import 'dart:math' as math;

// // class JobListScreen extends StatefulWidget {
// //   const JobListScreen({super.key});

// //   @override
// //   State<JobListScreen> createState() => _JobListScreenState();
// // }

// // class _JobListScreenState extends State<JobListScreen>
// //     with SingleTickerProviderStateMixin {
// //   late AnimationController _controller;

// //   final List<_Job> _jobs = [
// //     _Job(
// //       title: 'Flutter Developer',
// //       company: 'ABC Technologies',
// //       location: 'Chennai, Tamil Nadu',
// //       type: 'Remote',
// //       category: 'Technical',
// //       source: 'LinkedIn',
// //     ),
// //     _Job(
// //       title: 'UI/UX Designer',
// //       company: 'Creative Studio',
// //       location: 'Bangalore, Karnataka',
// //       type: 'Hybrid',
// //       category: 'Design',
// //       source: 'Naukri',
// //     ),
// //     _Job(
// //       title: 'HR Executive',
// //       company: 'Global Corp',
// //       location: 'Coimbatore, Tamil Nadu',
// //       type: 'Onsite',
// //       category: 'Non-Technical',
// //       source: 'Internshala',
// //     ),
// //   ];

// //   @override
// //   void initState() {
// //     super.initState();
// //     _controller = AnimationController(
// //       vsync: this,
// //       duration: const Duration(milliseconds: 900),
// //     )..forward();
// //   }

// //   @override
// //   void dispose() {
// //     _controller.dispose();
// //     super.dispose();
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       backgroundColor: const Color(0xFFF6F8FC),
// //       appBar: AppBar(
// //         elevation: 0,
// //         backgroundColor: Colors.white,
// //         title: const Text('Jobs', style: TextStyle(color: Colors.black)),
// //         centerTitle: true,
// //       ),
// //       body: ListView.builder(
// //         padding: const EdgeInsets.all(16),
// //         itemCount: _jobs.length,
// //         itemBuilder: (context, index) {
// //           final animation = CurvedAnimation(
// //             parent: _controller,
// //             curve: Interval(
// //               index / _jobs.length,
// //               math.min(1.0, (index + 1) / _jobs.length),
// //               curve: Curves.easeOut,
// //             ),
// //           );

// //           return FadeTransition(
// //             opacity: animation,
// //             child: SlideTransition(
// //               position: Tween<Offset>(
// //                 begin: const Offset(0, 0.1),
// //                 end: Offset.zero,
// //               ).animate(animation),
// //               child: _JobCard(job: _jobs[index]),
// //             ),
// //           );
// //         },
// //       ),
// //     );
// //   }
// // }

// // /* -------------------------------------------------------------------------- */
// // /*                                JOB CARD                                    */
// // /* -------------------------------------------------------------------------- */

// // class _JobCard extends StatelessWidget {
// //   final _Job job;

// //   const _JobCard({required this.job});

// //   @override
// //   Widget build(BuildContext context) {
// //     return Container(
// //       margin: const EdgeInsets.only(bottom: 16),
// //       padding: const EdgeInsets.all(16),
// //       decoration: BoxDecoration(
// //         color: Colors.white,
// //         borderRadius: BorderRadius.circular(20),
// //         boxShadow: [
// //           BoxShadow(
// //             color: Colors.black.withOpacity(0.05),
// //             blurRadius: 16,
// //             offset: const Offset(0, 8),
// //           ),
// //         ],
// //       ),
// //       child: Column(
// //         crossAxisAlignment: CrossAxisAlignment.start,
// //         children: [
// //           // Title & company
// //           Text(
// //             job.title,
// //             style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
// //           ),
// //           const SizedBox(height: 6),
// //           Text(
// //             job.company,
// //             style: const TextStyle(fontSize: 14, color: Colors.black54),
// //           ),

// //           const SizedBox(height: 14),

// //           // Tags
// //           Wrap(
// //             spacing: 8,
// //             runSpacing: 8,
// //             children: [
// //               _Tag(text: job.type),
// //               _Tag(text: job.category),
// //               _Tag(text: job.location),
// //             ],
// //           ),

// //           const SizedBox(height: 18),

// //           // Footer
// //           Row(
// //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //             children: [
// //               Text(
// //                 job.source,
// //                 style: const TextStyle(fontSize: 13, color: Colors.black45),
// //               ),
// //               ElevatedButton(
// //                 onPressed: () {
// //                   // Phase 1: external redirect (later)
// //                 },
// //                 style: ElevatedButton.styleFrom(
// //                   backgroundColor: const Color(0xFF1A73E8),
// //                   shape: RoundedRectangleBorder(
// //                     borderRadius: BorderRadius.circular(14),
// //                   ),
// //                 ),
// //                 child: const Text('Apply'),
// //               ),
// //             ],
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// // }

// // /* -------------------------------------------------------------------------- */
// // /*                                   TAG                                      */
// // /* -------------------------------------------------------------------------- */

// // class _Tag extends StatelessWidget {
// //   final String text;

// //   const _Tag({required this.text});

// //   @override
// //   Widget build(BuildContext context) {
// //     return Container(
// //       padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
// //       decoration: BoxDecoration(
// //         color: const Color(0xFF1A73E8).withOpacity(0.1),
// //         borderRadius: BorderRadius.circular(12),
// //       ),
// //       child: Text(
// //         text,
// //         style: const TextStyle(
// //           fontSize: 12,
// //           color: Color(0xFF1A73E8),
// //           fontWeight: FontWeight.w500,
// //         ),
// //       ),
// //     );
// //   }
// // }

// // /* -------------------------------------------------------------------------- */
// // /*                                   MODEL                                    */
// // /* -------------------------------------------------------------------------- */

// // class _Job {
// //   final String title;
// //   final String company;
// //   final String location;
// //   final String type;
// //   final String category;
// //   final String source;

// //   const _Job({
// //     required this.title,
// //     required this.company,
// //     required this.location,
// //     required this.type,
// //     required this.category,
// //     required this.source,
// //   });
// // }
// import 'package:flutter/material.dart';

// class JobListScreen extends StatelessWidget {
//   const JobListScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Column(
//         children: [
//           /// 🔍 SEARCH BAR
//           Padding(
//             padding: const EdgeInsets.all(16),
//             child: Row(
//               children: [
//                 Expanded(
//                   child: Container(
//                     height: 48,
//                     padding: const EdgeInsets.symmetric(horizontal: 14),
//                     decoration: BoxDecoration(
//                       color: Colors.grey.shade100,
//                       borderRadius: BorderRadius.circular(14),
//                     ),
//                     child: const Row(
//                       children: [
//                         Icon(Icons.search, color: Colors.grey),
//                         SizedBox(width: 10),
//                         Text(
//                           'Search jobs...',
//                           style: TextStyle(color: Colors.grey),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//                 const SizedBox(width: 12),
//                 Container(
//                   height: 48,
//                   width: 48,
//                   decoration: BoxDecoration(
//                     border: Border.all(color: Colors.grey.shade300),
//                     borderRadius: BorderRadius.circular(14),
//                   ),
//                   child: const Icon(Icons.tune),
//                 ),
//               ],
//             ),
//           ),

//           /// 📋 JOB LIST
//           Expanded(
//             child: ListView(
//               padding: const EdgeInsets.symmetric(horizontal: 16),
//               children: const [
//                 JobCard(
//                   title: 'Senior React Developer',
//                   company: 'Tech Corp',
//                   location: 'Mumbai, Maharashtra',
//                   tag: 'Remote',
//                 ),
//                 JobCard(
//                   title: 'Product Manager',
//                   company: 'StartUp Inc',
//                   location: 'Bangalore, Karnataka',
//                   tag: 'Hybrid',
//                 ),
//                 JobCard(
//                   title: 'Full Stack Developer',
//                   company: 'Digital Solutions',
//                   location: 'Remote',
//                   tag: 'WFH',
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class JobCard extends StatelessWidget {
//   final String title;
//   final String company;
//   final String location;
//   final String tag;

//   const JobCard({
//     super.key,
//     required this.title,
//     required this.company,
//     required this.location,
//     required this.tag,
//   });

//   Color get tagColor {
//     switch (tag) {
//       case 'Remote':
//         return Colors.blue;
//       case 'Hybrid':
//         return Colors.purple;
//       case 'WFH':
//         return Colors.green;
//       default:
//         return Colors.grey;
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: const EdgeInsets.only(bottom: 16),
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(18),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.05),
//             blurRadius: 10,
//             offset: const Offset(0, 6),
//           ),
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Expanded(
//                 child: Text(
//                   title,
//                   style: const TextStyle(
//                     fontSize: 16,
//                     fontWeight: FontWeight.w700,
//                   ),
//                 ),
//               ),
//               Container(
//                 padding: const EdgeInsets.symmetric(
//                   horizontal: 10,
//                   vertical: 4,
//                 ),
//                 decoration: BoxDecoration(
//                   color: tagColor.withOpacity(0.15),
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//                 child: Text(
//                   tag,
//                   style: TextStyle(
//                     fontSize: 12,
//                     color: tagColor,
//                     fontWeight: FontWeight.w600,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//           const SizedBox(height: 8),
//           Row(
//             children: [
//               const Icon(Icons.business, size: 16, color: Colors.grey),
//               const SizedBox(width: 6),
//               Text(company),
//             ],
//           ),
//           const SizedBox(height: 4),
//           Row(
//             children: [
//               const Icon(Icons.location_on, size: 16, color: Colors.grey),
//               const SizedBox(width: 6),
//               Text(location),
//             ],
//           ),
//           const SizedBox(height: 10),
//           const Text(
//             'Looking for experienced developer',
//             style: TextStyle(color: Colors.grey),
//           ),
//           const SizedBox(height: 14),
//           SizedBox(
//             width: double.infinity,
//             height: 44,
//             child: ElevatedButton(
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: Colors.green,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(14),
//                 ),
//               ),
//               onPressed: () {},
//               child: const Text(
//                 'Apply Now',
//                 style: TextStyle(fontWeight: FontWeight.w600),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

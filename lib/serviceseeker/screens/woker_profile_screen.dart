// // // // // // // import 'package:flutter/material.dart';
// // // // // // // import 'package:get/get.dart';
// // // // // // // import 'package:jobportal/serviceseeker/controller/worker_profile_controller.dart';
// // // // // // // import '../model/worker_model.dart';
// // // // // // // //import '../controller/worker_profile_controller.dart';
// // // // // // // import 'package:url_launcher/url_launcher.dart';

// // // // // // // class WorkerProfileScreen extends StatelessWidget {
// // // // // // //   const WorkerProfileScreen({super.key});

// // // // // // //   @override
// // // // // // //   Widget build(BuildContext context) {
// // // // // // //     final WorkerModel worker = Get.arguments;
// // // // // // //     final controller = Get.put(WorkerProfileController(worker.id));

// // // // // // //     return Scaffold(
// // // // // // //       backgroundColor: const Color(0xFFF7FAFF),
// // // // // // //       appBar: AppBar(
// // // // // // //         title: const Text("Worker Profile"),
// // // // // // //         backgroundColor: Colors.white,
// // // // // // //         foregroundColor: Colors.black,
// // // // // // //         elevation: 0,
// // // // // // //       ),
// // // // // // //       body: Obx(() {
// // // // // // //         if (controller.isLoading.value) {
// // // // // // //           return const Center(child: CircularProgressIndicator());
// // // // // // //         }

// // // // // // //         return SingleChildScrollView(
// // // // // // //           padding: const EdgeInsets.all(20),
// // // // // // //           child: Column(
// // // // // // //             children: [
// // // // // // //               Hero(
// // // // // // //                 tag: worker.id,
// // // // // // //                 child: CircleAvatar(
// // // // // // //                   radius: 60,
// // // // // // //                   backgroundImage: worker.photoUrl.isNotEmpty
// // // // // // //                       ? NetworkImage(worker.photoUrl)
// // // // // // //                       : null,
// // // // // // //                   child: worker.photoUrl.isEmpty
// // // // // // //                       ? const Icon(Icons.person, size: 50)
// // // // // // //                       : null,
// // // // // // //                 ),
// // // // // // //               ),

// // // // // // //               const SizedBox(height: 16),

// // // // // // //               Text(
// // // // // // //                 worker.name,
// // // // // // //                 style: const TextStyle(
// // // // // // //                   fontSize: 22,
// // // // // // //                   fontWeight: FontWeight.w800,
// // // // // // //                 ),
// // // // // // //               ),

// // // // // // //               const SizedBox(height: 6),

// // // // // // //               Text(
// // // // // // //                 '${worker.skill} • ${worker.experience}',
// // // // // // //                 style: const TextStyle(color: Colors.black54),
// // // // // // //               ),

// // // // // // //               const SizedBox(height: 6),

// // // // // // //               Text(
// // // // // // //                 '₹${worker.chargePerDay}/day • ${worker.location}',
// // // // // // //                 style: const TextStyle(
// // // // // // //                   color: Color(0xFF2563EB),
// // // // // // //                   fontWeight: FontWeight.w600,
// // // // // // //                 ),
// // // // // // //               ),

// // // // // // //               const SizedBox(height: 12),

// // // // // // //               Row(
// // // // // // //                 mainAxisAlignment: MainAxisAlignment.center,
// // // // // // //                 children: [
// // // // // // //                   const Icon(Icons.star, color: Colors.amber),
// // // // // // //                   const SizedBox(width: 4),
// // // // // // //                   Text(
// // // // // // //                     worker.averageRating.toStringAsFixed(1),
// // // // // // //                     style: const TextStyle(fontWeight: FontWeight.w700),
// // // // // // //                   ),
// // // // // // //                   const SizedBox(width: 6),
// // // // // // //                   Text(
// // // // // // //                     '(${worker.totalReviews} reviews)',
// // // // // // //                     style: const TextStyle(color: Colors.black54),
// // // // // // //                   ),
// // // // // // //                 ],
// // // // // // //               ),

// // // // // // //               const SizedBox(height: 20),

// // // // // // //               Row(
// // // // // // //                 children: [
// // // // // // //                   Expanded(
// // // // // // //                     child: ElevatedButton.icon(
// // // // // // //                       onPressed: () async {
// // // // // // //                         final url = Uri.parse('tel:${worker.phone}');
// // // // // // //                         if (await canLaunchUrl(url)) {
// // // // // // //                           launchUrl(url);
// // // // // // //                         }
// // // // // // //                       },
// // // // // // //                       icon: const Icon(Icons.call),
// // // // // // //                       label: const Text("Call"),
// // // // // // //                       style: ElevatedButton.styleFrom(
// // // // // // //                         backgroundColor: Colors.green,
// // // // // // //                         shape: RoundedRectangleBorder(
// // // // // // //                           borderRadius: BorderRadius.circular(14),
// // // // // // //                         ),
// // // // // // //                       ),
// // // // // // //                     ),
// // // // // // //                   ),
// // // // // // //                   const SizedBox(width: 12),
// // // // // // //                   Expanded(
// // // // // // //                     child: ElevatedButton.icon(
// // // // // // //                       onPressed: () async {
// // // // // // //                         final url = Uri.parse(
// // // // // // //                           'https://wa.me/${worker.whatsapp}',
// // // // // // //                         );
// // // // // // //                         if (await canLaunchUrl(url)) {
// // // // // // //                           launchUrl(url);
// // // // // // //                         }
// // // // // // //                       },
// // // // // // //                       icon: const Icon(Icons.chat),
// // // // // // //                       label: const Text("WhatsApp"),
// // // // // // //                       style: ElevatedButton.styleFrom(
// // // // // // //                         backgroundColor: Colors.teal,
// // // // // // //                         shape: RoundedRectangleBorder(
// // // // // // //                           borderRadius: BorderRadius.circular(14),
// // // // // // //                         ),
// // // // // // //                       ),
// // // // // // //                     ),
// // // // // // //                   ),
// // // // // // //                 ],
// // // // // // //               ),

// // // // // // //               const SizedBox(height: 30),

// // // // // // //               /// REVIEWS
// // // // // // //               const Align(
// // // // // // //                 alignment: Alignment.centerLeft,
// // // // // // //                 child: Text(
// // // // // // //                   "Reviews",
// // // // // // //                   style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
// // // // // // //                 ),
// // // // // // //               ),

// // // // // // //               const SizedBox(height: 12),

// // // // // // //               if (controller.reviews.isEmpty) const Text("No reviews yet"),

// // // // // // //               ...controller.reviews.map(
// // // // // // //                 (r) => Container(
// // // // // // //                   margin: const EdgeInsets.only(bottom: 12),
// // // // // // //                   padding: const EdgeInsets.all(14),
// // // // // // //                   decoration: BoxDecoration(
// // // // // // //                     color: Colors.white,
// // // // // // //                     borderRadius: BorderRadius.circular(14),
// // // // // // //                     boxShadow: [
// // // // // // //                       BoxShadow(
// // // // // // //                         color: Colors.black.withOpacity(0.05),
// // // // // // //                         blurRadius: 10,
// // // // // // //                         offset: const Offset(0, 6),
// // // // // // //                       ),
// // // // // // //                     ],
// // // // // // //                   ),
// // // // // // //                   child: Column(
// // // // // // //                     crossAxisAlignment: CrossAxisAlignment.start,
// // // // // // //                     children: [
// // // // // // //                       Row(
// // // // // // //                         children: [
// // // // // // //                           Text(
// // // // // // //                             r.userName,
// // // // // // //                             style: const TextStyle(fontWeight: FontWeight.w700),
// // // // // // //                           ),
// // // // // // //                           const Spacer(),
// // // // // // //                           Row(
// // // // // // //                             children: [
// // // // // // //                               const Icon(
// // // // // // //                                 Icons.star,
// // // // // // //                                 color: Colors.amber,
// // // // // // //                                 size: 16,
// // // // // // //                               ),
// // // // // // //                               const SizedBox(width: 2),
// // // // // // //                               Text(r.rating.toString()),
// // // // // // //                             ],
// // // // // // //                           ),
// // // // // // //                         ],
// // // // // // //                       ),
// // // // // // //                       const SizedBox(height: 6),
// // // // // // //                       Text(r.comment),
// // // // // // //                     ],
// // // // // // //                   ),
// // // // // // //                 ),
// // // // // // //               ),
// // // // // // //             ],
// // // // // // //           ),
// // // // // // //         );
// // // // // // //       }),
// // // // // // //     );
// // // // // // //   }
// // // // // // // }
// // // // // // import 'package:flutter/material.dart';
// // // // // // import 'package:get/get.dart';
// // // // // // import 'package:jobportal/serviceseeker/model/review_model.dart';
// // // // // // import 'package:jobportal/serviceseeker/screens/add_review_sheet.dart';
// // // // // // import '../model/worker_model.dart';
// // // // // // import '../controller/worker_profile_controller.dart';
// // // // // // //import '../widgets/add_review_sheet.dart';

// // // // // // class WorkerProfileScreen extends StatelessWidget {
// // // // // //   final WorkerModel worker;
// // // // // //   const WorkerProfileScreen({super.key, required this.worker});

// // // // // //   @override
// // // // // //   Widget build(BuildContext context) {
// // // // // //     final controller = Get.put(WorkerProfileController(worker.id));

// // // // // //     return Scaffold(
// // // // // //       backgroundColor: const Color(0xFFF7FAFF),
// // // // // //       appBar: AppBar(
// // // // // //         title: Text(worker.name),
// // // // // //         backgroundColor: Colors.white,
// // // // // //         foregroundColor: Colors.black,
// // // // // //         elevation: 0,
// // // // // //       ),
// // // // // //       floatingActionButton: FloatingActionButton(
// // // // // //         onPressed: () {
// // // // // //           Get.bottomSheet(
// // // // // //             AddReviewSheet(controller: controller),
// // // // // //             isScrollControlled: true,
// // // // // //           );
// // // // // //         },
// // // // // //         child: const Icon(Icons.rate_review),
// // // // // //       ),
// // // // // //       body: Column(
// // // // // //         children: [
// // // // // //           _Header(worker: worker),
// // // // // //           Expanded(
// // // // // //             child: Obx(() {
// // // // // //               if (controller.isLoading.value) {
// // // // // //                 return const Center(child: CircularProgressIndicator());
// // // // // //               }

// // // // // //               if (controller.reviews.isEmpty) {
// // // // // //                 return const Center(child: Text("No reviews yet"));
// // // // // //               }

// // // // // //               return ListView.builder(
// // // // // //                 padding: const EdgeInsets.all(20),
// // // // // //                 itemCount: controller.reviews.length,
// // // // // //                 itemBuilder: (_, i) {
// // // // // //                   final r = controller.reviews[i];
// // // // // //                   return _ReviewTile(review: r);
// // // // // //                 },
// // // // // //               );
// // // // // //             }),
// // // // // //           ),
// // // // // //         ],
// // // // // //       ),
// // // // // //     );
// // // // // //   }
// // // // // // }

// // // // // // class _Header extends StatelessWidget {
// // // // // //   final WorkerModel worker;
// // // // // //   const _Header({required this.worker});

// // // // // //   @override
// // // // // //   Widget build(BuildContext context) {
// // // // // //     return Container(
// // // // // //       padding: const EdgeInsets.all(20),
// // // // // //       child: Row(
// // // // // //         children: [
// // // // // //           Hero(
// // // // // //             tag: worker.id,
// // // // // //             child: CircleAvatar(
// // // // // //               radius: 40,
// // // // // //               backgroundImage: worker.photoUrl.isNotEmpty
// // // // // //                   ? NetworkImage(worker.photoUrl)
// // // // // //                   : null,
// // // // // //               child: worker.photoUrl.isEmpty
// // // // // //                   ? const Icon(Icons.person, size: 30)
// // // // // //                   : null,
// // // // // //             ),
// // // // // //           ),
// // // // // //           const SizedBox(width: 16),
// // // // // //           Expanded(
// // // // // //             child: Column(
// // // // // //               crossAxisAlignment: CrossAxisAlignment.start,
// // // // // //               children: [
// // // // // //                 Text(
// // // // // //                   worker.name,
// // // // // //                   style: const TextStyle(
// // // // // //                     fontSize: 20,
// // // // // //                     fontWeight: FontWeight.w800,
// // // // // //                   ),
// // // // // //                 ),
// // // // // //                 const SizedBox(height: 4),
// // // // // //                 Text(
// // // // // //                   "${worker.skill} • ${worker.experience}",
// // // // // //                   style: const TextStyle(color: Colors.black54),
// // // // // //                 ),
// // // // // //                 const SizedBox(height: 6),
// // // // // //                 Row(
// // // // // //                   children: [
// // // // // //                     _StarRow(rating: worker.averageRating),
// // // // // //                     const SizedBox(width: 6),
// // // // // //                     Text("(${worker.totalReviews})"),
// // // // // //                   ],
// // // // // //                 ),
// // // // // //               ],
// // // // // //             ),
// // // // // //           ),
// // // // // //         ],
// // // // // //       ),
// // // // // //     );
// // // // // //   }
// // // // // // }

// // // // // // class _StarRow extends StatelessWidget {
// // // // // //   final double rating;
// // // // // //   const _StarRow({required this.rating});

// // // // // //   @override
// // // // // //   Widget build(BuildContext context) {
// // // // // //     return Row(
// // // // // //       children: List.generate(5, (i) {
// // // // // //         return Icon(
// // // // // //           i < rating.round() ? Icons.star : Icons.star_border,
// // // // // //           size: 18,
// // // // // //           color: Colors.amber,
// // // // // //         );
// // // // // //       }),
// // // // // //     );
// // // // // //   }
// // // // // // }

// // // // // // class _ReviewTile extends StatelessWidget {
// // // // // //   final ReviewModel review;
// // // // // //   const _ReviewTile({required this.review});

// // // // // //   @override
// // // // // //   Widget build(BuildContext context) {
// // // // // //     return Container(
// // // // // //       margin: const EdgeInsets.only(bottom: 14),
// // // // // //       padding: const EdgeInsets.all(14),
// // // // // //       decoration: BoxDecoration(
// // // // // //         color: Colors.white,
// // // // // //         borderRadius: BorderRadius.circular(14),
// // // // // //         boxShadow: [
// // // // // //           BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10),
// // // // // //         ],
// // // // // //       ),
// // // // // //       child: Column(
// // // // // //         crossAxisAlignment: CrossAxisAlignment.start,
// // // // // //         children: [
// // // // // //           Text(
// // // // // //             review.userName,
// // // // // //             style: const TextStyle(fontWeight: FontWeight.w700),
// // // // // //           ),
// // // // // //           const SizedBox(height: 4),
// // // // // //           _StarRow(rating: review.rating),
// // // // // //           const SizedBox(height: 6),
// // // // // //           Text(review.comment),
// // // // // //         ],
// // // // // //       ),
// // // // // //     );
// // // // // //   }
// // // // // //import 'package:flutter/material.dart';
// // // // // import 'package:flutter/material.dart';
// // // // // import 'package:get/get.dart';
// // // // // import 'package:jobportal/serviceseeker/screens/add_review_sheet.dart';
// // // // // import '../controller/worker_profile_controller.dart';
// // // // // import '../model/worker_model.dart';
// // // // // //import '../widgets/add_review_sheet.dart';

// // // // // class WorkerProfileScreen extends StatelessWidget {
// // // // //   final WorkerModel worker;

// // // // //   const WorkerProfileScreen({super.key, required this.worker});

// // // // //   @override
// // // // //   Widget build(BuildContext context) {
// // // // //     final controller = Get.put(WorkerProfileController(worker.id));

// // // // //     return Scaffold(
// // // // //       appBar: AppBar(title: Text(worker.name)),
// // // // //       body: Obx(() {
// // // // //         if (controller.isLoading.value) {
// // // // //           return const Center(child: CircularProgressIndicator());
// // // // //         }

// // // // //         return SingleChildScrollView(
// // // // //           padding: const EdgeInsets.all(20),
// // // // //           child: Column(
// // // // //             crossAxisAlignment: CrossAxisAlignment.start,
// // // // //             children: [
// // // // //               /// IMAGE
// // // // //               Center(
// // // // //                 child: Hero(
// // // // //                   tag: worker.id,
// // // // //                   child: CircleAvatar(
// // // // //                     radius: 60,
// // // // //                     backgroundImage: worker.photoUrl.isNotEmpty
// // // // //                         ? NetworkImage(worker.photoUrl)
// // // // //                         : null,
// // // // //                     child: worker.photoUrl.isEmpty
// // // // //                         ? const Icon(Icons.person, size: 60)
// // // // //                         : null,
// // // // //                   ),
// // // // //                 ),
// // // // //               ),

// // // // //               const SizedBox(height: 20),

// // // // //               /// NAME
// // // // //               Center(
// // // // //                 child: Text(
// // // // //                   worker.name,
// // // // //                   style: const TextStyle(
// // // // //                     fontSize: 22,
// // // // //                     fontWeight: FontWeight.w800,
// // // // //                   ),
// // // // //                 ),
// // // // //               ),

// // // // //               const SizedBox(height: 6),

// // // // //               /// SKILL
// // // // //               Center(
// // // // //                 child: Text(
// // // // //                   '${worker.skill} • ${worker.experience}',
// // // // //                   style: const TextStyle(color: Colors.black54),
// // // // //                 ),
// // // // //               ),

// // // // //               const SizedBox(height: 12),

// // // // //               /// RATING
// // // // //               Center(
// // // // //                 child: Column(
// // // // //                   children: [
// // // // //                     _Stars(controller.averageRating.value),
// // // // //                     const SizedBox(height: 4),
// // // // //                     Text(
// // // // //                       controller.averageRating.value.toStringAsFixed(1),
// // // // //                       style: const TextStyle(fontWeight: FontWeight.w700),
// // // // //                     ),
// // // // //                   ],
// // // // //                 ),
// // // // //               ),

// // // // //               const SizedBox(height: 30),

// // // // //               /// REVIEWS HEADER
// // // // //               Row(
// // // // //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
// // // // //                 children: [
// // // // //                   const Text(
// // // // //                     "Reviews",
// // // // //                     style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
// // // // //                   ),
// // // // //                   ElevatedButton.icon(
// // // // //                     onPressed: () {
// // // // //                       Get.bottomSheet(
// // // // //                         AddReviewSheet(controller: controller),
// // // // //                         isScrollControlled: true,
// // // // //                       );
// // // // //                     },
// // // // //                     icon: const Icon(Icons.add),
// // // // //                     label: const Text("Add"),
// // // // //                   ),
// // // // //                 ],
// // // // //               ),

// // // // //               const SizedBox(height: 16),

// // // // //               /// REVIEWS LIST
// // // // //               if (controller.reviews.isEmpty)
// // // // //                 const Center(child: Text("No reviews yet")),

// // // // //               ...controller.reviews.map(
// // // // //                 (r) => _ReviewTile(
// // // // //                   name: r.userName,
// // // // //                   rating: r.rating,
// // // // //                   comment: r.comment,
// // // // //                   date: r.createdAt,
// // // // //                 ),
// // // // //               ),
// // // // //             ],
// // // // //           ),
// // // // //         );
// // // // //       }),
// // // // //     );
// // // // //   }
// // // // // }

// // // // // class _Stars extends StatelessWidget {
// // // // //   final double rating;
// // // // //   const _Stars(this.rating);

// // // // //   @override
// // // // //   Widget build(BuildContext context) {
// // // // //     return Row(
// // // // //       mainAxisSize: MainAxisSize.min,
// // // // //       children: List.generate(5, (i) {
// // // // //         if (i < rating.floor()) {
// // // // //           return const Icon(Icons.star, color: Colors.amber);
// // // // //         } else if (i < rating) {
// // // // //           return const Icon(Icons.star_half, color: Colors.amber);
// // // // //         } else {
// // // // //           return const Icon(Icons.star_border, color: Colors.amber);
// // // // //         }
// // // // //       }),
// // // // //     );
// // // // //   }
// // // // // }

// // // // // class _ReviewTile extends StatelessWidget {
// // // // //   final String name;
// // // // //   final double rating;
// // // // //   final String comment;
// // // // //   final DateTime date;

// // // // //   const _ReviewTile({
// // // // //     required this.name,
// // // // //     required this.rating,
// // // // //     required this.comment,
// // // // //     required this.date,
// // // // //   });

// // // // //   @override
// // // // //   Widget build(BuildContext context) {
// // // // //     return Container(
// // // // //       margin: const EdgeInsets.only(bottom: 14),
// // // // //       padding: const EdgeInsets.all(16),
// // // // //       decoration: BoxDecoration(
// // // // //         color: Colors.white,
// // // // //         borderRadius: BorderRadius.circular(14),
// // // // //         boxShadow: [
// // // // //           BoxShadow(
// // // // //             color: Colors.black.withOpacity(0.05),
// // // // //             blurRadius: 10,
// // // // //             offset: const Offset(0, 6),
// // // // //           ),
// // // // //         ],
// // // // //       ),
// // // // //       child: Column(
// // // // //         crossAxisAlignment: CrossAxisAlignment.start,
// // // // //         children: [
// // // // //           /// NAME + STARS
// // // // //           Row(
// // // // //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
// // // // //             children: [
// // // // //               Text(name, style: const TextStyle(fontWeight: FontWeight.w700)),
// // // // //               _Stars(rating),
// // // // //             ],
// // // // //           ),

// // // // //           const SizedBox(height: 6),

// // // // //           /// COMMENT
// // // // //           Text(comment),

// // // // //           const SizedBox(height: 6),

// // // // //           /// DATE
// // // // //           Text(
// // // // //             "${date.day}/${date.month}/${date.year}",
// // // // //             style: const TextStyle(fontSize: 12, color: Colors.grey),
// // // // //           ),
// // // // //         ],
// // // // //       ),
// // // // //     );
// // // // //   }
// // // // // }

// // // // // // class _ReviewTile extends StatelessWidget {
// // // // // //   final ReviewModel review;

// // // // // //   const _ReviewTile({required this.review});

// // // // // //   @override
// // // // // //   Widget build(BuildContext context) {
// // // // // //     return Container(
// // // // // //       margin: const EdgeInsets.only(bottom: 12),
// // // // // //       padding: const EdgeInsets.all(14),
// // // // // //       decoration: BoxDecoration(
// // // // // //         color: Colors.white,
// // // // // //         borderRadius: BorderRadius.circular(14),
// // // // // //         boxShadow: [
// // // // // //           BoxShadow(
// // // // // //             color: Colors.black.withOpacity(0.05),
// // // // // //             blurRadius: 12,
// // // // // //             offset: const Offset(0, 6),
// // // // // //           ),
// // // // // //         ],
// // // // // //       ),
// // // // // //       child: Column(
// // // // // //         crossAxisAlignment: CrossAxisAlignment.start,
// // // // // //         children: [
// // // // // //           Text(
// // // // // //             review.userName,
// // // // // //             style: const TextStyle(fontWeight: FontWeight.w700),
// // // // // //           ),
// // // // // //           const SizedBox(height: 4),
// // // // // //           Row(
// // // // // //             children: List.generate(
// // // // // //               5,
// // // // // //               (index) => Icon(
// // // // // //                 Icons.star,
// // // // // //                 size: 16,
// // // // // //                 color: index < review.rating ? Colors.amber : Colors.grey,
// // // // // //               ),
// // // // // //             ),
// // // // // //           ),
// // // // // //           const SizedBox(height: 6),
// // // // // //           Text(review.comment),
// // // // // //         ],
// // // // // //       ),
// // // // // //     );
// // // // // //   }
// // // // // // }

// // // // // class _Header extends StatelessWidget {
// // // // //   final WorkerModel worker;
// // // // //   const _Header({required this.worker});

// // // // //   @override
// // // // //   Widget build(BuildContext context) {
// // // // //     return Container(
// // // // //       padding: const EdgeInsets.all(20),
// // // // //       child: Row(
// // // // //         children: [
// // // // //           Hero(
// // // // //             tag: worker.id,
// // // // //             child: CircleAvatar(
// // // // //               radius: 40,
// // // // //               backgroundImage: worker.photoUrl.isNotEmpty
// // // // //                   ? NetworkImage(worker.photoUrl)
// // // // //                   : null,
// // // // //               child: worker.photoUrl.isEmpty
// // // // //                   ? const Icon(Icons.person, size: 30)
// // // // //                   : null,
// // // // //             ),
// // // // //           ),
// // // // //           const SizedBox(width: 16),
// // // // //           Expanded(
// // // // //             child: Column(
// // // // //               crossAxisAlignment: CrossAxisAlignment.start,
// // // // //               children: [
// // // // //                 Text(
// // // // //                   worker.name,
// // // // //                   style: const TextStyle(
// // // // //                     fontSize: 20,
// // // // //                     fontWeight: FontWeight.w800,
// // // // //                   ),
// // // // //                 ),
// // // // //                 const SizedBox(height: 4),
// // // // //                 Text(
// // // // //                   "${worker.skill} • ${worker.experience}",
// // // // //                   style: const TextStyle(color: Colors.black54),
// // // // //                 ),
// // // // //                 const SizedBox(height: 6),
// // // // //                 Row(
// // // // //                   children: [
// // // // //                     _StarRow(rating: worker.averageRating),
// // // // //                     const SizedBox(width: 6),
// // // // //                     Text("(${worker.totalReviews})"),
// // // // //                   ],
// // // // //                 ),
// // // // //               ],
// // // // //             ),
// // // // //           ),
// // // // //         ],
// // // // //       ),
// // // // //     );
// // // // //   }
// // // // // }

// // // // // class _StarRow extends StatelessWidget {
// // // // //   final double rating;
// // // // //   const _StarRow({required this.rating});

// // // // //   @override
// // // // //   Widget build(BuildContext context) {
// // // // //     return Row(
// // // // //       children: List.generate(5, (i) {
// // // // //         return Icon(
// // // // //           i < rating.round() ? Icons.star : Icons.star_border,
// // // // //           size: 18,
// // // // //           color: Colors.amber,
// // // // //         );
// // // // //       }),
// // // // //     );
// // // // //   }
// // // // // }
// // // // import 'package:flutter/material.dart';
// // // // import 'package:get/get.dart';
// // // // import 'package:jobportal/serviceseeker/model/review_model.dart';
// // // // import 'package:jobportal/serviceseeker/model/worker_model.dart';
// // // // //import 'package:jobportal/serviceseeker/screens/add_review_sheet.dart';
// // // // import '../controller/worker_profile_controller.dart';

// // // // class WorkerProfileScreen extends StatelessWidget {
// // // //   final WorkerModel worker;

// // // //   const WorkerProfileScreen({super.key, required this.worker});

// // // //   @override
// // // //   Widget build(BuildContext context) {
// // // //     final controller = Get.put(WorkerProfileController());
// // // //     controller.init(worker.id);

// // // //     return Scaffold(
// // // //       appBar: AppBar(title: Text(worker.name)),
// // // //       body: Obx(() {
// // // //         if (controller.isLoading.value) {
// // // //           return const Center(child: CircularProgressIndicator());
// // // //         }

// // // //         return SingleChildScrollView(
// // // //           padding: const EdgeInsets.all(20),
// // // //           child: Column(
// // // //             children: [
// // // //               CircleAvatar(radius: 50),
// // // //               const SizedBox(height: 10),
// // // //               Text(
// // // //                 worker.name,
// // // //                 style: const TextStyle(
// // // //                   fontSize: 22,
// // // //                   fontWeight: FontWeight.bold,
// // // //                 ),
// // // //               ),
// // // //               const SizedBox(height: 6),

// // // //               Obx(
// // // //                 () => Row(
// // // //                   mainAxisAlignment: MainAxisAlignment.center,
// // // //                   children: [
// // // //                     const Icon(Icons.star, color: Colors.amber),
// // // //                     const SizedBox(width: 4),
// // // //                     Text(
// // // //                       controller.averageRating.value.toStringAsFixed(1),
// // // //                       style: const TextStyle(fontWeight: FontWeight.bold),
// // // //                     ),
// // // //                     const SizedBox(width: 6),
// // // //                     Text(
// // // //                       "(${controller.totalReviews.value})",
// // // //                       style: const TextStyle(color: Colors.grey),
// // // //                     ),
// // // //                   ],
// // // //                 ),
// // // //               ),

// // // //               const SizedBox(height: 20),

// // // //               Align(
// // // //                 alignment: Alignment.centerLeft,
// // // //                 child: Row(
// // // //                   children: [
// // // //                     const Text(
// // // //                       "Reviews",
// // // //                       style: TextStyle(
// // // //                         fontSize: 18,
// // // //                         fontWeight: FontWeight.bold,
// // // //                       ),
// // // //                     ),
// // // //                     const Spacer(),
// // // //                     ElevatedButton.icon(
// // // //                       onPressed: () {
// // // //                         Get.bottomSheet(
// // // //                           AddReviewSheet(controller: controller),
// // // //                           isScrollControlled: true,
// // // //                         );
// // // //                       },
// // // //                       icon: const Icon(Icons.add),
// // // //                       label: const Text("Add"),
// // // //                     ),
// // // //                   ],
// // // //                 ),
// // // //               ),

// // // //               const SizedBox(height: 12),

// // // //               Obx(() {
// // // //                 if (controller.reviews.isEmpty) {
// // // //                   return const Text("No reviews yet");
// // // //                 }

// // // //                 return Column(
// // // //                   children: controller.reviews
// // // //                       .map((r) => ReviewTile(review: r))
// // // //                       .toList(),
// // // //                 );
// // // //               }),
// // // //             ],
// // // //           ),
// // // //         );
// // // //       }),
// // // //     );
// // // //   }
// // // // }

// // // // class AddReviewSheet extends StatefulWidget {
// // // //   final WorkerProfileController controller;
// // // //   const AddReviewSheet({super.key, required this.controller});

// // // //   @override
// // // //   State<AddReviewSheet> createState() => _AddReviewSheetState();
// // // // }

// // // // class _AddReviewSheetState extends State<AddReviewSheet> {
// // // //   double rating = 5;
// // // //   final commentCtrl = TextEditingController();
// // // //   bool isSubmitting = false;

// // // //   @override
// // // //   Widget build(BuildContext context) {
// // // //     return Padding(
// // // //       padding: EdgeInsets.only(
// // // //         left: 20,
// // // //         right: 20,
// // // //         top: 20,
// // // //         bottom: MediaQuery.of(context).viewInsets.bottom + 20,
// // // //       ),
// // // //       child: Column(
// // // //         mainAxisSize: MainAxisSize.min,
// // // //         children: [
// // // //           const Text(
// // // //             "Add Review",
// // // //             style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
// // // //           ),
// // // //           const SizedBox(height: 16),

// // // //           /// ⭐ Star Input
// // // //           StarInput(
// // // //             value: rating,
// // // //             onChanged: (v) => setState(() => rating = v),
// // // //           ),

// // // //           const SizedBox(height: 16),

// // // //           /// ✍ Comment
// // // //           TextField(
// // // //             controller: commentCtrl,
// // // //             maxLines: 3,
// // // //             decoration: const InputDecoration(
// // // //               hintText: "Write your experience...",
// // // //               border: OutlineInputBorder(),
// // // //             ),
// // // //           ),

// // // //           const SizedBox(height: 16),

// // // //           /// 🔘 Submit Button
// // // //           SizedBox(
// // // //             width: double.infinity,
// // // //             child: ElevatedButton(
// // // //               onPressed: isSubmitting
// // // //                   ? null
// // // //                   : () async {
// // // //                       if (commentCtrl.text.trim().isEmpty) {
// // // //                         Get.snackbar(
// // // //                           "Error",
// // // //                           "Please write a comment",
// // // //                           snackPosition: SnackPosition.BOTTOM,
// // // //                         );
// // // //                         return;
// // // //                       }

// // // //                       setState(() => isSubmitting = true);

// // // //                       await widget.controller.addReview(
// // // //                         userId: "demoUser",
// // // //                         userName: "User",
// // // //                         rating: rating,
// // // //                         comment: commentCtrl.text.trim(),
// // // //                       );

// // // //                       // ✅ Close bottom sheet
// // // //                       Get.back();

// // // //                       // ✅ Success message
// // // //                       Get.snackbar(
// // // //                         "Success",
// // // //                         "Review added successfully",
// // // //                         snackPosition: SnackPosition.BOTTOM,
// // // //                         backgroundColor: Colors.green,
// // // //                         colorText: Colors.white,
// // // //                       );

// // // //                       setState(() => isSubmitting = false);
// // // //                     },
// // // //               child: isSubmitting
// // // //                   ? const SizedBox(
// // // //                       height: 22,
// // // //                       width: 22,
// // // //                       child: CircularProgressIndicator(
// // // //                         strokeWidth: 2,
// // // //                         color: Colors.white,
// // // //                       ),
// // // //                     )
// // // //                   : const Text("Submit"),
// // // //             ),
// // // //           ),
// // // //         ],
// // // //       ),
// // // //     );
// // // //   }
// // // // }

// // // // class StarInput extends StatelessWidget {
// // // //   final double value;
// // // //   final Function(double) onChanged;

// // // //   const StarInput({super.key, required this.value, required this.onChanged});

// // // //   @override
// // // //   Widget build(BuildContext context) {
// // // //     return Row(
// // // //       mainAxisAlignment: MainAxisAlignment.center,
// // // //       children: List.generate(5, (index) {
// // // //         final starValue = index + 1.0;
// // // //         return IconButton(
// // // //           icon: Icon(
// // // //             value >= starValue ? Icons.star : Icons.star_border,
// // // //             color: Colors.amber,
// // // //           ),
// // // //           onPressed: () => onChanged(starValue),
// // // //         );
// // // //       }),
// // // //     );
// // // //   }
// // // // }

// // // // class ReviewTile extends StatelessWidget {
// // // //   final ReviewModel review;

// // // //   const ReviewTile({super.key, required this.review});

// // // //   @override
// // // //   Widget build(BuildContext context) {
// // // //     return Container(
// // // //       margin: const EdgeInsets.only(bottom: 12),
// // // //       padding: const EdgeInsets.all(14),
// // // //       decoration: BoxDecoration(
// // // //         color: Colors.white,
// // // //         borderRadius: BorderRadius.circular(16),
// // // //         boxShadow: [
// // // //           BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10),
// // // //         ],
// // // //       ),
// // // //       child: Column(
// // // //         crossAxisAlignment: CrossAxisAlignment.start,
// // // //         children: [
// // // //           Text(
// // // //             review.userName,
// // // //             style: const TextStyle(fontWeight: FontWeight.bold),
// // // //           ),
// // // //           const SizedBox(height: 4),

// // // //           Row(
// // // //             children: List.generate(
// // // //               5,
// // // //               (i) => Icon(
// // // //                 i < review.rating ? Icons.star : Icons.star_border,
// // // //                 size: 16,
// // // //                 color: Colors.amber,
// // // //               ),
// // // //             ),
// // // //           ),

// // // //           if (review.comment.isNotEmpty) ...[
// // // //             const SizedBox(height: 6),
// // // //             Text(review.comment),
// // // //           ],
// // // //         ],
// // // //       ),
// // // //     );
// // // //   }
// // // // }
// // // import 'package:flutter/material.dart';
// // // import 'package:get/get.dart';
// // // import 'package:jobportal/serviceseeker/model/review_model.dart';
// // // import 'package:jobportal/serviceseeker/model/worker_model.dart';
// // // //import 'package:jobportal/serviceseeker/screens/add_review_sheet.dart';
// // // import '../controller/worker_profile_controller.dart';

// // // class WorkerProfileScreen extends StatelessWidget {
// // //   final WorkerModel worker;

// // //   const WorkerProfileScreen({super.key, required this.worker});

// // //   @override
// // //   Widget build(BuildContext context) {
// // //     final controller = Get.put(WorkerProfileController());
// // //     controller.init(worker.id);

// // //     return Scaffold(
// // //       appBar: AppBar(title: Text(worker.name)),
// // //       body: Obx(() {
// // //         if (controller.isLoading.value) {
// // //           return const Center(child: CircularProgressIndicator());
// // //         }

// // //         return SingleChildScrollView(
// // //           padding: const EdgeInsets.all(20),
// // //           child: Column(
// // //             children: [
// // //               CircleAvatar(radius: 50),
// // //               const SizedBox(height: 10),
// // //               Text(
// // //                 worker.name,
// // //                 style: const TextStyle(
// // //                   fontSize: 22,
// // //                   fontWeight: FontWeight.bold,
// // //                 ),
// // //               ),
// // //               const SizedBox(height: 6),

// // //               Obx(
// // //                 () => Row(
// // //                   mainAxisAlignment: MainAxisAlignment.center,
// // //                   children: [
// // //                     const Icon(Icons.star, color: Colors.amber),
// // //                     const SizedBox(width: 4),
// // //                     Text(
// // //                       controller.averageRating.value.toStringAsFixed(1),
// // //                       style: const TextStyle(fontWeight: FontWeight.bold),
// // //                     ),
// // //                     const SizedBox(width: 6),
// // //                     Text(
// // //                       "(${controller.totalReviews.value})",
// // //                       style: const TextStyle(color: Colors.grey),
// // //                     ),
// // //                   ],
// // //                 ),
// // //               ),

// // //               const SizedBox(height: 20),

// // //               Align(
// // //                 alignment: Alignment.centerLeft,
// // //                 child: Row(
// // //                   children: [
// // //                     const Text(
// // //                       "Reviews",
// // //                       style: TextStyle(
// // //                         fontSize: 18,
// // //                         fontWeight: FontWeight.bold,
// // //                       ),
// // //                     ),
// // //                     const Spacer(),
// // //                     ElevatedButton.icon(
// // //                       onPressed: () {
// // //                         Get.bottomSheet(
// // //                           AddReviewSheet(controller: controller),
// // //                           isScrollControlled: true,
// // //                         );
// // //                       },
// // //                       icon: const Icon(Icons.add),
// // //                       label: const Text("Add"),
// // //                     ),
// // //                   ],
// // //                 ),
// // //               ),

// // //               const SizedBox(height: 12),

// // //               Obx(() {
// // //                 if (controller.reviews.isEmpty) {
// // //                   return const Text("No reviews yet");
// // //                 }

// // //                 return Column(
// // //                   children: controller.reviews
// // //                       .map((r) => ReviewTile(review: r))
// // //                       .toList(),
// // //                 );
// // //               }),
// // //             ],
// // //           ),
// // //         );
// // //       }),
// // //     );
// // //   }
// // // }

// // // class AddReviewSheet extends StatefulWidget {
// // //   final WorkerProfileController controller;
// // //   const AddReviewSheet({super.key, required this.controller});

// // //   @override
// // //   State<AddReviewSheet> createState() => _AddReviewSheetState();
// // // }

// // // class _AddReviewSheetState extends State<AddReviewSheet> {
// // //   double rating = 5;
// // //   final commentCtrl = TextEditingController();
// // //   bool isSubmitting = false;

// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return Padding(
// // //       padding: EdgeInsets.only(
// // //         left: 20,
// // //         right: 20,
// // //         top: 20,
// // //         bottom: MediaQuery.of(context).viewInsets.bottom + 20,
// // //       ),
// // //       child: Column(
// // //         mainAxisSize: MainAxisSize.min,
// // //         children: [
// // //           const Text(
// // //             "Add Review",
// // //             style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
// // //           ),
// // //           const SizedBox(height: 16),

// // //           /// ⭐ Star Input
// // //           StarInput(
// // //             value: rating,
// // //             onChanged: (v) => setState(() => rating = v),
// // //           ),

// // //           const SizedBox(height: 16),

// // //           /// ✍ Comment
// // //           TextField(
// // //             controller: commentCtrl,
// // //             maxLines: 3,
// // //             decoration: const InputDecoration(
// // //               hintText: "Write your experience...",
// // //               border: OutlineInputBorder(),
// // //             ),
// // //           ),

// // //           const SizedBox(height: 16),

// // //           /// 🔘 Submit Button
// // //           SizedBox(
// // //             width: double.infinity,
// // //             child: ElevatedButton(
// // //               onPressed: isSubmitting
// // //                   ? null
// // //                   : () async {
// // //                       if (commentCtrl.text.trim().isEmpty) {
// // //                         Get.snackbar(
// // //                           "Error",
// // //                           "Please write a comment",
// // //                           snackPosition: SnackPosition.BOTTOM,
// // //                         );
// // //                         return;
// // //                       }

// // //                       setState(() => isSubmitting = true);

// // //                       await widget.controller.addReview(
// // //                         userId: "demoUser",
// // //                         userName: "User",
// // //                         rating: rating,
// // //                         comment: commentCtrl.text.trim(),
// // //                       );

// // //                       // ✅ Close bottom sheet
// // //                       Get.back();

// // //                       // ✅ Success message
// // //                       Get.snackbar(
// // //                         "Success",
// // //                         "Review added successfully",
// // //                         snackPosition: SnackPosition.BOTTOM,
// // //                         backgroundColor: Colors.green,
// // //                         colorText: Colors.white,
// // //                       );

// // //                       setState(() => isSubmitting = false);
// // //                     },
// // //               child: isSubmitting
// // //                   ? const SizedBox(
// // //                       height: 22,
// // //                       width: 22,
// // //                       child: CircularProgressIndicator(
// // //                         strokeWidth: 2,
// // //                         color: Colors.white,
// // //                       ),
// // //                     )
// // //                   : const Text("Submit"),
// // //             ),
// // //           ),
// // //         ],
// // //       ),
// // //     );
// // //   }
// // // }

// // // class StarInput extends StatelessWidget {
// // //   final double value;
// // //   final Function(double) onChanged;

// // //   const StarInput({super.key, required this.value, required this.onChanged});

// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return Row(
// // //       mainAxisAlignment: MainAxisAlignment.center,
// // //       children: List.generate(5, (index) {
// // //         final starValue = index + 1.0;
// // //         return IconButton(
// // //           icon: Icon(
// // //             value >= starValue ? Icons.star : Icons.star_border,
// // //             color: Colors.amber,
// // //           ),
// // //           onPressed: () => onChanged(starValue),
// // //         );
// // //       }),
// // //     );
// // //   }
// // // }

// // // class ReviewTile extends StatelessWidget {
// // //   final ReviewModel review;

// // //   const ReviewTile({super.key, required this.review});

// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return Container(
// // //       margin: const EdgeInsets.only(bottom: 12),
// // //       padding: const EdgeInsets.all(14),
// // //       decoration: BoxDecoration(
// // //         color: Colors.white,
// // //         borderRadius: BorderRadius.circular(16),
// // //         boxShadow: [
// // //           BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10),
// // //         ],
// // //       ),
// // //       child: Column(
// // //         crossAxisAlignment: CrossAxisAlignment.start,
// // //         children: [
// // //           Text(
// // //             review.userName,
// // //             style: const TextStyle(fontWeight: FontWeight.bold),
// // //           ),
// // //           const SizedBox(height: 4),

// // //           Row(
// // //             children: List.generate(
// // //               5,
// // //               (i) => Icon(
// // //                 i < review.rating ? Icons.star : Icons.star_border,
// // //                 size: 16,
// // //                 color: Colors.amber,
// // //               ),
// // //             ),
// // //           ),

// // //           if (review.comment.isNotEmpty) ...[
// // //             const SizedBox(height: 6),
// // //             Text(review.comment),
// // //           ],
// // //         ],
// // //       ),
// // //     );
// // //   }
// // // }
// // import 'package:flutter/material.dart';
// // import 'package:get/get_core/src/get_main.dart';
// // import 'package:get/get_instance/src/extension_instance.dart';
// // import 'package:get/get_navigation/src/extension_navigation.dart';
// // import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
// // import 'package:jobportal/serviceseeker/controller/worker_profile_controller.dart';
// // import 'package:jobportal/serviceseeker/model/review_model.dart';
// // import 'package:jobportal/serviceseeker/model/worker_model.dart';

// // class WorkerProfileScreen extends StatelessWidget {
// //   final WorkerModel worker;

// //   const WorkerProfileScreen({super.key, required this.worker});

// //   @override
// //   Widget build(BuildContext context) {
// //     final controller = Get.put(WorkerProfileController(worker.id));

// //     return Scaffold(
// //       appBar: AppBar(title: Text(worker.name)),
// //       body: Obx(() {
// //         if (controller.isLoading.value) {
// //           return const Center(child: CircularProgressIndicator());
// //         }

// //         return SingleChildScrollView(
// //           padding: const EdgeInsets.all(20),
// //           child: Column(
// //             children: [
// //               const CircleAvatar(radius: 50),
// //               const SizedBox(height: 10),

// //               Text(
// //                 worker.name,
// //                 style: const TextStyle(
// //                   fontSize: 22,
// //                   fontWeight: FontWeight.bold,
// //                 ),
// //               ),

// //               const SizedBox(height: 6),

// //               Row(
// //                 mainAxisAlignment: MainAxisAlignment.center,
// //                 children: [
// //                   const Icon(Icons.star, color: Colors.amber),
// //                   const SizedBox(width: 4),
// //                   Text(
// //                     controller.averageRating.value.toStringAsFixed(1),
// //                     style: const TextStyle(fontWeight: FontWeight.bold),
// //                   ),
// //                   const SizedBox(width: 6),
// //                   Text(
// //                     "(${controller.totalReviews.value})",
// //                     style: const TextStyle(color: Colors.grey),
// //                   ),
// //                 ],
// //               ),

// //               const SizedBox(height: 20),

// //               Row(
// //                 children: [
// //                   const Text(
// //                     "Reviews",
// //                     style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
// //                   ),
// //                   const Spacer(),
// //                   ElevatedButton.icon(
// //                     onPressed: () {
// //                       Get.bottomSheet(
// //                         AddReviewSheet(controller: controller),
// //                         isScrollControlled: true,
// //                       );
// //                     },
// //                     icon: const Icon(Icons.add),
// //                     label: const Text("Add"),
// //                   ),
// //                 ],
// //               ),

// //               const SizedBox(height: 12),

// //               Obx(() {
// //                 if (controller.reviews.isEmpty) {
// //                   return const Text("No reviews yet");
// //                 }

// //                 return Column(
// //                   children: controller.reviews
// //                       .map((r) => ReviewTile(review: r))
// //                       .toList(),
// //                 );
// //               }),
// //             ],
// //           ),
// //         );
// //       }),
// //     );
// //   }
// // }

// // class AddReviewSheet extends StatefulWidget {
// //   final WorkerProfileController controller;
// //   const AddReviewSheet({super.key, required this.controller});

// //   @override
// //   State<AddReviewSheet> createState() => _AddReviewSheetState();
// // }

// // class _AddReviewSheetState extends State<AddReviewSheet> {
// //   double rating = 5;
// //   final commentCtrl = TextEditingController();
// //   bool isSubmitting = false;

// //   @override
// //   Widget build(BuildContext context) {
// //     return Padding(
// //       padding: EdgeInsets.only(
// //         left: 20,
// //         right: 20,
// //         top: 20,
// //         bottom: MediaQuery.of(context).viewInsets.bottom + 20,
// //       ),
// //       child: Column(
// //         mainAxisSize: MainAxisSize.min,
// //         children: [
// //           const Text(
// //             "Add Review",
// //             style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
// //           ),

// //           const SizedBox(height: 16),

// //           StarInput(
// //             value: rating,
// //             onChanged: (v) => setState(() => rating = v),
// //           ),

// //           const SizedBox(height: 16),

// //           TextField(
// //             controller: commentCtrl,
// //             maxLines: 3,
// //             decoration: const InputDecoration(
// //               hintText: "Write your experience...",
// //               border: OutlineInputBorder(),
// //             ),
// //           ),

// //           const SizedBox(height: 16),

// //           SizedBox(
// //             width: double.infinity,
// //             child: ElevatedButton(
// //               onPressed: isSubmitting
// //                   ? null
// //                   : () async {
// //                       if (commentCtrl.text.trim().isEmpty) {
// //                         Get.snackbar("Error", "Please write a comment");
// //                         return;
// //                       }

// //                       setState(() => isSubmitting = true);

// //                       await widget.controller.addReview(
// //                         userId: "demoUser",
// //                         userName: "User",
// //                         rating: rating,
// //                         comment: commentCtrl.text.trim(),
// //                       );

// //                       Get.back();

// //                       Get.snackbar(
// //                         "Success",
// //                         "Review added successfully",
// //                         backgroundColor: Colors.green,
// //                         colorText: Colors.white,
// //                       );

// //                       setState(() => isSubmitting = false);
// //                     },
// //               child: isSubmitting
// //                   ? const CircularProgressIndicator(color: Colors.white)
// //                   : const Text("Submit"),
// //             ),
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// // }

// // class ReviewTile extends StatelessWidget {
// //   final ReviewModel review;

// //   const ReviewTile({super.key, required this.review});

// //   @override
// //   Widget build(BuildContext context) {
// //     return Container(
// //       margin: const EdgeInsets.only(bottom: 12),
// //       padding: const EdgeInsets.all(14),
// //       decoration: BoxDecoration(
// //         color: Colors.white,
// //         borderRadius: BorderRadius.circular(16),
// //         boxShadow: [
// //           BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10),
// //         ],
// //       ),
// //       child: Column(
// //         crossAxisAlignment: CrossAxisAlignment.start,
// //         children: [
// //           Text(
// //             review.userName,
// //             style: const TextStyle(fontWeight: FontWeight.bold),
// //           ),
// //           const SizedBox(height: 4),

// //           Row(
// //             children: List.generate(
// //               5,
// //               (i) => Icon(
// //                 i < review.rating ? Icons.star : Icons.star_border,
// //                 size: 16,
// //                 color: Colors.amber,
// //               ),
// //             ),
// //           ),

// //           if (review.comment.isNotEmpty) ...[
// //             const SizedBox(height: 6),
// //             Text(review.comment),
// //           ],
// //         ],
// //       ),
// //     );
// //   }
// // }

// // class StarInput extends StatelessWidget {
// //   final double value;
// //   final Function(double) onChanged;

// //   const StarInput({super.key, required this.value, required this.onChanged});

// //   @override
// //   Widget build(BuildContext context) {
// //     return Row(
// //       mainAxisAlignment: MainAxisAlignment.center,
// //       children: List.generate(5, (index) {
// //         final starValue = index + 1.0;
// //         return IconButton(
// //           icon: Icon(
// //             value >= starValue ? Icons.star : Icons.star_border,
// //             color: Colors.amber,
// //           ),
// //           onPressed: () => onChanged(starValue),
// //         );
// //       }),
// //     );
// //   }
// // }
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../controller/worker_profile_controller.dart';
// import '../model/review_model.dart';
// import '../model/worker_model.dart';

// class WorkerProfileScreen extends StatelessWidget {
//   final WorkerModel worker;

//   const WorkerProfileScreen({super.key, required this.worker});

//   @override
//   Widget build(BuildContext context) {
//     final controller = Get.put(
//       WorkerProfileController(worker.id),
//       tag: worker.id,
//     );

//     return Scaffold(
//       appBar: AppBar(title: Text(worker.name)),
//       body: Obx(() {
//         if (controller.isLoading.value) {
//           return const Center(child: CircularProgressIndicator());
//         }

//         return SingleChildScrollView(
//           padding: const EdgeInsets.all(20),
//           child: Column(
//             children: [
//               CircleAvatar(radius: 50),
//               const SizedBox(height: 10),

//               Text(
//                 worker.name,
//                 style: const TextStyle(
//                   fontSize: 22,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),

//               const SizedBox(height: 6),

//               /// ⭐ Rating
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   const Icon(Icons.star, color: Colors.amber),
//                   const SizedBox(width: 4),
//                   Text(
//                     controller.averageRating.value.toStringAsFixed(1),
//                     style: const TextStyle(fontWeight: FontWeight.bold),
//                   ),
//                   const SizedBox(width: 6),
//                   Text(
//                     "(${controller.totalReviews.value})",
//                     style: const TextStyle(color: Colors.grey),
//                   ),
//                 ],
//               ),

//               const SizedBox(height: 20),

//               /// Reviews Header
//               Row(
//                 children: [
//                   const Text(
//                     "Reviews",
//                     style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                   ),
//                   const Spacer(),
//                   ElevatedButton.icon(
//                     onPressed: () {
//                       Get.bottomSheet(
//                         AddReviewSheet(controller: controller),
//                         isScrollControlled: true,
//                       );
//                     },
//                     icon: const Icon(Icons.add),
//                     label: const Text("Add"),
//                   ),
//                 ],
//               ),

//               const SizedBox(height: 12),

//               /// Reviews List
//               Obx(() {
//                 if (controller.reviews.isEmpty) {
//                   return const Padding(
//                     padding: EdgeInsets.all(20),
//                     child: Text("No reviews yet"),
//                   );
//                 }

//                 return Column(
//                   children: controller.reviews
//                       .map((r) => ReviewTile(review: r))
//                       .toList(),
//                 );
//               }),
//             ],
//           ),
//         );
//       }),
//     );
//   }
// }

// class AddReviewSheet extends StatefulWidget {
//   final WorkerProfileController controller;
//   const AddReviewSheet({super.key, required this.controller});

//   @override
//   State<AddReviewSheet> createState() => _AddReviewSheetState();
// }

// class _AddReviewSheetState extends State<AddReviewSheet> {
//   double rating = 5;
//   final commentCtrl = TextEditingController();
//   bool isSubmitting = false;

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.only(
//         left: 20,
//         right: 20,
//         top: 20,
//         bottom: MediaQuery.of(context).viewInsets.bottom + 20,
//       ),
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           const Text(
//             "Add Review",
//             style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
//           ),

//           const SizedBox(height: 16),

//           StarInput(
//             value: rating,
//             onChanged: (v) => setState(() => rating = v),
//           ),

//           const SizedBox(height: 16),

//           TextField(
//             controller: commentCtrl,
//             maxLines: 3,
//             decoration: const InputDecoration(
//               hintText: "Write your experience...",
//               border: OutlineInputBorder(),
//             ),
//           ),

//           const SizedBox(height: 16),

//           SizedBox(
//             width: double.infinity,
//             child: ElevatedButton(
//               onPressed: isSubmitting
//                   ? null
//                   : () async {
//                       if (commentCtrl.text.trim().isEmpty) {
//                         Get.snackbar("Error", "Please write a comment");
//                         return;
//                       }

//                       setState(() => isSubmitting = true);

//                       await widget.controller.addReview(
//                         userId: "demoUser",
//                         userName: "User",
//                         rating: rating,
//                         comment: commentCtrl.text.trim(),
//                       );

//                       Get.back();

//                       Get.snackbar(
//                         "Success",
//                         "Review added successfully",
//                         snackPosition: SnackPosition.BOTTOM,
//                         backgroundColor: Colors.green,
//                         colorText: Colors.white,
//                       );

//                       setState(() => isSubmitting = false);
//                     },
//               child: isSubmitting
//                   ? const SizedBox(
//                       height: 22,
//                       width: 22,
//                       child: CircularProgressIndicator(
//                         strokeWidth: 2,
//                         color: Colors.white,
//                       ),
//                     )
//                   : const Text("Submit"),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class StarInput extends StatelessWidget {
//   final double value;
//   final Function(double) onChanged;

//   const StarInput({super.key, required this.value, required this.onChanged});

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: List.generate(5, (index) {
//         final starValue = index + 1.0;
//         return IconButton(
//           icon: Icon(
//             value >= starValue ? Icons.star : Icons.star_border,
//             color: Colors.amber,
//           ),
//           onPressed: () => onChanged(starValue),
//         );
//       }),
//     );
//   }
// }

// class ReviewTile extends StatelessWidget {
//   final ReviewModel review;

//   const ReviewTile({super.key, required this.review});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: const EdgeInsets.only(bottom: 12),
//       padding: const EdgeInsets.all(14),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(16),
//         boxShadow: [
//           BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10),
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             review.userName,
//             style: const TextStyle(fontWeight: FontWeight.bold),
//           ),

//           const SizedBox(height: 4),

//           Row(
//             children: List.generate(
//               5,
//               (i) => Icon(
//                 i < review.rating ? Icons.star : Icons.star_border,
//                 size: 16,
//                 color: Colors.amber,
//               ),
//             ),
//           ),

//           if (review.comment.isNotEmpty) ...[
//             const SizedBox(height: 6),
//             Text(review.comment),
//           ],
//         ],
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jobportal/serviceseeker/screens/add_review_sheet.dart';
import '../controller/worker_profile_controller.dart';
import '../model/worker_model.dart';
//import '../widgets/add_review_sheet.dart';

class WorkerProfileScreen extends StatelessWidget {
  final WorkerModel worker;

  const WorkerProfileScreen({super.key, required this.worker});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(WorkerProfileController(worker.id));

    return Scaffold(
      appBar: AppBar(title: Text(worker.name)),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        return SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// IMAGE
              Center(
                child: Hero(
                  tag: worker.id,
                  child: CircleAvatar(
                    radius: 60,
                    backgroundImage: worker.photoUrl.isNotEmpty
                        ? NetworkImage(worker.photoUrl)
                        : null,
                    child: worker.photoUrl.isEmpty
                        ? const Icon(Icons.person, size: 60)
                        : null,
                  ),
                ),
              ),

              const SizedBox(height: 20),

              /// NAME
              Center(
                child: Text(
                  worker.name,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),

              const SizedBox(height: 6),

              /// SKILL
              Center(
                child: Text(
                  '${worker.skill} • ${worker.experience}',
                  style: const TextStyle(color: Colors.black54),
                ),
              ),

              const SizedBox(height: 12),

              /// RATING
              Center(
                child: Column(
                  children: [
                    _Stars(controller.averageRating.value),
                    const SizedBox(height: 4),
                    Text(
                      controller.averageRating.value.toStringAsFixed(1),
                      style: const TextStyle(fontWeight: FontWeight.w700),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              /// REVIEWS HEADER
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Reviews",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      Get.bottomSheet(
                        AddReviewSheet(controller: controller),
                        isScrollControlled: true,
                      );
                    },
                    icon: const Icon(Icons.add),
                    label: const Text("Add"),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              /// REVIEWS LIST
              if (controller.reviews.isEmpty)
                const Center(child: Text("No reviews yet")),

              ...controller.reviews.map(
                (r) => _ReviewTile(
                  name: r.userName,
                  rating: r.rating,
                  comment: r.comment,
                  date: r.createdAt,
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}

class _Stars extends StatelessWidget {
  final double rating;
  const _Stars(this.rating);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (i) {
        if (i < rating.floor()) {
          return const Icon(Icons.star, color: Colors.amber);
        } else if (i < rating) {
          return const Icon(Icons.star_half, color: Colors.amber);
        } else {
          return const Icon(Icons.star_border, color: Colors.amber);
        }
      }),
    );
  }
}

class _ReviewTile extends StatelessWidget {
  final String name;
  final double rating;
  final String comment;
  final DateTime date;

  const _ReviewTile({
    required this.name,
    required this.rating,
    required this.comment,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// NAME + STARS
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(name, style: const TextStyle(fontWeight: FontWeight.w700)),
              _Stars(rating),
            ],
          ),

          const SizedBox(height: 6),

          /// COMMENT
          Text(comment),

          const SizedBox(height: 6),

          /// DATE
          Text(
            "${date.day}/${date.month}/${date.year}",
            style: const TextStyle(fontSize: 12, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}

// class _ReviewTile extends StatelessWidget {
//   final ReviewModel review;

//   const _ReviewTile({required this.review});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: const EdgeInsets.only(bottom: 12),
//       padding: const EdgeInsets.all(14),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(14),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.05),
//             blurRadius: 12,
//             offset: const Offset(0, 6),
//           ),
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             review.userName,
//             style: const TextStyle(fontWeight: FontWeight.w700),
//           ),
//           const SizedBox(height: 4),
//           Row(
//             children: List.generate(
//               5,
//               (index) => Icon(
//                 Icons.star,
//                 size: 16,
//                 color: index < review.rating ? Colors.amber : Colors.grey,
//               ),
//             ),
//           ),
//           const SizedBox(height: 6),
//           Text(review.comment),
//         ],
//       ),
//     );
//   }
// }

class _Header extends StatelessWidget {
  final WorkerModel worker;
  const _Header({required this.worker});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          Hero(
            tag: worker.id,
            child: CircleAvatar(
              radius: 40,
              backgroundImage: worker.photoUrl.isNotEmpty
                  ? NetworkImage(worker.photoUrl)
                  : null,
              child: worker.photoUrl.isEmpty
                  ? const Icon(Icons.person, size: 30)
                  : null,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  worker.name,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  "${worker.skill} • ${worker.experience}",
                  style: const TextStyle(color: Colors.black54),
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    _StarRow(rating: worker.averageRating),
                    const SizedBox(width: 6),
                    Text("(${worker.totalReviews})"),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _StarRow extends StatelessWidget {
  final double rating;
  const _StarRow({required this.rating});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(5, (i) {
        return Icon(
          i < rating.round() ? Icons.star : Icons.star_border,
          size: 18,
          color: Colors.amber,
        );
      }),
    );
  }
}

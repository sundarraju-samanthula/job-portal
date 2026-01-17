// // import 'package:flutter/material.dart';
// // import 'package:get/get_core/src/get_main.dart';
// // import 'package:get/get_instance/src/extension_instance.dart';
// // import 'package:jobportal/controller/saved_jobs_controller.dart';

// // class SaveJobButton extends StatefulWidget {
// //   final VoidCallback onTap;

// //   const SaveJobButton({super.key, required this.onTap});

// //   @override
// //   State<SaveJobButton> createState() => _SaveJobButtonState();
// // }

// // class _SaveJobButtonState extends State<SaveJobButton>
// //     with SingleTickerProviderStateMixin {
// //   bool _saved = false;
// //   late final AnimationController _pulseCtrl;
// //   final savedController = Get.find<SavedJobsController>();

// //   @override
// //   void initState() {
// //     super.initState();
// //     _pulseCtrl = AnimationController(
// //       vsync: this,
// //       duration: const Duration(seconds: 2),
// //     )..repeat(reverse: true);
// //   }

// //   @override
// //   void dispose() {
// //     _pulseCtrl.dispose();
// //     super.dispose();
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return GestureDetector(
// //       onTap: () {
// //         setState(() => _saved = !_saved);
// //         widget.onTap();
// //       },
// //       child: AnimatedBuilder(
// //         animation: _pulseCtrl,
// //         builder: (_, __) {
// //           return Container(
// //             height: 56,
// //             decoration: BoxDecoration(
// //               borderRadius: BorderRadius.circular(16),
// //               color: Colors.white.withOpacity(0.65),
// //               border: Border.all(
// //                 color: const Color(0xFF2563EB).withOpacity(_saved ? 0.9 : 0.4),
// //                 width: 1.2,
// //               ),
// //               boxShadow: [
// //                 BoxShadow(
// //                   color: const Color(0xFF2563EB).withOpacity(
// //                     _saved ? 0.35 : 0.15 + (_pulseCtrl.value * 0.08),
// //                   ),
// //                   blurRadius: 18,
// //                 ),
// //               ],
// //             ),
// //             child: Row(
// //               mainAxisAlignment: MainAxisAlignment.center,
// //               children: [
// //                 Icon(
// //                   _saved ? Icons.bookmark : Icons.bookmark_outline,
// //                   color: const Color(0xFF2563EB),
// //                   size: 20,
// //                 ),
// //                 const SizedBox(width: 6),
// //                 Text(
// //                   _saved ? 'Saved' : 'Save',
// //                   style: const TextStyle(
// //                     fontWeight: FontWeight.w600,
// //                     color: Color(0xFF2563EB),
// //                   ),
// //                 ),
// //               ],
// //             ),
// //           );
// //         },
// //       ),
// //     );
// //   }
// // }
import 'package:flutter/material.dart';
import 'package:get/get.dart';
//import 'package:jobportal/controller/saved_jobs_controller.dart';
import 'package:jobportal/jobseeker/controller/saved_jobs_controller.dart';
import 'package:jobportal/jobseeker/models/job_model.dart';
//import 'package:jobportal/models/job_model.dart';

// class SaveJobButton extends StatelessWidget {
//   final JobModel job;

//   const SaveJobButton({super.key, required this.job});

//   @override
//   Widget build(BuildContext context) {
//     final savedController = Get.find<SavedJobsController>();

//     return Obx(() {
//       final isSaved = savedController.isSaved(job.id);

//       return GestureDetector(
//         onTap: () {
//           savedController.toggleSave(job);
//         },
//         child: Container(
//           height: 56,
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(16),
//             color: Colors.white.withOpacity(0.65),
//             border: Border.all(
//               color: const Color(0xFF2563EB).withOpacity(isSaved ? 0.9 : 0.4),
//               width: 1.2,
//             ),
//             boxShadow: [
//               BoxShadow(
//                 color: const Color(
//                   0xFF2563EB,
//                 ).withOpacity(isSaved ? 0.35 : 0.15),
//                 blurRadius: 18,
//               ),
//             ],
//           ),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Icon(
//                 isSaved ? Icons.bookmark : Icons.bookmark_outline,
//                 color: const Color(0xFF2563EB),
//                 size: 20,
//               ),
//               const SizedBox(width: 6),
//               Text(
//                 isSaved ? 'Saved' : 'Save',
//                 style: const TextStyle(
//                   fontWeight: FontWeight.w600,
//                   color: Color(0xFF2563EB),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       );
// //     });
// //   }
// // }
// class SaveJobButton extends StatelessWidget {
//   final JobModel job;

//   const SaveJobButton({super.key, required this.job});

//   @override
//   Widget build(BuildContext context) {
//     final savedController = Get.find<SavedJobsController>();

//     return Obx(() {
//       final isSaved = savedController.isSaved(job.id);

//       return GestureDetector(
//         onTap: () => savedController.toggleSave(job),
//         child: Container(
//           height: 56,
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(16),
//             color: Colors.white.withOpacity(0.65),
//             border: Border.all(
//               color: const Color(0xFF2563EB).withOpacity(isSaved ? 0.9 : 0.4),
//               width: 1.2,
//             ),
//             boxShadow: [
//               BoxShadow(
//                 color: const Color(
//                   0xFF2563EB,
//                 ).withOpacity(isSaved ? 0.35 : 0.15),
//                 blurRadius: 18,
//               ),
//             ],
//           ),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Icon(
//                 isSaved ? Icons.bookmark : Icons.bookmark_outline,
//                 color: const Color(0xFF2563EB),
//               ),
//               const SizedBox(width: 6),
//               Text(
//                 isSaved ? 'Saved' : 'Save',
//                 style: const TextStyle(
//                   fontWeight: FontWeight.w600,
//                   color: Color(0xFF2563EB),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       );
//     });
//   }
// }
// //
class SaveJobButton extends StatelessWidget {
  final JobModel job;

  const SaveJobButton({super.key, required this.job});

  @override
  Widget build(BuildContext context) {
    final savedController = Get.find<SavedJobsController>();

    return Obx(() {
      final isSaved = savedController.isSaved(job.id);

      return GestureDetector(
        onTap: () => savedController.toggleSave(job),
        child: Container(
          height: 56,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: Colors.white.withOpacity(0.65),
            border: Border.all(
              color: const Color(0xFF2563EB).withOpacity(isSaved ? 0.9 : 0.4),
              width: 1.2,
            ),
            boxShadow: [
              BoxShadow(
                color: const Color(
                  0xFF2563EB,
                ).withOpacity(isSaved ? 0.35 : 0.15),
                blurRadius: 18,
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                isSaved ? Icons.bookmark : Icons.bookmark_outline,
                color: const Color(0xFF2563EB),
                size: 20,
              ),
              const SizedBox(width: 6),
              Text(
                isSaved ? 'Saved' : 'Save',
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF2563EB),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}

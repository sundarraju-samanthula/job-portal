import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:jobportal/features/home/savejob_button.dart';
import 'package:jobportal/jobseeker/features/home/appplybutton.dart';
import 'package:jobportal/jobseeker/features/home/job_details.dart';
import 'package:jobportal/jobseeker/features/home/jobtyprebadge.dart';
import 'package:jobportal/jobseeker/models/job_model.dart';
//import 'package:jobportal/models/job_model.dart';
import 'package:url_launcher/url_launcher.dart';

class AnimatedJobCard extends StatelessWidget {
  final int index;
  final JobModel job;

  const AnimatedJobCard({super.key, required this.index, required this.job});

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      duration: Duration(milliseconds: 500 + index * 120),
      tween: Tween(begin: 0, end: 1),
      builder: (_, v, child) => Opacity(
        opacity: v,
        child: Transform.translate(
          offset: Offset(0, 40 * (1 - v)),
          child: child,
        ),
      ),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            PageRouteBuilder(
              transitionDuration: const Duration(milliseconds: 550),
              pageBuilder: (_, __, ___) => JobDetailsScreen(job: job),
            ),
          );
        },
        child: Container(
          margin: const EdgeInsets.only(bottom: 22),
          padding: const EdgeInsets.all(22),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(28),
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color.fromARGB(255, 95, 221, 116), Color(0xFFDBEAFE)],
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.14),
                blurRadius: 36,
                offset: const Offset(0, 20),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// HEADER
              Row(
                children: [
                  /// LOGO
                  Container(
                    height: 48,
                    width: 48,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(14),
                      child: Image.network(
                        job.companyLogo,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) =>
                            const Icon(Icons.business),
                      ),
                    ),
                  ),

                  const SizedBox(width: 14),

                  /// JOB INFO
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          job.jobTitle,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          job.companyName,
                          style: const TextStyle(
                            color: Colors.brown,
                            fontSize: 13,
                          ),
                        ),
                        Text(
                          job.location,
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ),

                  JobTypeBadge(type: job.workMode),
                ],
              ),

              const SizedBox(height: 22),

              /// ACTION BUTTONS
              Row(
                children: [
                  /// SAVE
                  Expanded(
                    flex: 2,
                    child: SaveJobButton(
                      onTap: () {
                        debugPrint('Saved ${job.id}');
                      },
                      job: job,
                    ),
                  ),
                  const SizedBox(width: 14),

                  /// APPLY
                  Expanded(
                    flex: 3,
                    child: NeonApplyButton(
                      onTap: () => _openApplyLink(job.applyLink),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _openApplyLink(String url) async {
    debugPrint('Apply URL: $url');

    final uri = Uri.tryParse(url);
    if (uri == null) {
      Get.snackbar('Invalid URL', url);
      return;
    }

    final canLaunch = await canLaunchUrl(uri);
    debugPrint('Can launch: $canLaunch');

    if (!canLaunch) {
      Get.snackbar('Error', 'Cannot open link');
      return;
    }

    await launchUrl(uri, mode: LaunchMode.externalApplication);
  }

  // Future<void> _openApplyLink(String url) async {
  //   final uri = Uri.parse(url);
  //   if (await canLaunchUrl(uri)) {
  //     await launchUrl(uri, mode: LaunchMode.externalApplication);
  //   }
  // }
}

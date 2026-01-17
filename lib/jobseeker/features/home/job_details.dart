import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:jobportal/features/home/savejob_button.dart';
import 'package:jobportal/jobseeker/features/home/appplybutton.dart';
import 'package:jobportal/jobseeker/models/job_model.dart';
import 'package:url_launcher/url_launcher.dart';

class JobDetailsScreen extends StatelessWidget {
  final JobModel job;

  const JobDetailsScreen({super.key, required this.job});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7FAFF),
      body: SafeArea(
        child: Stack(
          children: [
            /// MAIN CONTENT
            SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(22, 20, 22, 140),
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// BACK BUTTON
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: _glassIcon(Icons.arrow_back_ios_new_rounded),
                  ),

                  const SizedBox(height: 26),

                  /// JOB OVERVIEW
                  _JobOverviewCard(job: job),

                  const SizedBox(height: 30),

                  /// JOB DESCRIPTION
                  _JobDescriptionBlock(job: job),

                  // const SizedBox(height: 20),

                  // /// RESPONSIBILITIES
                  // if (job.responsibilities.isNotEmpty)
                  //   _JobListBlock(
                  //     title: 'Responsibilities',
                  //     items: job.responsibilities,
                  //   ),

                  // const SizedBox(height: 20),

                  // /// REQUIREMENTS
                  // if (job.requirements.isNotEmpty)
                  //   _JobListBlock(
                  //     title: 'Requirements',
                  //     items: job.requirements,
                  //   ),
                ],
              ),
            ),

            /// BOTTOM ACTION BAR
            _BottomActionBar(job: job),
          ],
        ),
      ),
    );
  }

  Widget _glassIcon(IconData icon) {
    return Container(
      height: 44,
      width: 44,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.9),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.12), blurRadius: 18),
        ],
      ),
      child: Icon(icon, size: 18),
    );
  }
}

class _JobOverviewCard extends StatelessWidget {
  final JobModel job;

  const _JobOverviewCard({required this.job});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        gradient: const LinearGradient(
          colors: [Color(0xFFEFF6FF), Color(0xFFDBEAFE)],
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            blurRadius: 40,
            offset: const Offset(0, 24),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              /// COMPANY LOGO
              Container(
                height: 62,
                width: 62,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(18),
                  child: Image.network(
                    job.companyLogo,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => const Icon(Icons.business),
                  ),
                ),
              ),

              const SizedBox(width: 16),

              /// JOB INFO
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      job.jobTitle,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      '${job.companyName} • ${job.location}',
                      style: const TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 24),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _meta('Salary', job.salary),
              _meta('Experience', job.experience),
              _meta('Work Mode', job.workMode),
            ],
          ),
        ],
      ),
    );
  }

  Widget _meta(String title, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(color: Colors.grey, fontSize: 12)),
        const SizedBox(height: 4),
        Text(value, style: const TextStyle(fontWeight: FontWeight.w700)),
      ],
    );
  }
}

// class _MetaGlassItem extends StatelessWidget {
//   final String title;
//   final String value;

//   const _MetaGlassItem({required this.title, required this.value});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
//       decoration: BoxDecoration(
//         color: Colors.white.withOpacity(0.85),
//         borderRadius: BorderRadius.circular(14),
//         boxShadow: [
//           BoxShadow(color: Colors.black.withOpacity(0.08), blurRadius: 12),
//         ],
//       ),
//       child: Column(
//         children: [
//           Text(title, style: const TextStyle(fontSize: 12, color: Colors.grey)),
//           const SizedBox(height: 4),
//           Text(
//             value,
//             style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w800),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class _JobDescriptionBlock extends StatelessWidget {
//   final JobModel job;

//   const _JobDescriptionBlock({required this.job});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.all(22),
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(26),
//         gradient: LinearGradient(colors: [Colors.white, Colors.blue.shade50]),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.08),
//             blurRadius: 26,
//             offset: const Offset(0, 16),
//           ),
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: const [
//           Text(
//             'Job Description',
//             style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900),
//           ),
//           SizedBox(height: 14),
//           Text(
//             'Detailed job responsibilities and requirements '
//             'can be provided by the admin here.\n\n'
//             'This section is future-ready for rich descriptions.',
//             style: TextStyle(height: 1.65),
//           ),
//         ],
//       ),
//     );
//   }
// }
// class _JobDescriptionBlock extends StatelessWidget {
//   final JobModel job;

//   const _JobDescriptionBlock({required this.job});

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         _glassCard(
//           title: 'Job Description',
//           child: Text(
//             job.description.isNotEmpty
//                 ? job.description
//                 : 'No description provided.',
//             style: const TextStyle(height: 1.65, fontSize: 14.5),
//           ),
//         ),

//         const SizedBox(height: 22),

//         if (job.responsibilities.isNotEmpty)
//           _glassCard(
//             title: 'Responsibilities',
//             child: _bulletList(job.responsibilities),
//           ),

//         if (job.responsibilities.isNotEmpty) const SizedBox(height: 22),

//         if (job.requirements.isNotEmpty)
//           _glassCard(
//             title: 'Requirements',
//             child: _bulletList(job.requirements),
//           ),
//       ],
//     );
//   }

//   Widget _glassCard({required String title, required Widget child}) {
//     return Container(
//       padding: const EdgeInsets.all(22),
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(26),
//         gradient: LinearGradient(colors: [Colors.white, Colors.blue.shade50]),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.08),
//             blurRadius: 26,
//             offset: const Offset(0, 16),
//           ),
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             title,
//             style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w900),
//           ),
//           const SizedBox(height: 14),
//           child,
//         ],
//       ),
//     );
//   }

//   /// 🔹 Bullet List UI
//   Widget _bulletList(List<String> items) {
//     return Column(
//       children: items
//           .map(
//             (e) => Padding(
//               padding: const EdgeInsets.only(bottom: 10),
//               child: Row(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   const Text("• ", style: TextStyle(fontSize: 18)),
//                   Expanded(
//                     child: Text(
//                       e,
//                       style: const TextStyle(fontSize: 14.5, height: 1.6),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           )
//           .toList(),
//     );
//   }
// }
class _JobDescriptionBlock extends StatelessWidget {
  final JobModel job;

  const _JobDescriptionBlock({required this.job});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _card(
          "Job Description",
          Text(
            job.description.isNotEmpty
                ? job.description
                : "No description provided",
          ),
        ),

        if (job.responsibilities.isNotEmpty)
          _card("Responsibilities", _bulletList(job.responsibilities)),

        if (job.requirements.isNotEmpty)
          _card("Requirements", _bulletList(job.requirements)),
      ],
    );
  }

  Widget _card(String title, Widget child) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(26),
        color: Colors.white,
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.08), blurRadius: 26),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w900),
          ),
          const SizedBox(height: 14),
          child,
        ],
      ),
    );
  }

  Widget _list(List<String> items) {
    return Column(
      children: items
          .map(
            (e) => Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("• "),
                  Expanded(child: Text(e)),
                ],
              ),
            ),
          )
          .toList(),
    );
  }

  Widget _bulletList(List<String> items) {
    return Column(
      children: items
          .map(
            (e) => Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("• ", style: TextStyle(fontSize: 18)),
                  Expanded(
                    child: Text(
                      e,
                      style: const TextStyle(fontSize: 14.5, height: 1.6),
                    ),
                  ),
                ],
              ),
            ),
          )
          .toList(),
    );
  }

  Widget _glassCard({required String title, required Widget child}) {
    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(26),
        gradient: LinearGradient(colors: [Colors.white, Colors.blue.shade50]),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 26,
            offset: const Offset(0, 16),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w900),
          ),
          const SizedBox(height: 14),
          child,
        ],
      ),
    );
  }
}

class _BottomActionBar extends StatelessWidget {
  final JobModel job;

  const _BottomActionBar({required this.job});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 0,
      right: 0,
      bottom: 0,
      child: ClipRRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
          child: Container(
            padding: const EdgeInsets.fromLTRB(22, 16, 22, 24),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.9),
              boxShadow: [
                BoxShadow(color: Colors.black.withOpacity(0.2), blurRadius: 30),
              ],
            ),
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: SaveJobButton(onTap: () {}, job: job),
                ),
                const SizedBox(width: 16),
                Expanded(
                  flex: 3,
                  child: NeonApplyButton(onTap: () => _open(job.applyLink)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _open(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }
}

Widget _glassIcon(IconData icon) {
  return Container(
    height: 44,
    width: 44,
    decoration: BoxDecoration(
      color: Colors.white.withOpacity(0.9),
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(color: Colors.black.withOpacity(0.12), blurRadius: 18),
      ],
    ),
    child: Icon(icon, size: 18, color: Colors.black),
  );
}

class _JobListBlock extends StatelessWidget {
  final String title;
  final List<String> items;

  const _JobListBlock({required this.title, required this.items});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(26),
        color: Colors.white,
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.08), blurRadius: 26),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w900),
          ),
          const SizedBox(height: 14),
          ...items.map(
            (e) => Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("• "),
                  Expanded(child: Text(e, style: const TextStyle(height: 1.6))),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

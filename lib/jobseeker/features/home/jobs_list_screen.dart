import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
//import 'package:jobportal/features/profile/profile_screen.dart';
import 'package:jobportal/jobseeker/controller/jobs_controller.dart';
import 'package:jobportal/jobseeker/features/home/job_card.dart';
import 'package:jobportal/jobseeker/features/profile/profile_screen.dart';
import 'package:jobportal/jobseeker/features/profile/shimmerprofile.dart';
//import 'package:jobportal/features/profile/shimmerprofile.dart';

class JobListScreen extends StatelessWidget {
  const JobListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final JobsController controller = Get.find<JobsController>();

    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFFF7FAFF), Color(0xFFEFF4FF)],
        ),
      ),
      child: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 18),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 22),
              child: Row(
                children: [
                  const Expanded(
                    child: Text(
                      'Find Jobs',
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                  ShimmerProfileButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const ProfileScreen(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 22),
              child: GlassSearchBar(),
            ),

            const SizedBox(height: 22),

            Expanded(
              child: Obx(() {
                if (controller.isLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (controller.error.isNotEmpty) {
                  return Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.wifi_off, size: 40),
                        const SizedBox(height: 12),
                        Text(controller.error.value),
                        const SizedBox(height: 12),
                        ElevatedButton(
                          onPressed: controller.fetchJobs,
                          child: const Text("Retry"),
                        ),
                      ],
                    ),
                  );
                }

                if (controller.filteredJobs.isEmpty) {
                  return const Center(
                    child: Text(
                      'No jobs found',
                      style: TextStyle(fontSize: 16),
                    ),
                  );
                }

                return RefreshIndicator(
                  onRefresh: () async {
                    controller.fetchJobs();
                  },
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 22),
                    itemCount: controller.filteredJobs.length,
                    itemBuilder: (context, index) {
                      final job = controller.filteredJobs[index];
                      return AnimatedJobCard(index: index, job: job);
                    },
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}

class GlassSearchBar extends StatelessWidget {
  const GlassSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<JobsController>();

    return ClipRRect(
      borderRadius: BorderRadius.circular(22),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 14, sigmaY: 14),
        child: Container(
          height: 56,
          padding: const EdgeInsets.symmetric(horizontal: 18),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.72),
            boxShadow: [
              BoxShadow(blurRadius: 24, color: Colors.black.withOpacity(0.06)),
            ],
          ),
          child: Row(
            children: [
              const Icon(Icons.search, color: Colors.grey),
              const SizedBox(width: 12),

              Expanded(
                child: TextField(
                  onChanged: controller.onSearchChanged,
                  decoration: const InputDecoration(
                    hintText: 'Search jobs, company, location',
                    border: InputBorder.none,
                  ),
                ),
              ),

              Obx(() {
                return AnimatedSwitcher(
                  duration: const Duration(milliseconds: 250),
                  child: controller.searchQuery.value.isNotEmpty
                      ? GestureDetector(
                          key: const ValueKey('clear'),
                          onTap: controller.clearSearch,
                          child: const Icon(Icons.close, color: Colors.grey),
                        )
                      : const SizedBox(),
                );
              }),

              const SizedBox(width: 10),

              GestureDetector(
                onTap: () => _openFilterSheet(context),
                child: Container(
                  height: 38,
                  width: 38,
                  decoration: BoxDecoration(
                    color: const Color(0xFF2563EB).withOpacity(0.14),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.tune,
                    size: 20,
                    color: Color(0xFF2563EB),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void _openFilterSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (_) => const _JobFilterSheet(),
  );
}

class _JobFilterSheet extends StatefulWidget {
  const _JobFilterSheet();

  @override
  State<_JobFilterSheet> createState() => _JobFilterSheetState();
}

class _JobFilterSheetState extends State<_JobFilterSheet> {
  final controller = Get.find<JobsController>();

  String experience = '';
  String workMode = '';

  @override
  void initState() {
    super.initState();
    experience = controller.selectedExperience.value;
    workMode = controller.selectedWorkMode.value;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(22, 14, 22, 28),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(34)),
        gradient: const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFFF1F5FF), Color(0xFFEAF0FF), Color(0xFFE0EAFF)],
        ),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 80),
        ],
      ),
      child: SafeArea(
        top: false,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// HANDLE
              Center(
                child: Container(
                  height: 4,
                  width: 46,
                  margin: const EdgeInsets.only(bottom: 18),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade400,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),

              /// HEADER
              Row(
                children: [
                  const Expanded(
                    child: Text(
                      'Filter Jobs',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.close_rounded),
                  ),
                ],
              ),

              const SizedBox(height: 26),

              /// EXPERIENCE
              _filterSection(
                title: 'Experience',
                options: ['fresher', '0-1', '1-3', '3+'],
                selected: experience,
                onSelect: (v) => setState(() => experience = v),
              ),

              /// WORK MODE
              _filterSection(
                title: 'Work Mode',
                options: ['WFH', 'Remote', 'Hybrid'],
                selected: workMode,
                onSelect: (v) => setState(() => workMode = v),
              ),

              const SizedBox(height: 32),

              /// ACTIONS
              Row(
                children: [
                  /// RESET
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          experience = '';
                          workMode = '';
                        });

                        controller.resetFilters();
                        Navigator.pop(context);
                      },
                      child: Container(
                        height: 56,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(18),
                          color: Colors.white,
                          border: Border.all(color: Colors.grey.shade300),
                        ),
                        child: const Center(
                          child: Text(
                            'Reset',
                            style: TextStyle(fontWeight: FontWeight.w700),
                          ),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(width: 18),

                  /// APPLY
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        controller.selectedExperience.value = experience;
                        controller.selectedWorkMode.value = workMode;
                        controller.applyFilters();
                        Navigator.pop(context);
                      },
                      child: Container(
                        height: 56,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(18),
                          gradient: const LinearGradient(
                            colors: [Color(0xFF2563EB), Color(0xFF4F46E5)],
                          ),
                        ),
                        child: const Center(
                          child: Text(
                            'Apply Filters',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ),
                      ),
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

  /// FILTER CHIPS
  Widget _filterSection({
    required String title,
    required List<String> options,
    required String selected,
    required Function(String) onSelect,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w800),
        ),
        const SizedBox(height: 14),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: options.map((e) {
            final isSelected = selected == e;

            return GestureDetector(
              onTap: () => onSelect(e),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 220),
                padding: const EdgeInsets.symmetric(
                  horizontal: 18,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  gradient: isSelected
                      ? const LinearGradient(
                          colors: [Color(0xFF2563EB), Color(0xFF4F46E5)],
                        )
                      : null,
                  color: isSelected ? null : Colors.grey.shade100,
                ),
                child: Text(
                  e,
                  style: TextStyle(
                    color: isSelected ? Colors.white : Colors.black87,
                    fontWeight: FontWeight.w700,
                    fontSize: 13.5,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
        const SizedBox(height: 26),
      ],
    );
  }
}

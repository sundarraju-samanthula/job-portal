import 'dart:ui';
import 'dart:math';
//import 'package:baseapp/job_details.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:jobportal/controller/jobs_controller.dart';
import 'package:jobportal/features/profile/profile_screen.dart';
import 'package:jobportal/models/job_model.dart';
import 'package:url_launcher/url_launcher.dart';

////////////////////////////////////////////////////////////////////////////////
/// HOME SHELL
////////////////////////////////////////////////////////////////////////////////

class HomeShell extends StatefulWidget {
  const HomeShell({super.key});

  @override
  State<HomeShell> createState() => _HomeShellState();
}

class _HomeShellState extends State<HomeShell> {
  int _currentIndex = 0;

  final pages = const [
    JobListScreen(),
    InstaJobListScreen(),
    ApplicationsScreen(),
    NotificationsScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 450),
        child: pages[_currentIndex],
      ),
      bottomNavigationBar: _GlassBottomNav(
        index: _currentIndex,
        onTap: (i) => setState(() => _currentIndex = i),
      ),
    );
  }
}

////////////////////////////////////////////////////////////////////////////////
/// GLASS BOTTOM NAV
////////////////////////////////////////////////////////////////////////////////

class _GlassBottomNav extends StatelessWidget {
  final int index;
  final ValueChanged<int> onTap;

  const _GlassBottomNav({required this.index, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(26),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
          child: BottomNavigationBar(
            currentIndex: index,
            onTap: onTap,
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.white.withOpacity(0.88),
            elevation: 0,
            selectedItemColor: const Color(0xFF2563EB),
            unselectedItemColor: Colors.grey.shade500,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.work_outline),
                label: 'Jobs',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.description_outlined),
                label: 'Instant Services',
              ),
              // BottomNavigationBarItem(
              //   icon: Icon(Icons.notifications_none),
              //   label: 'Alerts',
              // ),
              // BottomNavigationBarItem(
              //   icon: Icon(Icons.person_outline),
              //   label: 'Profile',
              // ),
            ],
          ),
        ),
      ),
    );
  }
}

class JobListScreen extends StatelessWidget {
  const JobListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final JobsController controller = Get.put(JobsController());

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

            /// HEADER
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 22),
              child: Row(
                children: const [
                  Expanded(
                    child: Text(
                      'Find Jobs',
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 22),
              child: _GlassSearchBar(),
            ),
            const SizedBox(height: 22),

            /// JOB LIST
            Expanded(
              child: Obx(() {
                if (controller.isLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (controller.jobs.isEmpty) {
                  return const Center(child: Text('No jobs available'));
                }

                return ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 22),
                  itemCount: controller.jobs.length,
                  itemBuilder: (context, index) {
                    final JobModel job = controller.jobs[index];

                    return AnimatedJobCard(index: index, job: job);
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}

////////////////////////////////////////////////////////////////////////////////
/// SEARCH BAR
////////////////////////////////////////////////////////////////////////////////

class _GlassSearchBar extends StatelessWidget {
  const _GlassSearchBar();

  @override
  Widget build(BuildContext context) {
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

              /// SEARCH PLACEHOLDER
              const Expanded(
                child: Text(
                  'Search jobs, roles, companies',
                  style: TextStyle(color: Colors.grey, fontSize: 14),
                ),
              ),

              /// FILTER BUTTON
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
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }
}

class JobTypeBadge extends StatefulWidget {
  final String type;

  const JobTypeBadge({super.key, required this.type});

  @override
  State<JobTypeBadge> createState() => _JobTypeBadgeState();
}

class _JobTypeBadgeState extends State<JobTypeBadge>
    with SingleTickerProviderStateMixin {
  late final AnimationController _shineCtrl;

  @override
  void initState() {
    super.initState();
    _shineCtrl = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();
  }

  @override
  void dispose() {
    _shineCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = widget.type == 'WFH'
        ? [const Color(0xFFDCFCE7), const Color(0xFF86EFAC)]
        : widget.type == 'Hybrid'
        ? [const Color(0xFFF3E8FF), const Color(0xFFDDD6FE)]
        : [const Color(0xFFEFF6FF), const Color(0xFFBFDBFE)];

    final textColor = widget.type == 'WFH'
        ? Colors.green.shade700
        : widget.type == 'Hybrid'
        ? Colors.purple.shade700
        : Colors.blue.shade700;

    return AnimatedBuilder(
      animation: _shineCtrl,
      builder: (_, __) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: colors,
            ),
            boxShadow: [
              BoxShadow(color: textColor.withOpacity(0.35), blurRadius: 14),
            ],
          ),
          child: ShaderMask(
            shaderCallback: (rect) {
              return LinearGradient(
                begin: Alignment(-1 + 2 * _shineCtrl.value, 0),
                end: Alignment(1 + 2 * _shineCtrl.value, 0),
                colors: const [
                  Colors.transparent,
                  Colors.white,
                  Colors.transparent,
                ],
                stops: const [0.4, 0.5, 0.6],
              ).createShader(rect);
            },
            blendMode: BlendMode.srcATop,
            child: Text(
              widget.type,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: textColor,
                letterSpacing: 0.4,
              ),
            ),
          ),
        );
      },
    );
  }
}

class SaveJobButton extends StatefulWidget {
  final VoidCallback onTap;

  const SaveJobButton({super.key, required this.onTap});

  @override
  State<SaveJobButton> createState() => _SaveJobButtonState();
}

class _SaveJobButtonState extends State<SaveJobButton>
    with SingleTickerProviderStateMixin {
  bool _saved = false;
  late final AnimationController _pulseCtrl;

  @override
  void initState() {
    super.initState();
    _pulseCtrl = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _pulseCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() => _saved = !_saved);
        widget.onTap();
      },
      child: AnimatedBuilder(
        animation: _pulseCtrl,
        builder: (_, __) {
          return Container(
            height: 56,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: Colors.white.withOpacity(0.65),
              border: Border.all(
                color: const Color(0xFF2563EB).withOpacity(_saved ? 0.9 : 0.4),
                width: 1.2,
              ),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF2563EB).withOpacity(
                    _saved ? 0.35 : 0.15 + (_pulseCtrl.value * 0.08),
                  ),
                  blurRadius: 18,
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  _saved ? Icons.bookmark : Icons.bookmark_outline,
                  color: const Color(0xFF2563EB),
                  size: 20,
                ),
                const SizedBox(width: 6),
                Text(
                  _saved ? 'Saved' : 'Save',
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF2563EB),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

// import 'dart:math';
//import 'package:flutter/material.dart';

class NeonApplyButton extends StatefulWidget {
  final VoidCallback onTap;

  const NeonApplyButton({super.key, required this.onTap});

  @override
  State<NeonApplyButton> createState() => _NeonApplyButtonState();
}

class _NeonApplyButtonState extends State<NeonApplyButton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _textPulse;
  bool _showSpark = false;

  @override
  void initState() {
    super.initState();

    /// ⏳ EVEN SLOWER SPEED (luxury)
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    )..repeat();

    _textPulse = Tween<double>(
      begin: 0.4,
      end: 1,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _triggerSpark() {
    setState(() => _showSpark = true);
    Future.delayed(const Duration(milliseconds: 280), () {
      if (mounted) setState(() => _showSpark = false);
    });
    widget.onTap();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _triggerSpark,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (_, __) {
          return Stack(
            alignment: Alignment.center,
            children: [
              Container(
                height: 56,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF00B4FF).withOpacity(0.55),
                      blurRadius: 30,
                    ),
                  ],
                ),
                child: CustomPaint(
                  painter: _SnakeBorderPainter(progress: _controller.value),
                  child: Center(
                    child: AnimatedBuilder(
                      animation: _textPulse,
                      builder: (_, __) {
                        return Text(
                          'APPLY ON SITE',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w800,
                            letterSpacing: 1.6,
                            color: const Color(0xFF00E5FF),
                            shadows: [
                              Shadow(
                                color: const Color(
                                  0xFF00E5FF,
                                ).withOpacity(_textPulse.value),
                                blurRadius: 22,
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),

              /// ✨ TAP BURST
              if (_showSpark) const _TapSpark(),
            ],
          );
        },
      ),
    );
  }
}

////////////////////////////////////////////////////////////////////////////////
/// 🐍 SNAKE BORDER PAINTER (THICKER + TRAIL PARTICLES)
////////////////////////////////////////////////////////////////////////////////

class _SnakeBorderPainter extends CustomPainter {
  final double progress;

  _SnakeBorderPainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    final rRect = RRect.fromRectAndRadius(rect, const Radius.circular(16));

    final path = Path()..addRRect(rRect);
    final metric = path.computeMetrics().first;
    final length = metric.length;

    /// 🧬 Dynamic length (slow breathing)
    final snakeLength = length * (0.18 + 0.06 * sin(progress * 2 * pi));

    final start = (length * progress) % length;
    final end = start + snakeLength;

    void draw(double s, double e, double opacity, double stroke) {
      final p = metric.extractPath(s, e);
      final paint = Paint()
        ..style = PaintingStyle.stroke
        ..strokeCap = StrokeCap.round
        ..strokeWidth = stroke
        ..color = const Color(0xFF00E5FF).withOpacity(opacity);
      canvas.drawPath(p, paint);
    }

    /// ✨ PARTICLE TRAIL (tiny sparks)
    for (int i = 0; i < 6; i++) {
      final offset = start + (i * snakeLength / 8);
      final tangent = metric.getTangentForOffset(offset);
      if (tangent == null) continue;

      final paint = Paint()
        ..color = const Color(0xFF00E5FF).withOpacity(0.15 + i * 0.05);

      canvas.drawCircle(tangent.position, 1.4, paint);
    }

    /// 🐍 TAIL (fade)
    draw(start, end, 0.35, 3.4);

    /// 🐍 BODY (thick)
    draw(start + snakeLength * 0.35, end, 0.75, 3.8);

    /// 🔵 HEAD (thick + glow)
    draw(end - 8, end, 1.0, 5.0);
  }

  @override
  bool shouldRepaint(covariant _SnakeBorderPainter oldDelegate) =>
      oldDelegate.progress != progress;
}

////////////////////////////////////////////////////////////////////////////////
/// ✨ TAP SPARK
////////////////////////////////////////////////////////////////////////////////

class _TapSpark extends StatefulWidget {
  const _TapSpark();

  @override
  State<_TapSpark> createState() => _TapSparkState();
}

class _TapSparkState extends State<_TapSpark>
    with SingleTickerProviderStateMixin {
  late AnimationController _sparkCtrl;

  @override
  void initState() {
    super.initState();
    _sparkCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 280),
    )..forward();
  }

  @override
  void dispose() {
    _sparkCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _sparkCtrl,
      builder: (_, __) {
        return Opacity(
          opacity: 1 - _sparkCtrl.value,
          child: Transform.scale(
            scale: 1 + _sparkCtrl.value * 0.8,
            child: Container(
              height: 14,
              width: 14,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFF00E5FF),
                boxShadow: [
                  BoxShadow(color: const Color(0xFF00E5FF), blurRadius: 26),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class ApplicationsScreen extends StatelessWidget {
  const ApplicationsScreen({super.key});

  @override
  Widget build(BuildContext context) =>
      const Center(child: Text('Applications'));
}

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) =>
      const Center(child: Text('Notifications'));
}

class _JobFilterSheet extends StatefulWidget {
  const _JobFilterSheet();

  @override
  State<_JobFilterSheet> createState() => _JobFilterSheetState();
}

class _JobFilterSheetState extends State<_JobFilterSheet> {
  String experience = '';
  String jobType = '';
  String workMode = '';

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(22, 14, 22, 28),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(34)),
        gradient: const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color.fromARGB(134, 155, 155, 211),
            Color.fromARGB(255, 116, 163, 207),
            Color.fromARGB(157, 100, 122, 166),
          ],
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
              /// DRAG HANDLE
              Center(
                child: Container(
                  height: 4,
                  width: 46,
                  margin: const EdgeInsets.only(bottom: 18),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
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
                        letterSpacing: 0.2,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.close_rounded),
                  ),
                ],
              ),

              const SizedBox(height: 24),

              /// EXPERIENCE
              _filterSection(
                title: 'Experience',
                options: ['Fresher', '0-1', '1-3', '3+'],
                selected: experience,
                onSelect: (v) => setState(() => experience = v),
              ),

              /// JOB TYPE
              _filterSection(
                title: 'Job Category',
                options: ['Technical', 'Non-Technical'],
                selected: jobType,
                onSelect: (v) => setState(() => jobType = v),
              ),

              /// WORK MODE
              _filterSection(
                title: 'Work Mode',
                options: ['WFH', 'Remote', 'Hybrid'],
                selected: workMode,
                onSelect: (v) => setState(() => workMode = v),
              ),

              const SizedBox(height: 32),

              /// ACTION BUTTONS
              Row(
                children: [
                  /// RESET (GLASS BUTTON)
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          experience = '';
                          jobType = '';
                          workMode = '';
                        });
                      },
                      child: Container(
                        height: 56,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(18),
                          color: Colors.white.withOpacity(0.85),
                          border: Border.all(color: Colors.grey.shade300),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.08),
                              blurRadius: 16,
                            ),
                          ],
                        ),
                        child: const Center(
                          child: Text(
                            'Reset',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                              color: Colors.black87,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(width: 18),

                  /// APPLY (GRADIENT PRIMARY)
                  Expanded(
                    child: GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        height: 56,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(18),
                          gradient: const LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              Color(0xFF2563EB),
                              Color(0xFF4F46E5),
                              Color(0xFF38BDF8),
                            ],
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFF2563EB).withOpacity(0.55),
                              blurRadius: 26,
                              offset: const Offset(0, 12),
                            ),
                          ],
                        ),
                        child: const Center(
                          child: Text(
                            'Apply Filters',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.w900,
                              letterSpacing: 0.6,
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

  /// PREMIUM FILTER SECTION
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
                  boxShadow: isSelected
                      ? [
                          BoxShadow(
                            color: const Color(0xFF2563EB).withOpacity(0.45),
                            blurRadius: 16,
                          ),
                        ]
                      : [],
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
        const SizedBox(height: 24),
      ],
    );
  }
}

class InstaJobListScreen extends StatelessWidget {
  const InstaJobListScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 22),
              child: _GlassSearchBar(),
            ),
            const SizedBox(height: 22),

            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 22),
                itemCount: 5,
                itemBuilder: (context, index) {
                  return InstaAnimatedJobCard(
                    index: index,
                    title: 'Senior Flutter Developer',
                    company: 'Tech Labs',
                    location: ' ',
                    tag: index.isEven ? 'WFH' : 'Hybrid',
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ShimmerProfileButton extends StatefulWidget {
  final VoidCallback onPressed;

  const ShimmerProfileButton({super.key, required this.onPressed});

  @override
  State<ShimmerProfileButton> createState() => _ShimmerProfileButtonState();
}

class _ShimmerProfileButtonState extends State<ShimmerProfileButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3500), // slower
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onPressed,
      child: SizedBox(
        height: 64,
        width: 64,
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Base circular button
            Container(
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xff6D5DF6),
              ),
            ),

            // Thick shimmer overlay
            AnimatedBuilder(
              animation: _controller,
              builder: (_, __) {
                return ClipOval(
                  child: Transform.translate(
                    offset: Offset((_controller.value * 140) - 70, 0),
                    child: Container(
                      width: 48, // THICK shine
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          colors: [
                            Colors.transparent,
                            Colors.white.withOpacity(0.45),
                            Colors.white.withOpacity(0.25),
                            Colors.transparent,
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),

            // Icon (STABLE)
            const Icon(Icons.person, color: Colors.white, size: 30),
          ],
        ),
      ),
    );
  }
}

class InstaAnimatedJobCard extends StatelessWidget {
  final int index;
  final String title, company, location, tag;

  const InstaAnimatedJobCard({
    super.key,
    required this.index,
    required this.title,
    required this.company,
    required this.location,
    required this.tag,
  });

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
        onTap: () {},
        child: Container(
          margin: const EdgeInsets.only(bottom: 22),
          padding: const EdgeInsets.all(22),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(28),
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color.fromARGB(255, 78, 111, 194), Color(0xFFDBEAFE)],
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
              /// ───────── HEADER ─────────
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// 🏢 COMPANY LOGO (HERO)
                  Hero(
                    tag: 'job_logo_$index',
                    child: Container(
                      height: 48,
                      width: 48,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(14),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.15),
                            blurRadius: 12,
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(14),
                        child: Image.network(
                          'https://via.placeholder.com/100',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(width: 14),

                  /// JOB INFO
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        /// 🎯 JOB TITLE (HERO)
                        Hero(
                          tag: 'job_title_$index',
                          child: Material(
                            color: Colors.transparent,
                            child: Text(
                              title,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          company,
                          style: const TextStyle(
                            color: Colors.brown,
                            fontSize: 13,
                          ),
                        ),
                        Text(
                          location,
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ),

                  /// 🏷 JOB TYPE BADGE
                  JobTypeBadge(type: tag),
                ],
              ),

              const SizedBox(height: 22),

              /// ───────── ACTION BUTTONS ─────────
              Row(
                children: [
                  Expanded(flex: 2, child: WhatsAppButton(onTap: () => {})),
                  const SizedBox(width: 14),
                  Expanded(flex: 3, child: CallHRButton(onTap: () => {})),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class WhatsAppButton extends StatefulWidget {
  final VoidCallback onTap;
  const WhatsAppButton({super.key, required this.onTap});

  @override
  State<WhatsAppButton> createState() => _WhatsAppButtonState();
}

class _WhatsAppButtonState extends State<WhatsAppButton>
    with TickerProviderStateMixin {
  late final AnimationController _waveCtrl;
  late final AnimationController _pulseCtrl;
  bool _pressed = false;
  bool _spark = false;

  @override
  void initState() {
    super.initState();

    _waveCtrl = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 6),
    )..repeat();

    _pulseCtrl = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _waveCtrl.dispose();
    _pulseCtrl.dispose();
    super.dispose();
  }

  void _tap() {
    setState(() => _spark = true);
    widget.onTap();
    Future.delayed(const Duration(milliseconds: 260), () {
      if (mounted) setState(() => _spark = false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _pressed = true),
      onTapUp: (_) {
        setState(() => _pressed = false);
        _tap();
      },
      onTapCancel: () => setState(() => _pressed = false),
      child: AnimatedScale(
        scale: _pressed ? 0.94 : 1,
        duration: const Duration(milliseconds: 140),
        child: AnimatedBuilder(
          animation: Listenable.merge([_waveCtrl, _pulseCtrl]),
          builder: (_, __) {
            return Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  height: 58,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    gradient: LinearGradient(
                      begin: Alignment(-1 + (_waveCtrl.value * 2), 0),
                      end: Alignment(1 + (_waveCtrl.value * 2), 0),
                      colors: const [
                        Color(0xFF1EBE5D),
                        Color(0xFF25D366),
                        Color(0xFF7CFFB2),
                        Color(0xFF25D366),
                      ],
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(
                          0xFF25D366,
                        ).withOpacity(0.35 + (_pulseCtrl.value * 0.35)),
                        blurRadius: 38,
                        offset: const Offset(0, 16),
                      ),
                    ],
                  ),
                  child: Stack(
                    children: [
                      /// ✨ GLASS SHIMMER
                      Positioned.fill(
                        child: ShaderMask(
                          shaderCallback: (rect) {
                            return LinearGradient(
                              begin: Alignment(-1 + (_waveCtrl.value * 2), -1),
                              end: Alignment(1 + (_waveCtrl.value * 2), 1),
                              colors: const [
                                Colors.transparent,
                                Colors.white38,
                                Colors.transparent,
                              ],
                              stops: const [0.45, 0.5, 0.55],
                            ).createShader(rect);
                          },
                          blendMode: BlendMode.srcATop,
                          child: Container(color: Colors.transparent),
                        ),
                      ),
                      SizedBox(height: 10),

                      /// CONTENT
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: const [
                          Padding(
                            padding: EdgeInsets.only(
                              top: 1,
                            ), // optical correction
                            child: FaIcon(
                              FontAwesomeIcons.whatsapp,
                              color: Colors.white,
                              size: 22,
                            ),
                          ),
                          SizedBox(width: 8),
                          Text(
                            'WhatsApp',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 15,
                              height: 1.0, // IMPORTANT
                              fontWeight: FontWeight.w800,
                              color: Colors.white,
                              letterSpacing: 0.4,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                /// 💥 TAP ENERGY BURST
                if (_spark)
                  Container(
                    height: 18,
                    width: 18,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF25D366),
                          blurRadius: 28,
                        ),
                      ],
                    ),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class CallHRButton extends StatefulWidget {
  final VoidCallback onTap;
  const CallHRButton({super.key, required this.onTap});

  @override
  State<CallHRButton> createState() => _CallHRButtonState();
}

class _CallHRButtonState extends State<CallHRButton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _edgeCtrl;
  bool _pressed = false;

  @override
  void initState() {
    super.initState();
    _edgeCtrl = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat();
  }

  @override
  void dispose() {
    _edgeCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _pressed = true),
      onTapUp: (_) {
        setState(() => _pressed = false);
        widget.onTap();
      },
      onTapCancel: () => setState(() => _pressed = false),
      child: AnimatedScale(
        scale: _pressed ? 0.95 : 1,
        duration: const Duration(milliseconds: 120),
        child: AnimatedBuilder(
          animation: _edgeCtrl,
          builder: (_, __) {
            return Container(
              height: 58,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: const LinearGradient(
                  colors: [Color(0xFF1E40AF), Color(0xFF2563EB)],
                ),
                boxShadow: [
                  BoxShadow(
                    color: const Color(
                      0xFF2563EB,
                    ).withOpacity(0.35 + (_edgeCtrl.value * 0.25)),
                    blurRadius: 34,
                    offset: const Offset(0, 16),
                  ),
                ],
              ),

              child: Stack(
                children: [
                  /// ⚡ EDGE FLOW
                  Positioned.fill(
                    child: CustomPaint(
                      painter: _ElectricBorderPainter(_edgeCtrl.value),
                    ),
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: const [
                      Padding(
                        padding: EdgeInsets.only(top: 1),
                        child: Icon(
                          Icons.call_rounded,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                      SizedBox(width: 8),
                      Text(
                        'Call HR',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 15,
                          height: 1.0,
                          fontWeight: FontWeight.w800,
                          color: Colors.white,
                          letterSpacing: 0.4,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class _ElectricBorderPainter extends CustomPainter {
  final double progress;
  _ElectricBorderPainter(this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    final rRect = RRect.fromRectAndRadius(rect, const Radius.circular(20));
    final path = Path()..addRRect(rRect);
    final metric = path.computeMetrics().first;

    final length = metric.length;
    final start = length * progress;
    final end = start + length * 0.22;

    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.4
      ..strokeCap = StrokeCap.round
      ..shader = const LinearGradient(
        colors: [Colors.transparent, Color(0xFF60A5FA), Colors.transparent],
      ).createShader(rect);

    canvas.drawPath(metric.extractPath(start, end), paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

void openWhatsApp(String phone, {String message = ''}) {
  // later you can use url_launcher
  // final url = "https://wa.me/$phone?text=${Uri.encodeComponent(message)}";
  debugPrint("Opening WhatsApp for $phone");
}

void callHR(String phone) {
  // final url = "tel:$phone";
  debugPrint("Calling HR $phone");
}

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

                  /// JOB DETAILS
                  _JobDescriptionBlock(job: job),
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

class _MetaGlassItem extends StatelessWidget {
  final String title;
  final String value;

  const _MetaGlassItem({required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.85),
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.08), blurRadius: 12),
        ],
      ),
      child: Column(
        children: [
          Text(title, style: const TextStyle(fontSize: 12, color: Colors.grey)),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w800),
          ),
        ],
      ),
    );
  }
}

class _JobDescriptionBlock extends StatelessWidget {
  final JobModel job;

  const _JobDescriptionBlock({required this.job});

  @override
  Widget build(BuildContext context) {
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
        children: const [
          Text(
            'Job Description',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900),
          ),
          SizedBox(height: 14),
          Text(
            'Detailed job responsibilities and requirements '
            'can be provided by the admin here.\n\n'
            'This section is future-ready for rich descriptions.',
            style: TextStyle(height: 1.65),
          ),
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
                Expanded(flex: 2, child: SaveJobButton(onTap: () {})),
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

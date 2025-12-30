import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

enum SelectedRole { none, seeker }

class RoleSelectionScreen extends StatefulWidget {
  const RoleSelectionScreen({super.key});

  @override
  State<RoleSelectionScreen> createState() => _RoleSelectionScreenState();
}

class _RoleSelectionScreenState extends State<RoleSelectionScreen>
    with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late AnimationController _bgController;

  SelectedRole _selectedRole = SelectedRole.none;

  @override
  void initState() {
    super.initState();

    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    )..forward();

    _bgController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    )..repeat();
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _bgController.dispose();
    super.dispose();
  }

  void _selectSeeker() {
    setState(() => _selectedRole = SelectedRole.seeker);
  }

  void _selectRecruiter() {
    Get.snackbar(
      'Coming Soon 🚀',
      'Recruiter features will be available in the next update.',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.black.withOpacity(0.85),
      colorText: Colors.white,
      margin: const EdgeInsets.all(16),
      borderRadius: 16,
    );
  }

  void _continue() {
    if (_selectedRole == SelectedRole.seeker) {
      Get.toNamed('/login');
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool enabled = _selectedRole == SelectedRole.seeker;

    return Scaffold(
      body: AnimatedBuilder(
        animation: _bgController,
        builder: (_, __) {
          return Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment(sin(_bgController.value * pi), -1),
                end: Alignment(-sin(_bgController.value * pi), 1),
                colors: const [
                  Color(0xFFF4F7FF),
                  Color(0xFFEAF0FF),
                  Color(0xFFFFFFFF),
                ],
              ),
            ),
            child: SafeArea(
              child: FadeTransition(
                opacity: _fadeController,
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 420),
                    child: Column(
                      children: [
                        const SizedBox(height: 20),

                        const Text(
                          'Welcome 👋',
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        const SizedBox(height: 6),
                        const Text(
                          'Choose how you want to continue',
                          style: TextStyle(fontSize: 15, color: Colors.black54),
                        ),

                        const SizedBox(height: 24),

                        /// LIST (SCROLLABLE)
                        Expanded(
                          child: ListView(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            children: [
                              _PremiumRoleTile(
                                title: 'Looking for a Job',
                                subtitle:
                                    'Discover verified opportunities and apply with confidence',
                                lottiePath: 'assets/animation/jobseeker.json',
                                accentColor: const Color(0xFF1A73E8),
                                selected: enabled,
                                onTap: _selectSeeker,
                              ),
                              const SizedBox(height: 18),
                              _PremiumRoleTile(
                                title: 'Looking to Hire',
                                subtitle:
                                    'Post jobs and find the right candidates',
                                lottiePath: 'assets/animation/recruiter.json',
                                accentColor: const Color(0xFF7E57C2),
                                selected: false,
                                onTap: _selectRecruiter,
                                badge: 'Available Soon',
                              ),
                            ],
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
                          child: PremiumContinueButton(
                            enabled: enabled,
                            onTap: _continue,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

/* -------------------------------------------------------------------------- */
/*                          PREMIUM ROLE TILE                                 */
/* -------------------------------------------------------------------------- */

class _PremiumRoleTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final String lottiePath;
  final Color accentColor;
  final bool selected;
  final VoidCallback onTap;
  final String? badge;

  const _PremiumRoleTile({
    required this.title,
    required this.subtitle,
    required this.lottiePath,
    required this.accentColor,
    required this.selected,
    required this.onTap,
    this.badge,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 350),
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(26),
          border: Border.all(
            color: selected ? accentColor : Colors.transparent,
            width: 2,
          ),
          boxShadow: [
            BoxShadow(
              color: accentColor.withOpacity(selected ? 0.3 : 0.14),
              blurRadius: selected ? 30 : 18,
              offset: const Offset(0, 14),
            ),
          ],
        ),
        child: Row(
          children: [
            SizedBox(
              height: 82,
              width: 82,
              child: Lottie.asset(lottiePath, fit: BoxFit.contain),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          title,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      if (badge != null)
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.orange.withOpacity(0.15),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            badge!,
                            style: const TextStyle(
                              fontSize: 11,
                              color: Colors.orange,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontSize: 13,
                      color: Colors.black54,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/* -------------------------------------------------------------------------- */
/*                    ULTRA-PREMIUM CONTINUE BUTTON                            */
/* -------------------------------------------------------------------------- */

class PremiumContinueButton extends StatefulWidget {
  final bool enabled;
  final VoidCallback onTap;

  const PremiumContinueButton({
    super.key,
    required this.enabled,
    required this.onTap,
  });

  @override
  State<PremiumContinueButton> createState() => _PremiumContinueButtonState();
}

class _PremiumContinueButtonState extends State<PremiumContinueButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    if (widget.enabled) _controller.repeat();
  }

  @override
  void didUpdateWidget(covariant PremiumContinueButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    widget.enabled ? _controller.repeat() : _controller.stop();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.enabled ? widget.onTap : null,
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 300),
        opacity: widget.enabled ? 1 : 0.6,
        child: AnimatedBuilder(
          animation: _controller,
          builder: (_, __) {
            return Container(
              height: 54,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                gradient: widget.enabled
                    ? LinearGradient(
                        begin: Alignment(-1 + 2 * _controller.value, 0),
                        end: Alignment(1 + 2 * _controller.value, 0),
                        colors: const [
                          Color(0xFF1A73E8),
                          Color(0xFF4D8DFF),
                          Color(0xFF1A73E8),
                        ],
                      )
                    : const LinearGradient(
                        colors: [Color(0xFFBDBDBD), Color(0xFFBDBDBD)],
                      ),
                boxShadow: widget.enabled
                    ? [
                        BoxShadow(
                          color: const Color(0xFF1A73E8).withOpacity(0.4),
                          blurRadius: 26,
                          offset: const Offset(0, 12),
                        ),
                      ]
                    : [],
              ),
              child: Center(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Text(
                      'Continue',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(width: 10),
                    _ArrowMotion(),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _ArrowMotion extends StatefulWidget {
  const _ArrowMotion();

  @override
  State<_ArrowMotion> createState() => _ArrowMotionState();
}

class _ArrowMotionState extends State<_ArrowMotion>
    with SingleTickerProviderStateMixin {
  late AnimationController _arrow;

  @override
  void initState() {
    super.initState();
    _arrow = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _arrow.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: Tween<Offset>(
        begin: Offset.zero,
        end: const Offset(0.25, 0),
      ).animate(CurvedAnimation(parent: _arrow, curve: Curves.easeInOut)),
      child: const Icon(
        Icons.arrow_forward_rounded,
        color: Colors.white,
        size: 20,
      ),
    );
  }
}

import 'dart:math' as math;
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen>
    with TickerProviderStateMixin {
  final PageController _pageController = PageController();
  int _index = 0;

  late AnimationController _auroraController;
  late AnimationController _contentController;

  final List<_OnboardData> _pages = const [
    _OnboardData(
      title: 'Verified Opportunities',
      subtitle:
          'Every job is manually reviewed to ensure authenticity and trust.',
      icon: Icons.verified_outlined,
      colors: [Color(0xFF0A2540), Color(0xFF1A73E8)],
    ),
    _OnboardData(
      title: 'Top Hiring Platforms',
      subtitle:
          'We aggregate jobs from LinkedIn, Naukri, Internshala and more.',
      icon: Icons.public_outlined,
      colors: [Color(0xFF1A73E8), Color(0xFF5B9DFF)],
    ),
    _OnboardData(
      title: 'Apply with Confidence',
      subtitle: 'One tap redirects you to the official job application page.',
      icon: Icons.trending_up_outlined,
      colors: [Color(0xFF5B9DFF), Color(0xFF7BAAF7)],
    ),
  ];

  @override
  void initState() {
    super.initState();

    _auroraController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 12),
    )..repeat();

    _contentController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    )..forward();
  }

  @override
  void dispose() {
    _auroraController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  void _next() {
    if (_index < _pages.length - 1) {
      _contentController.reset();
      _pageController.nextPage(
        duration: const Duration(milliseconds: 700),
        curve: Curves.easeOutExpo,
      );
      _contentController.forward();
    } else {
      Get.offAllNamed('/role');
    }
  }

  @override
  Widget build(BuildContext context) {
    final page = _pages[_index];

    return Scaffold(
      body: AnimatedBuilder(
        animation: _auroraController,
        builder: (context, _) {
          return Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment(
                  math.sin(_auroraController.value * 2 * math.pi),
                  -1,
                ),
                end: Alignment(
                  -math.sin(_auroraController.value * 2 * math.pi),
                  1,
                ),
                colors: page.colors,
              ),
            ),
            child: Stack(
              children: [
                _AuroraBlob(top: -140, left: -100, size: 320),
                _AuroraBlob(bottom: -160, right: -120, size: 380),

                SafeArea(
                  child: Column(
                    children: [
                      _TopBar(
                        index: _index,
                        total: _pages.length,
                        onSkip: () => Get.offAllNamed('/role'),
                      ),

                      Expanded(
                        child: PageView.builder(
                          controller: _pageController,
                          itemCount: _pages.length,
                          onPageChanged: (i) => setState(() => _index = i),
                          itemBuilder: (_, i) => _GlassContent(
                            data: _pages[i],
                            controller: _contentController,
                          ),
                        ),
                      ),

                      _BottomButton(
                        isLast: _index == _pages.length - 1,
                        onTap: _next,
                      ),
                    ],
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

class _GlassContent extends StatelessWidget {
  final _OnboardData data;
  final AnimationController controller;

  const _GlassContent({required this.data, required this.controller});

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: CurvedAnimation(parent: controller, curve: Curves.easeIn),
      child: SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(0, 0.15),
          end: Offset.zero,
        ).animate(CurvedAnimation(parent: controller, curve: Curves.easeOut)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 28),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Hero(
                tag: 'app-logo',
                child: Icon(data.icon, size: 110, color: Colors.white),
              ),
              const SizedBox(height: 44),
              _GlassCard(
                child: Column(
                  children: [
                    Text(
                      data.title,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      data.subtitle,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 15,
                        color: Colors.white70,
                        height: 1.7,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _GlassCard extends StatelessWidget {
  final Widget child;

  const _GlassCard({required this.child});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(28),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
        child: Container(
          padding: const EdgeInsets.all(28),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.15),
            borderRadius: BorderRadius.circular(28),
            border: Border.all(color: Colors.white.withOpacity(0.25)),
          ),
          child: child,
        ),
      ),
    );
  }
}

class _AuroraBlob extends StatelessWidget {
  final double size;
  final double? top, left, bottom, right;

  const _AuroraBlob({
    required this.size,
    this.top,
    this.left,
    this.bottom,
    this.right,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: top,
      left: left,
      bottom: bottom,
      right: right,
      child: Container(
        height: size,
        width: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: RadialGradient(
            colors: [Colors.white.withOpacity(0.18), Colors.transparent],
          ),
        ),
      ),
    );
  }
}

/* -------------------------------------------------------------------------- */
/*                               UI PARTS                                     */
/* -------------------------------------------------------------------------- */

class _TopBar extends StatelessWidget {
  final int index;
  final int total;
  final VoidCallback onSkip;

  const _TopBar({
    required this.index,
    required this.total,
    required this.onSkip,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: List.generate(
              total,
              (i) => AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                margin: const EdgeInsets.only(right: 6),
                width: i <= index ? 22 : 8,
                height: 8,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
          ),
          TextButton(
            onPressed: onSkip,
            child: const Text('Skip', style: TextStyle(color: Colors.white70)),
          ),
        ],
      ),
    );
  }
}

class _BottomButton extends StatelessWidget {
  final bool isLast;
  final VoidCallback onTap;

  const _BottomButton({required this.isLast, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 0, 24, 40),
      child: SizedBox(
        width: double.infinity,
        height: 56,
        child: ElevatedButton(
          onPressed: onTap,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            foregroundColor: Colors.black,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18),
            ),
          ),
          child: Text(
            isLast ? 'Get Started' : 'Next',
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
        ),
      ),
    );
  }
}

/* -------------------------------------------------------------------------- */
/*                               DATA MODEL                                   */
/* -------------------------------------------------------------------------- */

class _OnboardData {
  final String title;
  final String subtitle;
  final IconData icon;
  final List<Color> colors;

  const _OnboardData({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.colors,
  });
}

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
//import 'package:jobportal/features/home/jobs_list_screen.dart';
//import 'package:jobportal/features/home/jobtyprebadge.dart';
//import 'package:jobportal/features/profile/profile_screen.dart';
import 'package:jobportal/jobseeker/features/home/jobs_list_screen.dart';
import 'package:jobportal/jobseeker/features/home/jobtyprebadge.dart';
import 'package:jobportal/jobseeker/features/profile/profile_screen.dart';
import 'package:jobportal/jobseeker/features/profile/shimmerprofile.dart';
//import 'package:jobportal/features/profile/shimmerprofile.dart';

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
              child: GlassSearchBar(),
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

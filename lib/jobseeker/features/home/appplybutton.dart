import 'dart:math';

import 'package:flutter/material.dart';

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

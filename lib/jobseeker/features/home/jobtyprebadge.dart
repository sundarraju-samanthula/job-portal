import 'package:flutter/material.dart';

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

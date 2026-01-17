import 'package:flutter/material.dart';

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

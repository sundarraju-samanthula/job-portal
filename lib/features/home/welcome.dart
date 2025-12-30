import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class WelcomeSection extends StatelessWidget {
  final String name;

  const WelcomeSection({required this.name});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Hello, $name 👋',
          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 4),
        const Text(
          'Find verified jobs and apply with confidence',
          style: TextStyle(fontSize: 14, color: Colors.black54),
        ),
      ],
    );
  }
}

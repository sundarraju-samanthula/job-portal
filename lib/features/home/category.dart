import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CategoryChips extends StatelessWidget {
  final List<String> categories = const [
    'All',
    'Remote',
    'Work From Home',
    'IT',
    'Non-IT',
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 38,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemBuilder: (_, index) {
          return Chip(
            label: Text(categories[index]),
            backgroundColor: index == 0
                ? const Color(0xFF1A73E8)
                : Colors.white,
            labelStyle: TextStyle(
              color: index == 0 ? Colors.white : Colors.black,
            ),
          );
        },
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemCount: categories.length,
      ),
    );
  }
}

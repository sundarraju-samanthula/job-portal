import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class JobCard extends StatelessWidget {
  final String title;
  final String company;
  final String location;
  final VoidCallback onApply;

  const JobCard({
    required this.title,
    required this.company,
    required this.location,
    required this.onApply,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 6),
          Text(company, style: const TextStyle(color: Colors.black54)),
          const SizedBox(height: 6),
          Row(
            children: [
              const Icon(Icons.location_on, size: 16, color: Colors.black45),
              const SizedBox(width: 4),
              Text(location),
              const Spacer(),
              ElevatedButton(
                onPressed: onApply,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1A73E8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text('Apply'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
//import 'package:flutter/widgets.dart';

class JobList extends StatelessWidget {
  const JobList();

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: 6,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (_, index) {
        return JobCard(
          title: 'Flutter Developer',
          company: 'Tech Solutions Pvt Ltd',
          location: 'Remote',
          onApply: () {},
        );
      },
    );
  }
}

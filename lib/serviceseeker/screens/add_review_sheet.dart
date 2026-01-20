import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/worker_profile_controller.dart';

class AddReviewSheet extends StatefulWidget {
  final WorkerProfileController controller;
  const AddReviewSheet({super.key, required this.controller});

  @override
  State<AddReviewSheet> createState() => _AddReviewSheetState();
}

class _AddReviewSheetState extends State<AddReviewSheet> {
  double rating = 5;
  final commentCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
        left: 20,
        right: 20,
        top: 20,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            "Add Review",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
          ),

          const SizedBox(height: 16),

          Slider(
            value: rating,
            min: 1,
            max: 5,
            divisions: 4,
            label: rating.toString(),
            onChanged: (v) => setState(() => rating = v),
          ),

          TextField(
            controller: commentCtrl,
            maxLines: 3,
            decoration: const InputDecoration(
              hintText: "Write your experience...",
              border: OutlineInputBorder(),
            ),
          ),

          const SizedBox(height: 14),

          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () async {
                await widget.controller.addReview(
                  userId: "demoUser",
                  userName: "User",
                  comment: commentCtrl.text.trim(),
                  rating: rating,
                );

                Get.back();
                Get.snackbar("Success", "Review added");
              },
              child: const Text("Submit"),
            ),
          ),
        ],
      ),
    );
  }
}

// // // // // // // // // // import 'package:cloud_firestore/cloud_firestore.dart';
// // // // // // // // // // import 'package:get/get.dart';
// // // // // // // // // // import '../model/review_model.dart';

// // // // // // // // // // class WorkerProfileController extends GetxController {
// // // // // // // // // //   final String workerId;
// // // // // // // // // //   WorkerProfileController(this.workerId);

// // // // // // // // // //   final _db = FirebaseFirestore.instance;

// // // // // // // // // //   RxBool isLoading = true.obs;
// // // // // // // // // //   RxList<ReviewModel> reviews = <ReviewModel>[].obs;

// // // // // // // // // //   @override
// // // // // // // // // //   void onInit() {
// // // // // // // // // //     super.onInit();
// // // // // // // // // //     fetchReviews();
// // // // // // // // // //   }

// // // // // // // // // //   void fetchReviews() {
// // // // // // // // // //     _db
// // // // // // // // // //         .collection('workers')
// // // // // // // // // //         .doc(workerId)
// // // // // // // // // //         .collection('totalReviews')
// // // // // // // // // //         .orderBy('createdAt', descending: true)
// // // // // // // // // //         .snapshots()
// // // // // // // // // //         .listen((snapshot) {
// // // // // // // // // //       final list = snapshot.docs
// // // // // // // // // //           .map((doc) => ReviewModel.fromFirestore(doc.data(), doc.id))
// // // // // // // // // //           .toList();

// // // // // // // // // //       reviews.value = list;
// // // // // // // // // //       isLoading.value = false;
// // // // // // // // // //     });
// // // // // // // // // //   }

// // // // // // // // // //   Future<void> addReview({
// // // // // // // // // //     required String userId,
// // // // // // // // // //     required String userName,
// // // // // // // // // //     required String comment,
// // // // // // // // // //     required double rating,
// // // // // // // // // //   }) async {
// // // // // // // // // //     final ref = _db.collection('workers').doc(workerId);

// // // // // // // // // //     final reviewRef = ref.collection('totalReviews').doc();

// // // // // // // // // //     await reviewRef.set({
// // // // // // // // // //       'userId': userId,
// // // // // // // // // //       'userName': userName,
// // // // // // // // // //       'comment': comment,
// // // // // // // // // //       'rating': rating,
// // // // // // // // // //       'createdAt': FieldValue.serverTimestamp(),
// // // // // // // // // //     });

// // // // // // // // // //     await _updateRatingStats();
// // // // // // // // // //   }

// // // // // // // // // //   Future<void> _updateRatingStats() async {
// // // // // // // // // //     final snap = await _db
// // // // // // // // // //         .collection('workers')
// // // // // // // // // //         .doc(workerId)
// // // // // // // // // //         .collection('totalReviews')
// // // // // // // // // //         .get();

// // // // // // // // // //     if (snap.docs.isEmpty) return;

// // // // // // // // // //     double total = 0;
// // // // // // // // // //     for (var doc in snap.docs) {
// // // // // // // // // //       total += (doc.data()['rating'] ?? 0).toDouble();
// // // // // // // // // //     }

// // // // // // // // // //     final avg = total / snap.docs.length;

// // // // // // // // // //     await _db.collection('workers').doc(workerId).update({
// // // // // // // // // //       'averageRating': avg,
// // // // // // // // // //       'totalReviews': snap.docs.length,
// // // // // // // // // //     });
// // // // // // // // // //   }
// // // // // // // // // // }
// // // // // // // // // import 'package:cloud_firestore/cloud_firestore.dart';
// // // // // // // // // import 'package:get/get.dart';
// // // // // // // // // import '../model/review_model.dart';
// // // // // // // // // import 'package:flutter/material.dart';

// // // // // // // // // class WorkerProfileController extends GetxController {
// // // // // // // // //   final String workerId;
// // // // // // // // //   WorkerProfileController(this.workerId);

// // // // // // // // //   final _db = FirebaseFirestore.instance;

// // // // // // // // //   RxList<ReviewModel> reviews = <ReviewModel>[].obs;
// // // // // // // // //   RxBool isLoading = true.obs;

// // // // // // // // //   RxDouble rating = 0.0.obs;
// // // // // // // // //   RxString comment = ''.obs;

// // // // // // // // //   @override
// // // // // // // // //   void onInit() {
// // // // // // // // //     super.onInit();
// // // // // // // // //     fetchReviews();
// // // // // // // // //   }

// // // // // // // // //   void fetchReviews() {
// // // // // // // // //     _db
// // // // // // // // //         .collection('workers')
// // // // // // // // //         .doc(workerId)
// // // // // // // // //         .collection('reviews')
// // // // // // // // //         .orderBy('createdAt', descending: true)
// // // // // // // // //         .snapshots()
// // // // // // // // //         .listen((snapshot) {
// // // // // // // // //           reviews.value = snapshot.docs
// // // // // // // // //               .map((e) => ReviewModel.fromFirestore(e.data(), e.id))
// // // // // // // // //               .toList();
// // // // // // // // //           isLoading.value = false;
// // // // // // // // //         });
// // // // // // // // //   }

// // // // // // // // //   void openAddReviewSheet() {
// // // // // // // // //     Get.bottomSheet(_buildAddReviewSheet());
// // // // // // // // //   }

// // // // // // // // //   Widget _buildAddReviewSheet() {
// // // // // // // // //     return Container(
// // // // // // // // //       padding: const EdgeInsets.all(20),
// // // // // // // // //       decoration: const BoxDecoration(
// // // // // // // // //         color: Colors.white,
// // // // // // // // //         borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
// // // // // // // // //       ),
// // // // // // // // //       child: Column(
// // // // // // // // //         mainAxisSize: MainAxisSize.min,
// // // // // // // // //         children: [
// // // // // // // // //           const Text(
// // // // // // // // //             "Add Review",
// // // // // // // // //             style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
// // // // // // // // //           ),

// // // // // // // // //           const SizedBox(height: 16),

// // // // // // // // //           Obx(
// // // // // // // // //             () => Row(
// // // // // // // // //               children: List.generate(5, (index) {
// // // // // // // // //                 return IconButton(
// // // // // // // // //                   onPressed: () => rating.value = index + 1,
// // // // // // // // //                   icon: Icon(
// // // // // // // // //                     Icons.star,
// // // // // // // // //                     color: index < rating.value ? Colors.amber : Colors.grey,
// // // // // // // // //                   ),
// // // // // // // // //                 );
// // // // // // // // //               }),
// // // // // // // // //             ),
// // // // // // // // //           ),

// // // // // // // // //           TextField(
// // // // // // // // //             onChanged: (v) => comment.value = v,
// // // // // // // // //             decoration: const InputDecoration(hintText: "Write your review..."),
// // // // // // // // //           ),

// // // // // // // // //           const SizedBox(height: 16),

// // // // // // // // //           ElevatedButton(onPressed: submitReview, child: const Text("Submit")),
// // // // // // // // //         ],
// // // // // // // // //       ),
// // // // // // // // //     );
// // // // // // // // //   }

// // // // // // // // //   Future<void> submitReview() async {
// // // // // // // // //     if (rating.value == 0) return;

// // // // // // // // //     final workerRef = _db.collection('workers').doc(workerId);
// // // // // // // // //     final reviewRef = workerRef.collection('reviews');

// // // // // // // // //     await reviewRef.add({
// // // // // // // // //       'userName': 'Anonymous',
// // // // // // // // //       'rating': rating.value,
// // // // // // // // //       'comment': comment.value,
// // // // // // // // //       'createdAt': DateTime.now().toIso8601String(),
// // // // // // // // //     });

// // // // // // // // //     final snapshot = await reviewRef.get();
// // // // // // // // //     double total = 0;

// // // // // // // // //     for (var doc in snapshot.docs) {
// // // // // // // // //       total += (doc['rating'] as num).toDouble();
// // // // // // // // //     }

// // // // // // // // //     final avg = snapshot.docs.isEmpty ? 0 : total / snapshot.docs.length;

// // // // // // // // //     await workerRef.update({
// // // // // // // // //       'avgRating': avg,
// // // // // // // // //       'reviewCount': snapshot.docs.length,
// // // // // // // // //     });

// // // // // // // // //     rating.value = 0;
// // // // // // // // //     comment.value = '';

// // // // // // // // //     Get.back();
// // // // // // // // //   }
// // // // // // // // // }
// // // // // // // // import 'package:cloud_firestore/cloud_firestore.dart';
// // // // // // // // import 'package:get/get.dart';
// // // // // // // // import '../model/review_model.dart';
// // // // // // // // import 'package:flutter/material.dart';

// // // // // // // // class WorkerProfileController extends GetxController {
// // // // // // // //   final String workerId;
// // // // // // // //   WorkerProfileController(this.workerId);

// // // // // // // //   final _db = FirebaseFirestore.instance;

// // // // // // // //   RxList<ReviewModel> reviews = <ReviewModel>[].obs;
// // // // // // // //   RxBool isLoading = true.obs;

// // // // // // // //   RxDouble rating = 0.0.obs;
// // // // // // // //   RxString comment = ''.obs;

// // // // // // // //   @override
// // // // // // // //   void onInit() {
// // // // // // // //     super.onInit();
// // // // // // // //     fetchReviews();
// // // // // // // //   }

// // // // // // // //   void fetchReviews() {
// // // // // // // //     _db
// // // // // // // //         .collection('workers')
// // // // // // // //         .doc(workerId)
// // // // // // // //         .collection('reviews')
// // // // // // // //         .orderBy('createdAt', descending: true)
// // // // // // // //         .snapshots()
// // // // // // // //         .listen((snapshot) {
// // // // // // // //       reviews.value = snapshot.docs
// // // // // // // //           .map((e) => ReviewModel.fromFirestore(e.data(), e.id))
// // // // // // // //           .toList();
// // // // // // // //       isLoading.value = false;
// // // // // // // //     });
// // // // // // // //   }

// // // // // // // //   void openAddReviewSheet() {
// // // // // // // //     Get.bottomSheet(_buildAddReviewSheet());
// // // // // // // //   }

// // // // // // // //   Widget _buildAddReviewSheet() {
// // // // // // // //     return Container(
// // // // // // // //       padding: const EdgeInsets.all(20),
// // // // // // // //       decoration: const BoxDecoration(
// // // // // // // //         color: Colors.white,
// // // // // // // //         borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
// // // // // // // //       ),
// // // // // // // //       child: Column(
// // // // // // // //         mainAxisSize: MainAxisSize.min,
// // // // // // // //         children: [
// // // // // // // //           const Text("Add Review",
// // // // // // // //               style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800)),

// // // // // // // //           const SizedBox(height: 16),

// // // // // // // //           Obx(() => Row(
// // // // // // // //                 children: List.generate(5, (index) {
// // // // // // // //                   return IconButton(
// // // // // // // //                     onPressed: () => rating.value = index + 1,
// // // // // // // //                     icon: Icon(
// // // // // // // //                       Icons.star,
// // // // // // // //                       color: index < rating.value
// // // // // // // //                           ? Colors.amber
// // // // // // // //                           : Colors.grey,
// // // // // // // //                     ),
// // // // // // // //                   );
// // // // // // // //                 }),
// // // // // // // //               )),

// // // // // // // //           TextField(
// // // // // // // //             onChanged: (v) => comment.value = v,
// // // // // // // //             decoration: const InputDecoration(
// // // // // // // //               hintText: "Write your review...",
// // // // // // // //             ),
// // // // // // // //           ),

// // // // // // // //           const SizedBox(height: 16),

// // // // // // // //           ElevatedButton(
// // // // // // // //             onPressed: submitReview,
// // // // // // // //             child: const Text("Submit"),
// // // // // // // //           )
// // // // // // // //         ],
// // // // // // // //       ),
// // // // // // // //     );
// // // // // // // //   }

// // // // // // // //   Future<void> submitReview() async {
// // // // // // // //     if (rating.value == 0) return;

// // // // // // // //     final workerRef = _db.collection('workers').doc(workerId);
// // // // // // // //     final reviewRef = workerRef.collection('reviews');

// // // // // // // //     await reviewRef.add({
// // // // // // // //       'userName': 'Anonymous',
// // // // // // // //       'rating': rating.value,
// // // // // // // //       'comment': comment.value,
// // // // // // // //       'createdAt': DateTime.now().toIso8601String(),
// // // // // // // //     });

// // // // // // // //     final snapshot = await reviewRef.get();
// // // // // // // //     double total = 0;

// // // // // // // //     for (var doc in snapshot.docs) {
// // // // // // // //       total += (doc['rating'] as num).toDouble();
// // // // // // // //     }

// // // // // // // //     final avg = snapshot.docs.isEmpty ? 0 : total / snapshot.docs.length;

// // // // // // // //     await workerRef.update({
// // // // // // // //       'avgRating': avg,
// // // // // // // //       'reviewCount': snapshot.docs.length,
// // // // // // // //     });

// // // // // // // //     rating.value = 0;
// // // // // // // //     comment.value = '';

// // // // // // // //     Get.back();
// // // // // // // //   }
// // // // // // // // }
// // // // // // // import 'package:cloud_firestore/cloud_firestore.dart';
// // // // // // // import 'package:get/get.dart';
// // // // // // // import '../model/review_model.dart';

// // // // // // // class WorkerProfileController extends GetxController {
// // // // // // //   final FirebaseFirestore _db = FirebaseFirestore.instance;

// // // // // // //   final String workerId;

// // // // // // //   WorkerProfileController(this.workerId);

// // // // // // //   RxList<ReviewModel> reviews = <ReviewModel>[].obs;
// // // // // // //   RxDouble averageRating = 0.0.obs;
// // // // // // //   RxBool isLoading = true.obs;

// // // // // // //   @override
// // // // // // //   void onInit() {
// // // // // // //     super.onInit();
// // // // // // //     fetchReviews();
// // // // // // //   }

// // // // // // //   /// 🔥 Fetch reviews
// // // // // // //   void fetchReviews() {
// // // // // // //     _db
// // // // // // //         .collection('workers')
// // // // // // //         .doc(workerId)
// // // // // // //         .collection('reviews') // ✅ FIXED
// // // // // // //         .orderBy('createdAt', descending: true)
// // // // // // //         .snapshots()
// // // // // // //         .listen((snapshot) {
// // // // // // //           final list = snapshot.docs
// // // // // // //               .map((doc) => ReviewModel.fromFirestore(doc.data(), doc.id))
// // // // // // //               .toList();

// // // // // // //           reviews.value = list;
// // // // // // //           calculateAverage();
// // // // // // //           isLoading.value = false;
// // // // // // //         });
// // // // // // //   }

// // // // // // //   /// ⭐ Add review
// // // // // // //   Future<void> addReview({
// // // // // // //     required String userId,
// // // // // // //     required String userName,
// // // // // // //     required String comment,
// // // // // // //     required double rating,
// // // // // // //   }) async {
// // // // // // //     final ref = _db
// // // // // // //         .collection('workers')
// // // // // // //         .doc(workerId)
// // // // // // //         .collection('reviews'); // ✅ FIXED

// // // // // // //     await ref.add({
// // // // // // //       'userId': userId,
// // // // // // //       'userName': userName,
// // // // // // //       'comment': comment,
// // // // // // //       'rating': rating,
// // // // // // //       'createdAt': FieldValue.serverTimestamp(),
// // // // // // //     });

// // // // // // //     await updateWorkerRating();
// // // // // // //   }

// // // // // // //   /// 📊 Calculate locally
// // // // // // //   void calculateAverage() {
// // // // // // //     if (reviews.isEmpty) {
// // // // // // //       averageRating.value = 0;
// // // // // // //       return;
// // // // // // //     }

// // // // // // //     double total = 0;
// // // // // // //     for (var r in reviews) {
// // // // // // //       total += r.rating;
// // // // // // //     }

// // // // // // //     averageRating.value = total / reviews.length;
// // // // // // //   }

// // // // // // //   /// 🔁 Save average in worker doc
// // // // // // //   Future<void> updateWorkerRating() async {
// // // // // // //     final workerRef = _db.collection('workers').doc(workerId);

// // // // // // //     final snapshot = await workerRef.collection('reviews').get(); // ✅ FIXED

// // // // // // //     if (snapshot.docs.isEmpty) return;

// // // // // // //     double total = 0;
// // // // // // //     for (var doc in snapshot.docs) {
// // // // // // //       total += (doc['rating'] ?? 0).toDouble();
// // // // // // //     }

// // // // // // //     double avg = total / snapshot.docs.length;

// // // // // // //     await workerRef.update({'averageRating': avg});
// // // // // // //   }
// // // // // // // }
// // // // // // import 'package:cloud_firestore/cloud_firestore.dart';
// // // // // // import 'package:get/get.dart';
// // // // // // import '../model/review_model.dart';

// // // // // // class WorkerProfileController extends GetxController {
// // // // // //   final FirebaseFirestore _db = FirebaseFirestore.instance;
// // // // // //   final String workerId;

// // // // // //   WorkerProfileController(this.workerId);

// // // // // //   RxList<ReviewModel> reviews = <ReviewModel>[].obs;
// // // // // //   RxDouble averageRating = 0.0.obs;
// // // // // //   RxBool isLoading = true.obs;

// // // // // //   @override
// // // // // //   void onInit() {
// // // // // //     super.onInit();
// // // // // //     fetchReviews();
// // // // // //   }

// // // // // //   void fetchReviews() {
// // // // // //     _db
// // // // // //         .collection('workers')
// // // // // //         .doc(workerId)
// // // // // //         .collection('reviews')
// // // // // //         .orderBy('createdAt', descending: true)
// // // // // //         .snapshots()
// // // // // //         .listen((snapshot) {
// // // // // //           final list = snapshot.docs
// // // // // //               .map((doc) => ReviewModel.fromFirestore(doc.data(), doc.id))
// // // // // //               .toList();

// // // // // //           reviews.value = list;
// // // // // //           calculateAverage();
// // // // // //           isLoading.value = false;
// // // // // //         });
// // // // // //   }

// // // // // //   Future<void> addReview({
// // // // // //     required String userId,
// // // // // //     required String userName,
// // // // // //     required String comment,
// // // // // //     required double rating,
// // // // // //   }) async {
// // // // // //     final ref = _db.collection('workers').doc(workerId).collection('reviews');

// // // // // //     await ref.add({
// // // // // //       'userId': userId,
// // // // // //       'userName': userName,
// // // // // //       'comment': comment,
// // // // // //       'rating': rating,
// // // // // //       'createdAt': FieldValue.serverTimestamp(),
// // // // // //     });

// // // // // //     await updateWorkerRating();
// // // // // //   }

// // // // // //   void calculateAverage() {
// // // // // //     if (reviews.isEmpty) {
// // // // // //       averageRating.value = 0;
// // // // // //       return;
// // // // // //     }

// // // // // //     double total = 0;
// // // // // //     for (var r in reviews) {
// // // // // //       total += r.rating;
// // // // // //     }

// // // // // //     averageRating.value = total / reviews.length;
// // // // // //   }

// // // // // //   Future<void> updateWorkerRating() async {
// // // // // //     final workerRef = _db.collection('workers').doc(workerId);
// // // // // //     final snapshot = await workerRef.collection('reviews').get();

// // // // // //     if (snapshot.docs.isEmpty) return;

// // // // // //     double total = 0;
// // // // // //     for (var doc in snapshot.docs) {
// // // // // //       total += (doc['rating'] ?? 0).toDouble();
// // // // // //     }

// // // // // //     double avg = total / snapshot.docs.length;

// // // // // //     await workerRef.update({'averageRating': avg});
// // // // // //   }
// // // // // // }
// // // // // import 'package:cloud_firestore/cloud_firestore.dart';
// // // // // import 'package:get/get.dart';
// // // // // import '../model/review_model.dart';

// // // // // class WorkerProfileController extends GetxController {
// // // // //   final FirebaseFirestore _db = FirebaseFirestore.instance;

// // // // //   late String workerId;

// // // // //   RxList<ReviewModel> reviews = <ReviewModel>[].obs;
// // // // //   RxDouble averageRating = 0.0.obs;
// // // // //   RxInt totalReviews = 0.obs;
// // // // //   RxBool isLoading = true.obs;

// // // // //   void init(String id) {
// // // // //     workerId = id;
// // // // //     fetchWorkerStats();
// // // // //     fetchReviews();
// // // // //   }

// // // // //   void fetchWorkerStats() {
// // // // //     _db.collection('workers').doc(workerId).snapshots().listen((doc) {
// // // // //       if (doc.exists) {
// // // // //         final data = doc.data()!;
// // // // //         averageRating.value = (data['averageRating'] ?? 0).toDouble();
// // // // //         totalReviews.value = (data['totalReviews'] ?? 0);
// // // // //       }
// // // // //     });
// // // // //   }

// // // // //   void fetchReviews() {
// // // // //     _db
// // // // //         .collection('workers')
// // // // //         .doc(workerId)
// // // // //         .collection('reviews')
// // // // //         .orderBy('createdAt', descending: true)
// // // // //         .snapshots()
// // // // //         .listen((snapshot) {
// // // // //       reviews.value = snapshot.docs
// // // // //           .map((e) => ReviewModel.fromFirestore(e.data(), e.id))
// // // // //           .toList();
// // // // //       isLoading.value = false;
// // // // //     });
// // // // //   }

// // // // //   /// ⭐ ADD REVIEW (TRANSACTION SAFE)
// // // // //   Future<void> addReview({
// // // // //     required String userId,
// // // // //     required String userName,
// // // // //     required double rating,
// // // // //     required String comment,
// // // // //   }) async {
// // // // //     final workerRef = _db.collection('workers').doc(workerId);
// // // // //     final reviewRef = workerRef.collection('reviews').doc();

// // // // //     await _db.runTransaction((transaction) async {
// // // // //       final workerSnap = await transaction.get(workerRef);

// // // // //       double currentAvg = 0;
// // // // //       int currentTotal = 0;

// // // // //       if (workerSnap.exists) {
// // // // //         currentAvg = (workerSnap['averageRating'] ?? 0).toDouble();
// // // // //         currentTotal = (workerSnap['totalReviews'] ?? 0);
// // // // //       }

// // // // //       final newTotal = currentTotal + 1;
// // // // //       final newAvg =
// // // // //           ((currentAvg * currentTotal) + rating) / newTotal;

// // // // //       transaction.set(reviewRef, {
// // // // //         'userId': userId,
// // // // //         'userName': userName,
// // // // //         'rating': rating,
// // // // //         'comment': comment,
// // // // //         'createdAt': FieldValue.serverTimestamp(),
// // // // //       });

// // // // //       transaction.update(workerRef, {
// // // // //         'averageRating': newAvg,
// // // // //         'totalReviews': newTotal,
// // // // //       });
// // // // //     });
// // // // //   }
// // // // // }
// // // // import 'package:cloud_firestore/cloud_firestore.dart';
// // // // import 'package:get/get.dart';
// // // // import '../model/review_model.dart';

// // // // class WorkerProfileController extends GetxController {
// // // //   final FirebaseFirestore _db = FirebaseFirestore.instance;

// // // //   late String workerId;

// // // //   RxList<ReviewModel> reviews = <ReviewModel>[].obs;
// // // //   RxDouble averageRating = 0.0.obs;
// // // //   RxInt totalReviews = 0.obs;
// // // //   RxBool isLoading = true.obs;

// // // //   void init(String id) {
// // // //     workerId = id;
// // // //     fetchWorkerStats();
// // // //     fetchReviews();
// // // //   }

// // // //   void fetchWorkerStats() {
// // // //     _db.collection('workers').doc(workerId).snapshots().listen((doc) {
// // // //       if (doc.exists) {
// // // //         final data = doc.data()!;
// // // //         averageRating.value = (data['averageRating'] ?? 0).toDouble();
// // // //         totalReviews.value = (data['totalReviews'] ?? 0);
// // // //       }
// // // //     });
// // // //   }

// // // //   void fetchReviews() {
// // // //     _db
// // // //         .collection('workers')
// // // //         .doc(workerId)
// // // //         .collection('reviews')
// // // //         .orderBy('createdAt', descending: true)
// // // //         .snapshots()
// // // //         .listen((snapshot) {
// // // //           reviews.value = snapshot.docs
// // // //               .map((e) => ReviewModel.fromFirestore(e.data(), e.id))
// // // //               .toList();
// // // //           isLoading.value = false;
// // // //         });
// // // //   }

// // // //   Future<void> addReview({
// // // //     required String userId,
// // // //     required String userName,
// // // //     required double rating,
// // // //     required String comment,
// // // //   }) async {
// // // //     final workerRef = _db.collection('workers').doc(workerId);
// // // //     final reviewRef = workerRef.collection('reviews').doc();

// // // //     await _db.runTransaction((transaction) async {
// // // //       final workerSnap = await transaction.get(workerRef);

// // // //       double currentAvg = 0;
// // // //       int currentTotal = 0;

// // // //       if (workerSnap.exists) {
// // // //         currentAvg = (workerSnap['averageRating'] ?? 0).toDouble();
// // // //         currentTotal = (workerSnap['totalReviews'] ?? 0);
// // // //       }

// // // //       final newTotal = currentTotal + 1;
// // // //       final newAvg = ((currentAvg * currentTotal) + rating) / newTotal;

// // // //       transaction.set(reviewRef, {
// // // //         'userId': userId,
// // // //         'userName': userName,
// // // //         'rating': rating,
// // // //         'comment': comment,
// // // //         'createdAt': FieldValue.serverTimestamp(),
// // // //       });

// // // //       transaction.update(workerRef, {
// // // //         'averageRating': newAvg,
// // // //         'totalReviews': newTotal,
// // // //       });
// // // //     });
// // // //   }
// // // // }
// // // import 'package:cloud_firestore/cloud_firestore.dart';
// // // import 'package:get/get_rx/src/rx_types/rx_types.dart';
// // // import 'package:get/get_state_manager/src/simple/get_controllers.dart';
// // // import 'package:jobportal/serviceseeker/model/review_model.dart';

// // // class WorkerProfileController extends GetxController {
// // //   final FirebaseFirestore _db = FirebaseFirestore.instance;

// // //   final String workerId;

// // //   WorkerProfileController(this.workerId);

// // //   RxList<ReviewModel> reviews = <ReviewModel>[].obs;
// // //   RxDouble averageRating = 0.0.obs;
// // //   RxInt totalReviews = 0.obs;
// // //   RxBool isLoading = true.obs;

// // //   @override
// // //   void onInit() {
// // //     super.onInit();
// // //     fetchReviews();
// // //   }

// // //   void fetchReviews() {
// // //     _db
// // //         .collection('workers')
// // //         .doc(workerId)
// // //         .collection('reviews')
// // //         .orderBy('createdAt', descending: true)
// // //         .snapshots()
// // //         .listen((snapshot) {
// // //       final list = snapshot.docs
// // //           .map((e) => ReviewModel.fromFirestore(e.data(), e.id))
// // //           .toList();

// // //       reviews.value = list;
// // //       _recalculateRatings(list);
// // //       isLoading.value = false;
// // //     });
// // //   }

// // //   Future<void> addReview({
// // //     required String userId,
// // //     required String userName,
// // //     required double rating,
// // //     required String comment,
// // //   }) async {
// // //     final reviewRef = _db
// // //         .collection('workers')
// // //         .doc(workerId)
// // //         .collection('reviews')
// // //         .doc();

// // //     await _db.runTransaction((txn) async {
// // //       final workerRef = _db.collection('workers').doc(workerId);
// // //       final workerSnap = await txn.get(workerRef);

// // //       double currentAvg = (workerSnap['averageRating'] ?? 0).toDouble();
// // //       int currentCount = (workerSnap['totalReviews'] ?? 0);

// // //       double newAvg =
// // //           ((currentAvg * currentCount) + rating) / (currentCount + 1);

// // //       txn.set(reviewRef, {
// // //         'userId': userId,
// // //         'userName': userName,
// // //         'rating': rating,
// // //         'comment': comment,
// // //         'createdAt': FieldValue.serverTimestamp(),
// // //       });

// // //       txn.update(workerRef, {
// // //         'averageRating': newAvg,
// // //         'totalReviews': currentCount + 1,
// // //       });
// // //     });
// // //   }

// // //   void _recalculateRatings(List<ReviewModel> list) {
// // //     if (list.isEmpty) {
// // //       averageRating.value = 0;
// // //       totalReviews.value = 0;
// // //       return;
// // //     }

// // //     double sum = 0;
// // //     for (var r in list) {
// // //       sum += r.rating;
// // //     }

// // //     averageRating.value = sum / list.length;
// // //     totalReviews.value = list.length;
// // //   }
// // // }
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:jobportal/serviceseeker/model/review_model.dart';

class WorkerProfileController extends GetxController {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final String workerId;

  WorkerProfileController(this.workerId);

  RxList<ReviewModel> reviews = <ReviewModel>[].obs;
  RxDouble averageRating = 0.0.obs;
  RxInt totalReviews = 0.obs;
  RxBool isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchReviews();
  }

  void fetchReviews() {
    _db
        .collection('workers')
        .doc(workerId)
        .collection('reviews')
        .orderBy('createdAt', descending: true)
        .snapshots()
        .listen((snapshot) {
          final list = snapshot.docs
              .map((e) => ReviewModel.fromFirestore(e.data(), e.id))
              .toList();

          reviews.value = list;
          _recalculateRatings(list);
          isLoading.value = false;
        });
  }

  Future<void> addReview({
    required String userId,
    required String userName,
    required double rating,
    required String comment,
  }) async {
    final reviewRef = _db
        .collection('workers')
        .doc(workerId)
        .collection('reviews')
        .doc();

    await _db.runTransaction((txn) async {
      final workerRef = _db.collection('workers').doc(workerId);
      final workerSnap = await txn.get(workerRef);

      double currentAvg = (workerSnap.data()?['averageRating'] ?? 0).toDouble();
      int currentCount = (workerSnap.data()?['totalReviews'] ?? 0);

      double newAvg =
          ((currentAvg * currentCount) + rating) / (currentCount + 1);

      txn.set(reviewRef, {
        'userId': userId,
        'userName': userName,
        'rating': rating,
        'comment': comment,
        'createdAt': FieldValue.serverTimestamp(),
      });

      txn.update(workerRef, {
        'averageRating': newAvg,
        'totalReviews': currentCount + 1,
      });
    });
  }

  void _recalculateRatings(List<ReviewModel> list) {
    if (list.isEmpty) {
      averageRating.value = 0;
      totalReviews.value = 0;
      return;
    }

    double sum = 0;
    for (var r in list) {
      sum += r.rating;
    }

    averageRating.value = sum / list.length;
    totalReviews.value = list.length;
  }
}
// class WorkerProfileController extends GetxController {
//   final FirebaseFirestore _db = FirebaseFirestore.instance;
//   final String workerId;

//   WorkerProfileController(this.workerId);

//   RxList<ReviewModel> reviews = <ReviewModel>[].obs;
//   RxDouble averageRating = 0.0.obs;
//   RxInt totalReviews = 0.obs;
//   RxBool isLoading = true.obs;

//   @override
//   void onInit() {
//     super.onInit();
//     fetchReviews();
//   }

//   void fetchReviews() {
//     _db
//         .collection('workers')
//         .doc(workerId)
//         .collection('reviews')
//         .orderBy('createdAt', descending: true)
//         .snapshots()
//         .listen((snapshot) {
//           final list = snapshot.docs
//               .map((e) => ReviewModel.fromFirestore(e.data(), e.id))
//               .toList();

//           reviews.value = list;
//           _recalculate(list);
//           isLoading.value = false;
//         });
//   }

//   Future<void> addReview({
//     required String userId,
//     required String userName,
//     required double rating,
//     required String comment,
//   }) async {
//     final workerRef = _db.collection('workers').doc(workerId);
//     final reviewRef = workerRef.collection('reviews').doc();

//     await _db.runTransaction((txn) async {
//       final snap = await txn.get(workerRef);

//       double currentAvg = (snap['averageRating'] ?? 0).toDouble();
//       int currentCount = (snap['totalReviews'] ?? 0);

//       double newAvg =
//           ((currentAvg * currentCount) + rating) / (currentCount + 1);

//       txn.set(reviewRef, {
//         'userId': userId,
//         'userName': userName,
//         'rating': rating,
//         'comment': comment,
//         'createdAt': FieldValue.serverTimestamp(),
//       });

//       txn.update(workerRef, {
//         'averageRating': newAvg,
//         'totalReviews': currentCount + 1,
//       });
//     });
//   }

//   void _recalculate(List<ReviewModel> list) {
//     if (list.isEmpty) {
//       averageRating.value = 0;
//       totalReviews.value = 0;
//       return;
//     }

//     double sum = 0;
//     for (var r in list) {
//       sum += r.rating;
//     }

//     averageRating.value = sum / list.length;
//     totalReviews.value = list.length;
//   }
// }
// // import 'package:cloud_firestore/cloud_firestore.dart';
// // import 'package:get/get.dart';
// // import '../model/review_model.dart';

// // class WorkerProfileController extends GetxController {
// //   final FirebaseFirestore _db = FirebaseFirestore.instance;
// //   final String workerId;

// //   WorkerProfileController(this.workerId);

// //   RxList<ReviewModel> reviews = <ReviewModel>[].obs;
// //   RxDouble averageRating = 0.0.obs;
// //   RxBool isLoading = true.obs;

// //   @override
// //   void onInit() {
// //     super.onInit();
// //     fetchReviews();
// //   }

// //   void fetchReviews() {
// //     _db
// //         .collection('workers')
// //         .doc(workerId)
// //         .collection('reviews')
// //         .orderBy('createdAt', descending: true)
// //         .snapshots()
// //         .listen((snapshot) {
// //           final list = snapshot.docs
// //               .map((doc) => ReviewModel.fromFirestore(doc.data(), doc.id))
// //               .toList();

// //           reviews.value = list;
// //           calculateAverage();
// //           isLoading.value = false;
// //         });
// //   }

// //   Future<void> addReview({
// //     required String userId,
// //     required String userName,
// //     required double rating,
// //     required String comment,
// //   }) async {
// //     final reviewRef = _db
// //         .collection('workers')
// //         .doc(workerId)
// //         .collection('reviews')
// //         .doc();

// //     await _db.runTransaction((txn) async {
// //       final workerRef = _db.collection('workers').doc(workerId);
// //       final workerSnap = await txn.get(workerRef);

// //       double currentAvg = (workerSnap.data()?['averageRating'] ?? 0).toDouble();
// //       int currentCount = (workerSnap.data()?['totalReviews'] ?? 0);

// //       double newAvg =
// //           ((currentAvg * currentCount) + rating) / (currentCount + 1);

// //       txn.set(reviewRef, {
// //         'userId': userId,
// //         'userName': userName,
// //         'rating': rating,
// //         'comment': comment,
// //         'createdAt': FieldValue.serverTimestamp(),
// //       });

// //       txn.update(workerRef, {
// //         'averageRating': newAvg,
// //         'totalReviews': currentCount + 1,
// //       });
// //     });
// //   }

// //   // Future<void> addReview({
// //   //   required String userId,
// //   //   required String userName,
// //   //   required String comment,
// //   //   required double rating,
// //   // }) async {
// //   //   final ref = _db.collection('workers').doc(workerId).collection('reviews');

// //   //   await ref.add({
// //   //     'userId': userId,
// //   //     'userName': userName,
// //   //     'comment': comment,
// //   //     'rating': rating,
// //   //     'createdAt': FieldValue.serverTimestamp(),
// //   //   });

// //   //   await updateWorkerRating();
// //   // }

// //   void calculateAverage() {
// //     if (reviews.isEmpty) {
// //       averageRating.value = 0;
// //       return;
// //     }

// //     double total = 0;
// //     for (var r in reviews) {
// //       total += r.rating;
// //     }

// //     averageRating.value = total / reviews.length;
// //   }

// //   Future<void> updateWorkerRating() async {
// //     final workerRef = _db.collection('workers').doc(workerId);
// //     final snapshot = await workerRef.collection('reviews').get();

// //     if (snapshot.docs.isEmpty) return;

// //     double total = 0;
// //     for (var doc in snapshot.docs) {
// //       total += (doc['rating'] ?? 0).toDouble();
// //     }

// //     double avg = total / snapshot.docs.length;

// //     await workerRef.update({'averageRating': avg});
// //   }
// // }

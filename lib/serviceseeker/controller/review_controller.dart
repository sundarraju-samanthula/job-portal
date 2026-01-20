import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:jobportal/serviceseeker/model/review_model.dart';

class ReviewsController extends GetxController {
  final _db = FirebaseFirestore.instance;

  RxList<ReviewModel> reviews = <ReviewModel>[].obs;
  RxBool isLoading = true.obs;

  void fetchReviews(String workerId) {
    _db
        .collection('workers')
        .doc(workerId)
        .collection('reviews')
        .orderBy('createdAt', descending: true)
        .snapshots()
        .listen((snapshot) {
          reviews.value = snapshot.docs
              .map((doc) => ReviewModel.fromFirestore(doc.data(), doc.id))
              .toList();
          isLoading.value = false;
        });
  }

  Future<void> addReview({
    required String workerId,
    required double rating,
    required String comment,
    required String userId,
    required String userName,
  }) async {
    final workerRef = _db.collection('workers').doc(workerId);

    await workerRef.collection('reviews').add({
      'rating': rating,
      'comment': comment,
      'userId': userId,
      'userName': userName,
      'createdAt': FieldValue.serverTimestamp(),
    });

    await _updateWorkerStats(workerRef);
  }

  Future<void> _updateWorkerStats(DocumentReference workerRef) async {
    final snapshot = await workerRef.collection('reviews').get();

    double total = 0;
    for (var doc in snapshot.docs) {
      total += (doc['rating'] ?? 0).toDouble();
    }

    final avg = snapshot.docs.isEmpty ? 0 : total / snapshot.docs.length;

    await workerRef.update({
      'averageRating': avg,
      'totalReviews': snapshot.docs.length,
    });
  }
}

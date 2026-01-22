// // // // // // // import 'package:cloud_firestore/cloud_firestore.dart';

// // // // // // // class ReviewModel {
// // // // // // //   final String id;
// // // // // // //   final double rating;
// // // // // // //   final String comment;
// // // // // // //   final String userId;
// // // // // // //   final String userName;
// // // // // // //   final DateTime createdAt;

// // // // // // //   ReviewModel({
// // // // // // //     required this.id,
// // // // // // //     required this.rating,
// // // // // // //     required this.comment,
// // // // // // //     required this.userId,
// // // // // // //     required this.userName,
// // // // // // //     required this.createdAt,
// // // // // // //   });

// // // // // // //   factory ReviewModel.fromFirestore(Map<String, dynamic> data, String id) {
// // // // // // //     return ReviewModel(
// // // // // // //       id: id,
// // // // // // //       rating: (data['rating'] ?? 0).toDouble(),
// // // // // // //       comment: data['comment'] ?? '',
// // // // // // //       userId: data['userId'] ?? '',
// // // // // // //       userName: data['userName'] ?? '',
// // // // // // //       createdAt: (data['createdAt'] as Timestamp).toDate(),
// // // // // // //     );
// // // // // // //   }
// // // // // // // }
// // // // // // import 'package:cloud_firestore/cloud_firestore.dart';

// // // // // // class ReviewModel {
// // // // // //   final String id;
// // // // // //   final String userName;
// // // // // //   final double rating;
// // // // // //   final String comment;
// // // // // //   final DateTime createdAt;

// // // // // //   ReviewModel({
// // // // // //     required this.id,
// // // // // //     required this.userName,
// // // // // //     required this.rating,
// // // // // //     required this.comment,
// // // // // //     required this.createdAt,
// // // // // //   });

// // // // // //   /// 🔥 Firestore → Model
// // // // // //   factory ReviewModel.fromFirestore(Map<String, dynamic> data, String id) {
// // // // // //     return ReviewModel(
// // // // // //       id: id,
// // // // // //       userName: data['userName'] ?? 'Anonymous',
// // // // // //       rating: (data['rating'] ?? 0).toDouble(),
// // // // // //       comment: data['comment'] ?? '',
// // // // // //       createdAt: _parseDate(data['createdAt']),
// // // // // //     );
// // // // // //   }

// // // // // //   /// 🧠 Handles Timestamp / String / null safely
// // // // // //   static DateTime _parseDate(dynamic value) {
// // // // // //     if (value == null) return DateTime.now();

// // // // // //     if (value is Timestamp) {
// // // // // //       return value.toDate();
// // // // // //     }

// // // // // //     if (value is String) {
// // // // // //       return DateTime.tryParse(value) ?? DateTime.now();
// // // // // //     }

// // // // // //     return DateTime.now();
// // // // // //   }

// // // // // //   /// 🔁 Model → Firestore
// // // // // //   Map<String, dynamic> toMap() {
// // // // // //     return {
// // // // // //       'userName': userName,
// // // // // //       'rating': rating,
// // // // // //       'comment': comment,
// // // // // //       'createdAt': FieldValue.serverTimestamp(),
// // // // // //     };
// // // // // //   }
// // // // // // }
// // // // // import 'package:cloud_firestore/cloud_firestore.dart';

// // // // // class ReviewModel {
// // // // //   final String id;
// // // // //   final String userName;
// // // // //   final double rating;
// // // // //   final String comment;
// // // // //   final DateTime createdAt;

// // // // //   ReviewModel({
// // // // //     required this.id,
// // // // //     required this.userName,
// // // // //     required this.rating,
// // // // //     required this.comment,
// // // // //     required this.createdAt,
// // // // //   });

// // // // //   factory ReviewModel.fromFirestore(Map<String, dynamic> data, String id) {
// // // // //     return ReviewModel(
// // // // //       id: id,
// // // // //       userName: data['userName'] ?? '',
// // // // //       rating: (data['rating'] ?? 0).toDouble(),
// // // // //       comment: data['comment'] ?? '',
// // // // //       createdAt: (data['createdAt'] as Timestamp).toDate(), // ✅ FIX
// // // // //     );
// // // // //   }
// // // // // }
// // // // import 'package:cloud_firestore/cloud_firestore.dart';

// // // // class ReviewModel {
// // // //   final String id;
// // // //   final String userName;
// // // //   final double rating;
// // // //   final String comment;
// // // //   final DateTime createdAt;

// // // //   ReviewModel({
// // // //     required this.id,
// // // //     required this.userName,
// // // //     required this.rating,
// // // //     required this.comment,
// // // //     required this.createdAt,
// // // //   });

// // // //   factory ReviewModel.fromFirestore(Map<String, dynamic> data, String id) {
// // // //     return ReviewModel(
// // // //       id: id,
// // // //       userName: data['userName'] ?? '',
// // // //       rating: (data['rating'] ?? 0).toDouble(),
// // // //       comment: data['comment'] ?? '',
// // // //       createdAt: (data['createdAt'] as Timestamp).toDate(),
// // // //     );
// // // //   }
// // // // }
// // // import 'package:cloud_firestore/cloud_firestore.dart';

// // // class ReviewModel {
// // //   final String id;
// // //   final String userName;
// // //   final double rating;
// // //   final String comment;
// // //   final DateTime createdAt;

// // //   ReviewModel({
// // //     required this.id,
// // //     required this.userName,
// // //     required this.rating,
// // //     required this.comment,
// // //     required this.createdAt,
// // //   });

// // //   factory ReviewModel.fromFirestore(Map<String, dynamic> data, String id) {
// // //     return ReviewModel(
// // //       id: id,
// // //       userName: data['userName'] ?? '',
// // //       rating: (data['rating'] ?? 0).toDouble(),
// // //       comment: data['comment'] ?? '',
// // //       createdAt: (data['createdAt'] as Timestamp).toDate(),
// // //     );
// // //   }
// // // }
// // import 'package:cloud_firestore/cloud_firestore.dart';

// // class ReviewModel {
// //   final String id;
// //   final String userId;
// //   final String userName;
// //   final double rating;
// //   final String comment;
// //   final DateTime createdAt;

// //   ReviewModel({
// //     required this.id,
// //     required this.userId,
// //     required this.userName,
// //     required this.rating,
// //     required this.comment,
// //     required this.createdAt,
// //   });

// //   factory ReviewModel.fromFirestore(Map<String, dynamic> data, String id) {
// //     return ReviewModel(
// //       id: id,
// //       userId: data['userId'] ?? '',
// //       userName: data['userName'] ?? '',
// //       rating: (data['rating'] ?? 0).toDouble(),
// //       comment: data['comment'] ?? '',
// //       createdAt: (data['createdAt'] as Timestamp).toDate(),
// //     );
// //   }
// // }
// class ReviewModel {
//   final String id;
//   final String userId;
//   final String userName;
//   final double rating;
//   final String comment;

//   ReviewModel({
//     required this.id,
//     required this.userId,
//     required this.userName,
//     required this.rating,
//     required this.comment,
//   });

//   factory ReviewModel.fromFirestore(Map<String, dynamic> data, String id) {
//     return ReviewModel(
//       id: id,
//       userId: data['userId'] ?? '',
//       userName: data['userName'] ?? '',
//       rating: (data['rating'] ?? 0).toDouble(),
//       comment: data['comment'] ?? '',
//     );
//   }
// }
import 'package:cloud_firestore/cloud_firestore.dart';

class ReviewModel {
  final String id;
  final String userName;
  final double rating;
  final String comment;
  final DateTime createdAt;

  ReviewModel({
    required this.id,
    required this.userName,
    required this.rating,
    required this.comment,
    required this.createdAt,
  });

  factory ReviewModel.fromFirestore(Map<String, dynamic> data, String id) {
    return ReviewModel(
      id: id,
      userName: data['userName'] ?? '',
      rating: (data['rating'] ?? 0).toDouble(),
      comment: data['comment'] ?? '',
      createdAt: (data['createdAt'] as Timestamp).toDate(), // ✅ FIX
    );
  }
}

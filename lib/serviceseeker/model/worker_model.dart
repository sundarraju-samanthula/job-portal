// // class WorkerModel {
// //   final String id;
// //   final String name;
// //   final String skill;
// //   final String experience;
// //   final int chargePerDay;
// //   final String location;
// //   final String phone;
// //   final String whatsapp;
// //   final String photoUrl;

// //   WorkerModel({
// //     required this.id,
// //     required this.name,
// //     required this.skill,
// //     required this.experience,
// //     required this.chargePerDay,
// //     required this.location,
// //     required this.phone,
// //     required this.whatsapp,
// //     required this.photoUrl,
// //   });

// //   factory WorkerModel.fromFirestore(Map<String, dynamic> data, String id) {
// //     return WorkerModel(
// //       id: id,
// //       name: data['name'] ?? '',
// //       skill: data['skill'] ?? '',
// //       experience: data['experience'] ?? '',
// //       chargePerDay: data['chargePerDay'] ?? 0,
// //       location: data['location'] ?? '',
// //       phone: data['phone'] ?? '',
// //       whatsapp: data['whatsapp'] ?? '',
// //       photoUrl: data['photoUrl'] ?? '',
// //     );
// //   }
// // }
// class WorkerModel {
//   final String id;
//   final String name;
//   final String skill;
//   final String experience;
//   final int chargePerDay;
//   final String location;
//   final String phone;
//   final String whatsapp;
//   final String photoUrl;

//   WorkerModel({
//     required this.id,
//     required this.name,
//     required this.skill,
//     required this.experience,
//     required this.chargePerDay,
//     required this.location,
//     required this.phone,
//     required this.whatsapp,
//     required this.photoUrl,
//   });

//   factory WorkerModel.fromFirestore(Map<String, dynamic> data, String id) {
//     return WorkerModel(
//       id: id,
//       name: data['name']?.toString() ?? '',
//       skill: data['skill']?.toString() ?? '',
//       experience: data['experience']?.toString() ?? '',
//       chargePerDay: (data['chargePerDay'] ?? 0) is int
//           ? data['chargePerDay']
//           : int.tryParse(data['chargePerDay'].toString()) ?? 0,
//       location: data['location']?.toString() ?? '',
//       phone: data['phone']?.toString() ?? '',
//       whatsapp: data['whatsapp']?.toString() ?? data['phone']?.toString() ?? '',
//       photoUrl: data['photoUrl']?.toString() ?? '',
//     );
//   }
// }
class WorkerModel {
  final String id;
  final String name;
  final String skill;
  final String experience;
  final int chargePerDay;
  final String location;
  final String phone;
  final String whatsapp;
  final String photoUrl;
  final bool isActive;
  final double averageRating;
  final int totalReviews;

  WorkerModel({
    required this.id,
    required this.name,
    required this.skill,
    required this.experience,
    required this.chargePerDay,
    required this.location,
    required this.phone,
    required this.whatsapp,
    required this.photoUrl,
    required this.isActive,
    required this.averageRating,
    required this.totalReviews,
  });

  factory WorkerModel.fromFirestore(Map<String, dynamic> data, String id) {
    return WorkerModel(
      id: id,
      name: data['name'] ?? '',
      skill: data['skill'] ?? '',
      experience: data['experience'] ?? '',
      chargePerDay: data['chargePerDay'] ?? 0,
      location: data['location'] ?? '',
      phone: data['phone'] ?? '',
      whatsapp: data['whatsapp'] ?? '',
      photoUrl: data['photoUrl'] ?? '',
      isActive: data['isActive'] ?? true,
      averageRating: (data['averageRating'] ?? 0).toDouble(),
      totalReviews: data['totalReviews'] ?? 0,
    );
  }
}

// // // class JobModel {
// // //   final String id;
// // //   final String companyName;
// // //   final String companyLogo;
// // //   final String jobTitle;
// // //   final String salary;
// // //   final String workMode;
// // //   final String location;
// // //   final String experience;
// // //   final String applyLink;

// // //   JobModel({
// // //     required this.id,
// // //     required this.companyName,
// // //     required this.companyLogo,
// // //     required this.jobTitle,
// // //     required this.salary,
// // //     required this.workMode,
// // //     required this.location,
// // //     required this.experience,
// // //     required this.applyLink,
// // //   });

// // //   factory JobModel.fromFirestore(Map<String, dynamic> data, String id) {
// // //     return JobModel(
// // //       id: id,
// // //       companyName: data['companyName'] ?? '',
// // //       companyLogo: data['companyLogo'] ?? '',
// // //       jobTitle: data['jobTitle'] ?? '',
// // //       salary: data['salary'] ?? '',
// // //       workMode: data['workMode'] ?? '',
// // //       location: data['location'] ?? '',
// // //       experience: data['experience'] ?? '',
// // //       applyLink: data['applyLink'] ?? '',
// // //     );
// // //   }
// // // }
// // class JobModel {
// //   final String id;
// //   final String companyName;
// //   final String companyLogo;
// //   final String jobTitle;
// //   final String salary;
// //   final String workMode;
// //   final String location;
// //   final String experience;
// //   final String applyLink;
// //   final String description;
// //   final List<String> responsibilities;
// //   final List<String> requirements;

// //   JobModel({
// //     required this.id,
// //     required this.companyName,
// //     required this.companyLogo,
// //     required this.jobTitle,
// //     required this.salary,
// //     required this.workMode,
// //     required this.location,
// //     required this.experience,
// //     required this.applyLink,
// //     required this.description,
// //     required this.responsibilities,
// //     required this.requirements,
// //   });

// //   factory JobModel.fromFirestore(Map<String, dynamic> data, String id) {
// //     return JobModel(
// //       id: id,
// //       companyName: data['companyName'] ?? '',
// //       companyLogo: data['companyLogo'] ?? '',
// //       jobTitle: data['jobTitle'] ?? '',
// //       salary: data['salary'] ?? '',
// //       workMode: data['workMode'] ?? '',
// //       location: data['location'] ?? '',
// //       experience: data['experience'] ?? '',
// //       applyLink: data['applyLink'] ?? '',
// //       description: data['description'] ?? '',
// //       responsibilities: List<String>.from(data['responsibilities'] ?? []),
// //       requirements: List<String>.from(data['requirements'] ?? []),
// //     );
// //   }
// // }
// class JobModel {
//   final String id;
//   final String companyName;
//   final String companyLogo;
//   final String jobTitle;
//   final String salary;
//   final String workMode;
//   final String location;
//   final String experience;
//   final String applyLink;
//   final String description;
//   final List<String> responsibilities;
//   final List<String> requirements;

//   JobModel({
//     required this.id,
//     required this.companyName,
//     required this.companyLogo,
//     required this.jobTitle,
//     required this.salary,
//     required this.workMode,
//     required this.location,
//     required this.experience,
//     required this.applyLink,
//     required this.description,
//     required this.responsibilities,
//     required this.requirements,
//   });

//   factory JobModel.fromFirestore(Map<String, dynamic> data, String id) {
//     List<String> parseList(dynamic value) {
//       if (value == null) return [];
//       if (value is List) return value.map((e) => e.toString()).toList();
//       if (value is String) {
//         return value.split(',').map((e) => e.trim()).toList();
//       }
//       return [];
//     }

//     return JobModel(
//       id: id,
//       companyName: data['companyName'] ?? '',
//       companyLogo: data['companyLogo'] ?? '',
//       jobTitle: data['jobTitle'] ?? '',
//       salary: data['salary'] ?? '',
//       workMode: data['workMode'] ?? '',
//       location: data['location'] ?? '',
//       experience: data['experience'] ?? '',
//       applyLink: data['applyLink'] ?? '',
//       description: data['description'] ?? '',
//       responsibilities: parseList(data['responsibilities']),
//       requirements: parseList(data['requirements']),
//     );
//   }
// }
class JobModel {
  final String id;
  final String companyName;
  final String companyLogo;
  final String jobTitle;
  final String salary;
  final String workMode;
  final String location;
  final String experience;
  final String applyLink;
  final String description;
  final List<String> responsibilities;
  final List<String> requirements;

  JobModel({
    required this.id,
    required this.companyName,
    required this.companyLogo,
    required this.jobTitle,
    required this.salary,
    required this.workMode,
    required this.location,
    required this.experience,
    required this.applyLink,
    required this.description,
    required this.responsibilities,
    required this.requirements,
  });

  factory JobModel.fromFirestore(Map<String, dynamic> data, String id) {
    List<String> parseList(dynamic value) {
      if (value == null) return [];
      if (value is List) return List<String>.from(value);
      if (value is String) {
        return value
            .split(',')
            .map((e) => e.trim())
            .where((e) => e.isNotEmpty)
            .toList();
      }
      return [];
    }

    return JobModel(
      id: id,
      companyName: data['companyName'] ?? '',
      companyLogo: data['companyLogo'] ?? '',
      jobTitle: data['jobTitle'] ?? '',
      salary: data['salary'] ?? '',
      workMode: data['workMode'] ?? '',
      location: data['location'] ?? '',
      experience: data['experience'] ?? '',
      applyLink: data['applyLink'] ?? '',
      description: data['description'] ?? '',
      responsibilities: parseList(data['responsibilities']),
      requirements: parseList(data['requirements']),
    );
  }
}

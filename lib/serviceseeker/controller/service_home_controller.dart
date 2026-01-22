// // // import 'package:cloud_firestore/cloud_firestore.dart';
// // // import 'package:get/get.dart';
// // // import '../model/worker_model.dart';

// // // enum SortType { name, priceLowHigh, priceHighLow, experience }

// // // class ServiceHomeController extends GetxController {
// // //   final _db = FirebaseFirestore.instance;

// // //   RxList<WorkerModel> workers = <WorkerModel>[].obs;
// // //   RxList<WorkerModel> filteredWorkers = <WorkerModel>[].obs;

// // //   RxBool isLoading = true.obs;

// // //   RxString searchQuery = ''.obs;
// // //   RxString selectedLocation = ''.obs;
// // //   RxString selectedProfession = ''.obs;

// // //   Rx<SortType?> selectedSort = Rx<SortType?>(null);

// // //   @override
// // //   void onInit() {
// // //     super.onInit();
// // //     fetchWorkers();
// // //   }

// // //   void fetchWorkers() {
// // //     isLoading.value = true;

// // //     _db
// // //         .collection('workers')
// // //         .where('isActive', isEqualTo: true)
// // //         .snapshots()
// // //         .listen(
// // //           (snapshot) {
// // //             final list = snapshot.docs
// // //                 .map((doc) => WorkerModel.fromFirestore(doc.data(), doc.id))
// // //                 .toList();

// // //             workers.value = list;
// // //             applyFilters();
// // //             isLoading.value = false;
// // //           },
// // //           onError: (e) {
// // //             isLoading.value = false;
// // //             print("Firestore error: $e");
// // //           },
// // //         );
// // //   }

// // //   void onSearch(String value) {
// // //     searchQuery.value = value;
// // //     applyFilters();
// // //   }

// // //   void setLocation(String location) {
// // //     selectedLocation.value = location;
// // //     applyFilters();
// // //   }

// // //   void setSort(SortType? type) {
// // //     selectedSort.value = type;
// // //     applyFilters();
// // //   }

// // //   void resetFilters() {
// // //     searchQuery.value = '';
// // //     selectedLocation.value = '';
// // //     selectedSort.value = null;
// // //     applyFilters();
// // //   }

// // //   // void applyFilters() {
// // //   //   List<WorkerModel> temp = List.from(workers);

// // //   //   // 🔍 Search
// // //   //   final q = searchQuery.value.toLowerCase();
// // //   //   if (q.isNotEmpty) {
// // //   //     temp = temp.where((w) {
// // //   //       return w.name.toLowerCase().contains(q) ||
// // //   //           w.skill.toLowerCase().contains(q) ||
// // //   //           w.location.toLowerCase().contains(q);
// // //   //     }).toList();
// // //   //   }

// // //   //   // 📍 Location filter
// // //   //   if (selectedLocation.value.isNotEmpty) {
// // //   //     temp = temp
// // //   //         .where(
// // //   //           (w) =>
// // //   //               w.location.toLowerCase() ==
// // //   //               selectedLocation.value.toLowerCase(),
// // //   //         )
// // //   //         .toList();
// // //   //   }

// // //   //   // ↕️ Sorting
// // //   //   switch (selectedSort.value) {
// // //   //     case SortType.name:
// // //   //       temp.sort((a, b) => a.name.compareTo(b.name));
// // //   //       break;
// // //   //     case SortType.priceLowHigh:
// // //   //       temp.sort((a, b) => a.chargePerDay.compareTo(b.chargePerDay));
// // //   //       break;
// // //   //     case SortType.priceHighLow:
// // //   //       temp.sort((a, b) => b.chargePerDay.compareTo(a.chargePerDay));
// // //   //       break;
// // //   //     case SortType.experience:
// // //   //       temp.sort((a, b) => b.experience.compareTo(a.experience));
// // //   //       break;
// // //   //     default:
// // //   //       break;
// // //   //   }

// // //   //   filteredWorkers.value = temp;
// // //   // }

// // //   // List<String> getLocations() {
// // //   //   final set = workers.map((e) => e.location).toSet().toList();
// // //   //   set.sort();
// // //   //   return set;
// // //   // }
// // //   void setProfession(String profession) {
// // //     if (selectedProfession.value == profession) {
// // //       selectedProfession.value = '';
// // //     } else {
// // //       selectedProfession.value = profession;
// // //     }
// // //     applyFilters();
// // //   }

// // //   // void applyFilters() {
// // //   //   List<WorkerModel> temp = List.from(workers);

// // //   //   final q = searchQuery.value.toLowerCase();
// // //   //   if (q.isNotEmpty) {
// // //   //     temp = temp.where((w) {
// // //   //       return w.name.toLowerCase().contains(q) ||
// // //   //           w.skill.toLowerCase().contains(q) ||
// // //   //           w.location.toLowerCase().contains(q);
// // //   //     }).toList();
// // //   //   }

// // //   //   if (selectedLocation.value.isNotEmpty) {
// // //   //     temp = temp
// // //   //         .where(
// // //   //           (w) =>
// // //   //               w.location.toLowerCase() ==
// // //   //               selectedLocation.value.toLowerCase(),
// // //   //         )
// // //   //         .toList();
// // //   //   }

// // //   //   switch (selectedSort.value) {
// // //   //     case SortType.name:
// // //   //       temp.sort((a, b) => a.name.compareTo(b.name));
// // //   //       break;
// // //   //     case SortType.priceLowHigh:
// // //   //       temp.sort((a, b) => a.chargePerDay.compareTo(b.chargePerDay));
// // //   //       break;
// // //   //     case SortType.priceHighLow:
// // //   //       temp.sort((a, b) => b.chargePerDay.compareTo(a.chargePerDay));
// // //   //       break;
// // //   //     case SortType.experience:
// // //   //       temp.sort((a, b) => b.experience.compareTo(a.experience));
// // //   //       break;
// // //   //     default:
// // //   //       break;
// // //   //   }

// // //   //   filteredWorkers.value = temp;
// // //   // }

// // //   List<String> getLocations() {
// // //     final set = workers.map((e) => e.location).toSet().toList();
// // //     set.sort();
// // //     return set;
// // //   }

// // //   void applyFilters() {
// // //     List<WorkerModel> temp = List.from(workers);

// // //     // 🔍 Search
// // //     final q = searchQuery.value.toLowerCase();
// // //     if (q.isNotEmpty) {
// // //       temp = temp.where((w) {
// // //         return w.name.toLowerCase().contains(q) ||
// // //             w.skill.toLowerCase().contains(q) ||
// // //             w.location.toLowerCase().contains(q);
// // //       }).toList();
// // //     }

// // //     // 🧰 Profession filter
// // //     if (selectedProfession.value.isNotEmpty) {
// // //       temp = temp
// // //           .where(
// // //             (w) =>
// // //                 w.skill.toLowerCase() == selectedProfession.value.toLowerCase(),
// // //           )
// // //           .toList();
// // //     }

// // //     // 📍 Location filter
// // //     if (selectedLocation.value.isNotEmpty) {
// // //       temp = temp
// // //           .where(
// // //             (w) =>
// // //                 w.location.toLowerCase() ==
// // //                 selectedLocation.value.toLowerCase(),
// // //           )
// // //           .toList();
// // //     }

// // //     // ↕️ Sorting
// // //     switch (selectedSort.value) {
// // //       case SortType.name:
// // //         temp.sort((a, b) => a.name.compareTo(b.name));
// // //         break;
// // //       case SortType.priceLowHigh:
// // //         temp.sort((a, b) => a.chargePerDay.compareTo(b.chargePerDay));
// // //         break;
// // //       case SortType.priceHighLow:
// // //         temp.sort((a, b) => b.chargePerDay.compareTo(a.chargePerDay));
// // //         break;
// // //       case SortType.experience:
// // //         temp.sort((a, b) => b.experience.compareTo(a.experience));
// // //         break;
// // //       default:
// // //         break;
// // //     }

// // //     filteredWorkers.value = temp;
// // //   }
// // // }
// // import 'package:cloud_firestore/cloud_firestore.dart';
// // import 'package:get/get.dart';
// // import '../model/worker_model.dart';

// // enum SortType { name, priceLowHigh, priceHighLow, experience }

// // class ServiceHomeController extends GetxController {
// //   final _db = FirebaseFirestore.instance;

// //   RxList<WorkerModel> workers = <WorkerModel>[].obs;
// //   RxList<WorkerModel> filteredWorkers = <WorkerModel>[].obs;

// //   RxBool isLoading = true.obs;

// //   RxString searchQuery = ''.obs;
// //   RxString selectedLocation = ''.obs;
// //   RxString selectedProfession = ''.obs;
// //   Rx<SortType?> selectedSort = Rx<SortType?>(null);

// //   @override
// //   void onInit() {
// //     super.onInit();
// //     fetchWorkers();
// //   }

// //   void fetchWorkers() {
// //     isLoading.value = true;

// //     _db
// //         .collection('workers')
// //         .snapshots()
// //         .listen(
// //           (snapshot) {
// //             final list = snapshot.docs
// //                 .map((doc) => WorkerModel.fromFirestore(doc.data(), doc.id))
// //                 .toList();

// //             workers.value = list;
// //             applyFilters();
// //             isLoading.value = false;
// //           },
// //           onError: (e) {
// //             isLoading.value = false;
// //             print("Firestore error: $e");
// //           },
// //         );
// //   }

// //   void onSearch(String value) {
// //     searchQuery.value = value;
// //     applyFilters();
// //   }

// //   void setLocation(String location) {
// //     if (selectedLocation.value == location) {
// //       selectedLocation.value = '';
// //     } else {
// //       selectedLocation.value = location;
// //     }
// //     applyFilters();
// //   }

// //   void setProfession(String profession) {
// //     if (selectedProfession.value == profession) {
// //       selectedProfession.value = '';
// //     } else {
// //       selectedProfession.value = profession;
// //     }
// //     applyFilters();
// //   }

// //   void setSort(SortType? type) {
// //     selectedSort.value = type;
// //     applyFilters();
// //   }

// //   void resetFilters() {
// //     searchQuery.value = '';
// //     selectedLocation.value = '';
// //     selectedProfession.value = '';
// //     selectedSort.value = null;
// //     applyFilters();
// //   }

// //   void applyFilters() {
// //     List<WorkerModel> temp = List.from(workers);

// //     // Search
// //     final q = searchQuery.value.toLowerCase();
// //     if (q.isNotEmpty) {
// //       temp = temp.where((w) {
// //         return w.name.toLowerCase().contains(q) ||
// //             w.skill.toLowerCase().contains(q) ||
// //             w.location.toLowerCase().contains(q);
// //       }).toList();
// //     }

// //     // Profession
// //     if (selectedProfession.value.isNotEmpty) {
// //       temp = temp
// //           .where(
// //             (w) =>
// //                 w.skill.toLowerCase() == selectedProfession.value.toLowerCase(),
// //           )
// //           .toList();
// //     }

// //     // Location
// //     if (selectedLocation.value.isNotEmpty) {
// //       temp = temp
// //           .where(
// //             (w) =>
// //                 w.location.toLowerCase() ==
// //                 selectedLocation.value.toLowerCase(),
// //           )
// //           .toList();
// //     }

// //     // Sorting
// //     switch (selectedSort.value) {
// //       case SortType.name:
// //         temp.sort((a, b) => a.name.compareTo(b.name));
// //         break;
// //       case SortType.priceLowHigh:
// //         temp.sort((a, b) => a.chargePerDay.compareTo(b.chargePerDay));
// //         break;
// //       case SortType.priceHighLow:
// //         temp.sort((a, b) => b.chargePerDay.compareTo(a.chargePerDay));
// //         break;
// //       case SortType.experience:
// //         temp.sort((a, b) => b.experience.compareTo(a.experience));
// //         break;
// //       default:
// //         break;
// //     }

// //     filteredWorkers.value = temp;
// //   }

// //   List<String> getLocations() {
// //     final set = workers.map((e) => e.location).toSet().toList();
// //     set.sort();
// //     return set;
// //   }
// // }
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:get/get.dart';
// import '../model/worker_model.dart';

// enum SortType { name, priceLowHigh, priceHighLow, experience }

// class ServiceHomeController extends GetxController {
//   final _db = FirebaseFirestore.instance;

//   RxList<WorkerModel> workers = <WorkerModel>[].obs;
//   RxList<WorkerModel> filteredWorkers = <WorkerModel>[].obs;

//   RxBool isLoading = true.obs;

//   RxString searchQuery = ''.obs;
//   RxString selectedLocation = ''.obs;
//   RxString selectedProfession = ''.obs;

//   Rx<SortType?> selectedSort = Rx<SortType?>(null);

//   @override
//   void onInit() {
//     super.onInit();
//     fetchWorkers();
//   }

//   void fetchWorkers() {
//     isLoading.value = true;

//     _db
//         .collection('workers')
//         .where('isActive', isEqualTo: true)
//         .snapshots()
//         .listen(
//           (snapshot) {
//             final list = snapshot.docs
//                 .map((doc) => WorkerModel.fromFirestore(doc.data(), doc.id))
//                 .toList();

//             workers.value = list;
//             applyFilters();
//             isLoading.value = false;
//           },
//           onError: (e) {
//             isLoading.value = false;
//             print("Firestore error: $e");
//           },
//         );
//   }

//   void onSearch(String value) {
//     searchQuery.value = value;
//     applyFilters();
//   }

//   void setLocation(String location) {
//     selectedLocation.value = location;
//   }

//   void setProfession(String profession) {
//     if (selectedProfession.value == profession) {
//       selectedProfession.value = '';
//     } else {
//       selectedProfession.value = profession;
//     }
//   }

//   void setSort(SortType? type) {
//     selectedSort.value = type;
//   }

//   void resetFilters() {
//     searchQuery.value = '';
//     selectedLocation.value = '';
//     selectedProfession.value = '';
//     selectedSort.value = null;
//     applyFilters();
//   }

//   List<String> getLocations() {
//     final set = workers.map((e) => e.location).toSet().toList();
//     set.sort();
//     return set;
//   }

//   void applyFilters() {
//     List<WorkerModel> temp = List.from(workers);

//     final q = searchQuery.value.toLowerCase();
//     if (q.isNotEmpty) {
//       temp = temp.where((w) {
//         return w.name.toLowerCase().contains(q) ||
//             w.skill.toLowerCase().contains(q) ||
//             w.location.toLowerCase().contains(q);
//       }).toList();
//     }

//     if (selectedProfession.value.isNotEmpty) {
//       temp = temp
//           .where(
//             (w) =>
//                 w.skill.toLowerCase() == selectedProfession.value.toLowerCase(),
//           )
//           .toList();
//     }

//     if (selectedLocation.value.isNotEmpty) {
//       temp = temp
//           .where(
//             (w) =>
//                 w.location.toLowerCase() ==
//                 selectedLocation.value.toLowerCase(),
//           )
//           .toList();
//     }

//     switch (selectedSort.value) {
//       case SortType.name:
//         temp.sort((a, b) => a.name.compareTo(b.name));
//         break;
//       case SortType.priceLowHigh:
//         temp.sort((a, b) => a.chargePerDay.compareTo(b.chargePerDay));
//         break;
//       case SortType.priceHighLow:
//         temp.sort((a, b) => b.chargePerDay.compareTo(a.chargePerDay));
//         break;
//       case SortType.experience:
//         temp.sort((a, b) => b.experience.compareTo(a.experience));
//         break;
//       default:
//         break;
//     }

//     filteredWorkers.value = temp;
//   }
// }
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import '../model/worker_model.dart';

enum SortType { name, priceLowHigh, priceHighLow, experience }

class ServiceHomeController extends GetxController {
  final _db = FirebaseFirestore.instance;

  RxList<WorkerModel> workers = <WorkerModel>[].obs;
  RxList<WorkerModel> filteredWorkers = <WorkerModel>[].obs;

  RxBool isLoading = true.obs;

  RxString searchQuery = ''.obs;
  RxString selectedLocation = ''.obs;
  Rx<SortType?> selectedSort = Rx<SortType?>(null);

  @override
  void onInit() {
    super.onInit();
    fetchWorkers();
  }

  void fetchWorkers() {
    isLoading.value = true;

    _db
        .collection('workers')
        .where('isActive', isEqualTo: true)
        .snapshots()
        .listen(
          (snapshot) {
            final list = snapshot.docs
                .map((doc) => WorkerModel.fromFirestore(doc.data(), doc.id))
                .toList();

            workers.value = list;
            applyFilters();
            isLoading.value = false;
          },
          onError: (e) {
            isLoading.value = false;
            print("Firestore error: $e");
          },
        );
  }

  void onSearch(String value) {
    searchQuery.value = value;
    applyFilters();
  }

  void setLocation(String location) {
    selectedLocation.value = location;
    applyFilters();
  }

  void setSort(SortType? type) {
    selectedSort.value = type;
    applyFilters();
  }

  void resetFilters() {
    searchQuery.value = '';
    selectedLocation.value = '';
    selectedSort.value = null;
    applyFilters();
  }

  void applyFilters() {
    List<WorkerModel> temp = List.from(workers);

    // 🔍 Search
    final q = searchQuery.value.toLowerCase();
    if (q.isNotEmpty) {
      temp = temp.where((w) {
        return w.name.toLowerCase().contains(q) ||
            w.skill.toLowerCase().contains(q) ||
            w.location.toLowerCase().contains(q);
      }).toList();
    }

    // 📍 Location filter
    if (selectedLocation.value.isNotEmpty) {
      temp = temp
          .where(
            (w) =>
                w.location.toLowerCase() ==
                selectedLocation.value.toLowerCase(),
          )
          .toList();
    }

    // ↕️ Sorting
    switch (selectedSort.value) {
      case SortType.name:
        temp.sort((a, b) => a.name.compareTo(b.name));
        break;
      case SortType.priceLowHigh:
        temp.sort((a, b) => a.chargePerDay.compareTo(b.chargePerDay));
        break;
      case SortType.priceHighLow:
        temp.sort((a, b) => b.chargePerDay.compareTo(a.chargePerDay));
        break;
      case SortType.experience:
        temp.sort((a, b) => b.experience.compareTo(a.experience));
        break;
      default:
        break;
    }

    filteredWorkers.value = temp;
  }

  List<String> getLocations() {
    final set = workers.map((e) => e.location).toSet().toList();
    set.sort();
    return set;
  }
}

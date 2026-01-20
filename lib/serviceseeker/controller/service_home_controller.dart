// // import 'package:cloud_firestore/cloud_firestore.dart';
// // import 'package:get/get.dart';
// // import 'package:jobportal/serviceseeker/model/worker_model.dart';
// // // //  import '../models/worker_model.dart';

// // // class ServiceHomeController extends GetxController {
// // //   final _db = FirebaseFirestore.instance;

// // //   RxList<WorkerModel> workers = <WorkerModel>[].obs;
// // //   RxList<WorkerModel> filteredWorkers = <WorkerModel>[].obs;

// // //   RxBool isLoading = true.obs;
// // //   RxString searchQuery = ''.obs;

// // //   @override
// // //   void onInit() {
// // //     super.onInit();
// // //     fetchWorkers();
// // //   }

// // //   void fetchWorkers() {
// // //     _db
// // //         .collection('workers')
// // //         .where('isActive', isEqualTo: true)
// // //         .snapshots()
// // //         .listen((snapshot) {
// // //           final list = snapshot.docs
// // //               .map((doc) => WorkerModel.fromFirestore(doc.data(), doc.id))
// // //               .toList();

// // //           workers.value = list;
// // //           applySearch();
// // //           isLoading.value = false;
// // //         });
// // //   }

// // //   void onSearch(String value) {
// // //     searchQuery.value = value;
// // //     applySearch();
// // //   }

// // //   void applySearch() {
// // //     final q = searchQuery.value.toLowerCase();

// // //     if (q.isEmpty) {
// // //       filteredWorkers.value = workers;
// // //     } else {
// // //       filteredWorkers.value = workers.where((w) {
// // //         return w.name.toLowerCase().contains(q) ||
// // //             w.skill.toLowerCase().contains(q) ||
// // //             w.location.toLowerCase().contains(q);
// // //       }).toList();
// // //     }
// // //   }
// // // }

// // class ServiceHomeController extends GetxController {
// //   final _db = FirebaseFirestore.instance;

// //   RxList<WorkerModel> workers = <WorkerModel>[].obs;
// //   RxList<WorkerModel> filteredWorkers = <WorkerModel>[].obs;

// //   RxBool isLoading = true.obs;
// //   RxString searchQuery = ''.obs;

// //   @override
// //   void onInit() {
// //     super.onInit();
// //     fetchWorkers();
// //   }

// //   void fetchWorkers() {
// //     isLoading.value = true;

// //     _db
// //         .collection('workers')
// //         .where('isActive', isEqualTo: true)
// //         .snapshots()
// //         .listen(
// //           (snapshot) {
// //             final list = snapshot.docs
// //                 .map((doc) => WorkerModel.fromFirestore(doc.data(), doc.id))
// //                 .toList();

// //             workers.value = list;
// //             applySearch();
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
// //     applySearch();
// //   }

// //   void applySearch() {
// //     final q = searchQuery.value.toLowerCase();

// //     if (q.isEmpty) {
// //       filteredWorkers.value = workers;
// //     } else {
// //       filteredWorkers.value = workers.where((w) {
// //         return w.name.toLowerCase().contains(q) ||
// //             w.skill.toLowerCase().contains(q) ||
// //             w.location.toLowerCase().contains(q);
// //       }).toList();
// //     }
// //   }
// // }
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:get/get.dart';
// import '../model/worker_model.dart';

// class ServiceHomeController extends GetxController {
//   final _db = FirebaseFirestore.instance;

//   RxList<WorkerModel> workers = <WorkerModel>[].obs;
//   RxList<WorkerModel> filteredWorkers = <WorkerModel>[].obs;

//   RxBool isLoading = true.obs;

//   RxString searchQuery = ''.obs;
//   RxString selectedLocation = ''.obs;
//   RxList<String> locations = <String>[].obs;

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
//             _extractLocations();
//             applyFilters();
//             isLoading.value = false;
//           },
//           onError: (e) {
//             isLoading.value = false;
//             print("Firestore error: $e");
//           },
//         );
//   }

//   void _extractLocations() {
//     final locs = workers.map((w) => w.location).toSet().toList();
//     locations.value = locs;
//   }

//   void onSearch(String value) {
//     searchQuery.value = value;
//     applyFilters();
//   }

//   void onLocationFilter(String? value) {
//     selectedLocation.value = value ?? '';
//     applyFilters();
//   }

//   void applyFilters() {
//     final q = searchQuery.value.toLowerCase();
//     final loc = selectedLocation.value;

//     filteredWorkers.value = workers.where((w) {
//       final matchesSearch =
//           q.isEmpty ||
//           w.name.toLowerCase().contains(q) ||
//           w.skill.toLowerCase().contains(q) ||
//           w.location.toLowerCase().contains(q);

//       final matchesLocation = loc.isEmpty || w.location == loc;

//       return matchesSearch && matchesLocation;
//     }).toList();
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

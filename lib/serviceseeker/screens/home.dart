// // import 'package:flutter/material.dart';
// // import 'package:jobportal/serviceseeker/controller/service_home_controller.dart';
// // import 'package:jobportal/serviceseeker/model/worker_model.dart';
// // import 'package:url_launcher/url_launcher.dart';

// // // class ServiceHomeScreen extends StatelessWidget {
// // //   const ServiceHomeScreen({super.key});

// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return Scaffold(
// // //       backgroundColor: const Color(0xFFF7FAFF),
// // //       appBar: AppBar(
// // //         title: const Text('Find Workers'),
// // //         backgroundColor: Colors.white,
// // //         foregroundColor: Colors.black,
// // //         elevation: 0,
// // //       ),
// // //       body: Column(
// // //         children: [
// // //           const SizedBox(height: 12),

// // //           /// 🔍 Search Bar
// // //           Padding(
// // //             padding: const EdgeInsets.symmetric(horizontal: 20),
// // //             child: _SearchBar(),
// // //           ),

// // //           const SizedBox(height: 20),

// // //           /// 👷 Workers List
// // //           Expanded(
// // //             child: ListView.builder(
// // //               padding: const EdgeInsets.symmetric(horizontal: 20),
// // //               itemCount: 6, // temporary
// // //               itemBuilder: (context, index) {
// // //                 return const _WorkerCard();
// // //               },
// // //             ),
// // //           ),
// // //         ],
// // //       ),
// // //     );
// // //   }
// // // }
// // import 'package:flutter/material.dart';
// // import 'package:get/get.dart';
// // //import '../controllers/service_home_controller.dart';
// // //import '../models/worker_model.dart';
// // import 'package:url_launcher/url_launcher.dart';

// // class ServiceHomeScreen extends StatelessWidget {
// //   const ServiceHomeScreen({super.key});

// //   @override
// //   Widget build(BuildContext context) {
// //     final controller = Get.put(ServiceHomeController());

// //     return Scaffold(
// //       backgroundColor: const Color(0xFFF7FAFF),
// //       appBar: AppBar(
// //         title: const Text('Find Workers'),
// //         backgroundColor: Colors.white,
// //         foregroundColor: Colors.black,
// //         elevation: 0,
// //       ),
// //       body: Column(
// //         children: [
// //           const SizedBox(height: 12),

// //           /// 🔍 Search
// //           Padding(
// //             padding: const EdgeInsets.symmetric(horizontal: 20),
// //             child: TextField(
// //               onChanged: controller.onSearch,
// //               decoration: InputDecoration(
// //                 hintText: 'Search electrician, plumber...',
// //                 prefixIcon: const Icon(Icons.search),
// //                 filled: true,
// //                 fillColor: Colors.white,
// //                 border: OutlineInputBorder(
// //                   borderRadius: BorderRadius.circular(16),
// //                   borderSide: BorderSide.none,
// //                 ),
// //               ),
// //             ),
// //           ),

// //           const SizedBox(height: 20),

// //           /// 👷 Workers
// //           Expanded(
// //             child: Obx(() {
// //               if (controller.isLoading.value) {
// //                 return const Center(child: CircularProgressIndicator());
// //               }

// //               if (controller.filteredWorkers.isEmpty) {
// //                 return const Center(child: Text("No workers found"));
// //               }

// //               return ListView.builder(
// //                 padding: const EdgeInsets.symmetric(horizontal: 20),
// //                 itemCount: controller.filteredWorkers.length,
// //                 itemBuilder: (context, index) {
// //                   final worker = controller.filteredWorkers[index];
// //                   return _WorkerCard(worker: worker);
// //                 },
// //               );
// //             }),
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// // }

// // class _SearchBar extends StatelessWidget {
// //   @override
// //   Widget build(BuildContext context) {
// //     return TextField(
// //       decoration: InputDecoration(
// //         hintText: 'Search workers (electrician, plumber...)',
// //         prefixIcon: const Icon(Icons.search),
// //         filled: true,
// //         fillColor: Colors.white,
// //         border: OutlineInputBorder(
// //           borderRadius: BorderRadius.circular(16),
// //           borderSide: BorderSide.none,
// //         ),
// //       ),
// //     );
// //   }
// // }
// // // class _WorkerCard extends StatelessWidget {
// // //   const _WorkerCard();

// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return Container(
// // //       margin: const EdgeInsets.only(bottom: 16),
// // //       padding: const EdgeInsets.all(16),
// // //       decoration: BoxDecoration(
// // //         color: Colors.white,
// // //         borderRadius: BorderRadius.circular(20),
// // //         boxShadow: [
// // //           BoxShadow(
// // //             color: Colors.black.withOpacity(0.08),
// // //             blurRadius: 20,
// // //             offset: const Offset(0, 10),
// // //           ),
// // //         ],
// // //       ),
// // //       child: Column(
// // //         children: [
// // //           Row(
// // //             children: [
// // //               /// 👤 Photo
// // //               CircleAvatar(
// // //                 radius: 30,
// // //                 backgroundColor: Colors.grey.shade200,
// // //                 child: const Icon(Icons.person, size: 30),
// // //               ),
// // //               const SizedBox(width: 14),

// // //               /// ℹ Info
// // //               Expanded(
// // //                 child: Column(
// // //                   crossAxisAlignment: CrossAxisAlignment.start,
// // //                   children: const [
// // //                     Text(
// // //                       'Ramesh Kumar',
// // //                       style: TextStyle(
// // //                         fontSize: 16,
// // //                         fontWeight: FontWeight.w800,
// // //                       ),
// // //                     ),
// // //                     SizedBox(height: 4),
// // //                     Text(
// // //                       'Electrician • 5 yrs exp',
// // //                       style: TextStyle(color: Colors.black54),
// // //                     ),
// // //                     SizedBox(height: 4),
// // //                     Text(
// // //                       '₹800/day • Chennai',
// // //                       style: TextStyle(
// // //                         color: Color(0xFF2563EB),
// // //                         fontWeight: FontWeight.w600,
// // //                       ),
// // //                     ),
// // //                   ],
// // //                 ),
// // //               ),
// // //             ],
// // //           ),

// // //           const SizedBox(height: 16),

// // //           /// 📞 Buttons
// // //           Row(
// // //             children: [
// // //               Expanded(
// // //                 child: _ActionButton(
// // //                   icon: Icons.call,
// // //                   label: 'Call',
// // //                   color: Colors.green,
// // //                   onTap: () {},
// // //                 ),
// // //               ),
// // //               const SizedBox(width: 12),
// // //               Expanded(
// // //                 child: _ActionButton(
// // //                   icon: Icons.chat,
// // //                   label: 'WhatsApp',
// // //                   color: Colors.teal,
// // //                   onTap: () {},
// // //                 ),
// // //               ),
// // //             ],
// // //           )
// // //         ],
// // //       ),
// // //     );
// // //   }
// // // }
// // class _WorkerCard extends StatelessWidget {
// //   final WorkerModel worker;

// //   const _WorkerCard({required this.worker});

// //   @override
// //   Widget build(BuildContext context) {
// //     return Container(
// //       margin: const EdgeInsets.only(bottom: 16),
// //       padding: const EdgeInsets.all(16),
// //       decoration: BoxDecoration(
// //         color: Colors.white,
// //         borderRadius: BorderRadius.circular(20),
// //         boxShadow: [
// //           BoxShadow(
// //             color: Colors.black.withOpacity(0.08),
// //             blurRadius: 20,
// //             offset: const Offset(0, 10),
// //           ),
// //         ],
// //       ),
// //       child: Column(
// //         children: [
// //           Row(
// //             children: [
// //               CircleAvatar(
// //                 radius: 30,
// //                 backgroundImage: worker.photoUrl.isNotEmpty
// //                     ? NetworkImage(worker.photoUrl)
// //                     : null,
// //                 child: worker.photoUrl.isEmpty
// //                     ? const Icon(Icons.person)
// //                     : null,
// //               ),
// //               const SizedBox(width: 14),

// //               Expanded(
// //                 child: Column(
// //                   crossAxisAlignment: CrossAxisAlignment.start,
// //                   children: [
// //                     Text(
// //                       worker.name,
// //                       style: const TextStyle(
// //                         fontSize: 16,
// //                         fontWeight: FontWeight.w800,
// //                       ),
// //                     ),
// //                     const SizedBox(height: 4),
// //                     Text(
// //                       '${worker.skill} • ${worker.experience}',
// //                       style: const TextStyle(color: Colors.black54),
// //                     ),
// //                     const SizedBox(height: 4),
// //                     Text(
// //                       '₹${worker.chargePerDay}/day • ${worker.location}',
// //                       style: const TextStyle(
// //                         color: Color(0xFF2563EB),
// //                         fontWeight: FontWeight.w600,
// //                       ),
// //                     ),
// //                   ],
// //                 ),
// //               ),
// //             ],
// //           ),

// //           const SizedBox(height: 16),

// //           Row(
// //             children: [
// //               Expanded(
// //                 child: _ActionButton(
// //                   icon: Icons.call,
// //                   label: 'Call',
// //                   color: Colors.green,
// //                   onTap: () => launchUrl(Uri.parse('tel:${worker.phone}')),
// //                 ),
// //               ),
// //               const SizedBox(width: 12),
// //               Expanded(
// //                 child: _ActionButton(
// //                   icon: Icons.chat,
// //                   label: 'WhatsApp',
// //                   color: Colors.teal,
// //                   onTap: () =>
// //                       launchUrl(Uri.parse('https://wa.me/${worker.whatsapp}')),
// //                 ),
// //               ),
// //             ],
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// // }

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../controller/service_home_controller.dart';
// import '../model/worker_model.dart';
// import 'package:url_launcher/url_launcher.dart';

// class ServiceHomeScreen extends StatelessWidget {
//   const ServiceHomeScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final controller = Get.put(ServiceHomeController());

//     return Scaffold(
//       backgroundColor: const Color(0xFFF7FAFF),
//       appBar: AppBar(
//         title: const Text('Find Workers'),
//         backgroundColor: Colors.white,
//         foregroundColor: Colors.black,
//         elevation: 0,
//       ),
//       body: Column(
//         children: [
//           const SizedBox(height: 12),

//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 20),
//             child: TextField(
//               onChanged: controller.onSearch,
//               decoration: InputDecoration(
//                 hintText: 'Search electrician, plumber...',
//                 prefixIcon: const Icon(Icons.search),
//                 filled: true,
//                 fillColor: Colors.white,
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(16),
//                   borderSide: BorderSide.none,
//                 ),
//               ),
//             ),
//           ),

//           const SizedBox(height: 20),

//           Expanded(
//             child: Obx(() {
//               if (controller.isLoading.value) {
//                 return const Center(child: CircularProgressIndicator());
//               }

//               if (controller.filteredWorkers.isEmpty) {
//                 return const Center(
//                   child: Text(
//                     "No workers found",
//                     style: TextStyle(fontSize: 16),
//                   ),
//                 );
//               }

//               return ListView.builder(
//                 padding: const EdgeInsets.symmetric(horizontal: 20),
//                 itemCount: controller.filteredWorkers.length,
//                 itemBuilder: (context, index) {
//                   final worker = controller.filteredWorkers[index];
//                   return _WorkerCard(worker: worker);
//                 },
//               );
//             }),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class _WorkerCard extends StatelessWidget {
//   final WorkerModel worker;

//   const _WorkerCard({required this.worker});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: const EdgeInsets.only(bottom: 16),
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(20),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.08),
//             blurRadius: 20,
//             offset: const Offset(0, 10),
//           ),
//         ],
//       ),
//       child: Column(
//         children: [
//           Row(
//             children: [
//               CircleAvatar(
//                 radius: 30,
//                 backgroundImage: worker.photoUrl.isNotEmpty
//                     ? NetworkImage(worker.photoUrl)
//                     : null,
//                 child: worker.photoUrl.isEmpty
//                     ? const Icon(Icons.person)
//                     : null,
//               ),
//               const SizedBox(width: 14),

//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       worker.name,
//                       style: const TextStyle(
//                         fontSize: 16,
//                         fontWeight: FontWeight.w800,
//                       ),
//                     ),
//                     const SizedBox(height: 4),
//                     Text(
//                       '${worker.skill} • ${worker.experience}',
//                       style: const TextStyle(color: Colors.black54),
//                     ),
//                     const SizedBox(height: 4),
//                     Text(
//                       '₹${worker.chargePerDay}/day • ${worker.location}',
//                       style: const TextStyle(
//                         color: Color(0xFF2563EB),
//                         fontWeight: FontWeight.w600,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),

//           const SizedBox(height: 16),

//           Row(
//             children: [
//               Expanded(
//                 child: _ActionButton(
//                   icon: Icons.call,
//                   label: 'Call',
//                   color: Colors.green,
//                   onTap: () => launchUrl(Uri.parse('tel:${worker.phone}')),
//                 ),
//               ),
//               const SizedBox(width: 12),
//               Expanded(
//                 child: _ActionButton(
//                   icon: Icons.chat,
//                   label: 'WhatsApp',
//                   color: Colors.teal,
//                   onTap: () =>
//                       launchUrl(Uri.parse('https://wa.me/${worker.whatsapp}')),
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }

// class _ActionButton extends StatelessWidget {
//   final IconData icon;
//   final String label;
//   final Color color;
//   final VoidCallback onTap;

//   const _ActionButton({
//     required this.icon,
//     required this.label,
//     required this.color,
//     required this.onTap,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Container(
//         height: 44,
//         decoration: BoxDecoration(
//           color: color.withOpacity(0.1),
//           borderRadius: BorderRadius.circular(14),
//         ),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Icon(icon, color: color, size: 18),
//             const SizedBox(width: 6),
//             Text(
//               label,
//               style: TextStyle(color: color, fontWeight: FontWeight.w700),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../controller/service_home_controller.dart';
// import '../model/worker_model.dart';
// import 'package:url_launcher/url_launcher.dart';

// class ServiceHomeScreen extends StatelessWidget {
//   const ServiceHomeScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final controller = Get.put(ServiceHomeController());

//     return Scaffold(
//       backgroundColor: const Color(0xFFF7FAFF),

//       appBar: AppBar(
//         title: const Text('Find Workers'),
//         backgroundColor: Colors.white,
//         foregroundColor: Colors.black,
//         elevation: 0,
//         actions: [
//           IconButton(
//             icon: const CircleAvatar(child: Icon(Icons.person)),
//             onPressed: () {
//               Get.toNamed('/service-profile'); // later
//             },
//           ),
//           const SizedBox(width: 10),
//         ],
//       ),

//       body: Column(
//         children: [
//           const SizedBox(height: 12),

//           /// 🔍 Search
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 20),
//             child: TextField(
//               onChanged: controller.onSearch,
//               decoration: InputDecoration(
//                 hintText: 'Search electrician, plumber...',
//                 prefixIcon: const Icon(Icons.search),
//                 filled: true,
//                 fillColor: Colors.white,
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(16),
//                   borderSide: BorderSide.none,
//                 ),
//               ),
//             ),
//           ),

//           const SizedBox(height: 12),

//           /// 📍 Location Filter
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 20),
//             child: Obx(() {
//               return DropdownButtonFormField<String>(
//                 value: controller.selectedLocation.value.isEmpty
//                     ? null
//                     : controller.selectedLocation.value,
//                 hint: const Text("Filter by location"),
//                 items: controller.locations
//                     .map(
//                       (loc) => DropdownMenuItem(value: loc, child: Text(loc)),
//                     )
//                     .toList(),
//                 onChanged: controller.onLocationFilter,
//                 decoration: InputDecoration(
//                   filled: true,
//                   fillColor: Colors.white,
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(16),
//                     borderSide: BorderSide.none,
//                   ),
//                 ),
//               );
//             }),
//           ),

//           const SizedBox(height: 20),

//           Expanded(
//             child: Obx(() {
//               if (controller.isLoading.value) {
//                 return const Center(child: CircularProgressIndicator());
//               }

//               if (controller.filteredWorkers.isEmpty) {
//                 return const Center(
//                   child: Text(
//                     "No workers found",
//                     style: TextStyle(fontSize: 16),
//                   ),
//                 );
//               }

//               return ListView.builder(
//                 padding: const EdgeInsets.symmetric(horizontal: 20),
//                 itemCount: controller.filteredWorkers.length,
//                 itemBuilder: (context, index) {
//                   final worker = controller.filteredWorkers[index];
//                   return _WorkerCard(worker: worker);
//                 },
//               );
//             }),
//           ),
//         ],
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/service_home_controller.dart';
import '../model/worker_model.dart';
import 'package:url_launcher/url_launcher.dart';

class ServiceHomeScreen extends StatelessWidget {
  const ServiceHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ServiceHomeController());

    return Scaffold(
      backgroundColor: const Color(0xFFF7FAFF),
      appBar: AppBar(
        title: const Text('Find Workers'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        actions: [
          IconButton(
            icon: const CircleAvatar(
              backgroundColor: Color(0xFF2563EB),
              child: Icon(Icons.person, color: Colors.white),
            ),
            onPressed: () {
              Get.toNamed('/service-profile');
            },
          ),
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () => _openFilterSheet(context, controller),
          ),
        ],
      ),
      body: Column(
        children: [
          const SizedBox(height: 12),

          /// 🔍 Search
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: TextField(
              onChanged: controller.onSearch,
              decoration: InputDecoration(
                hintText: 'Search electrician, plumber...',
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),

          const SizedBox(height: 20),

          /// 👷 Workers
          Expanded(
            child: Obx(() {
              if (controller.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }

              if (controller.filteredWorkers.isEmpty) {
                return const Center(child: Text("No workers found"));
              }

              return ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                itemCount: controller.filteredWorkers.length,
                itemBuilder: (context, index) {
                  final worker = controller.filteredWorkers[index];
                  return _WorkerCard(worker: worker);
                },
              );
            }),
          ),
        ],
      ),
    );
  }

  void _openFilterSheet(
    BuildContext context,
    ServiceHomeController controller,
  ) {
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Filters",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
              ),
              const SizedBox(height: 20),

              const Text("Location"),
              const SizedBox(height: 10),
              Wrap(
                spacing: 10,
                children: controller.getLocations().map((loc) {
                  return ChoiceChip(
                    label: Text(loc),
                    selected: controller.selectedLocation.value == loc,
                    onSelected: (_) => controller.setLocation(loc),
                  );
                }).toList(),
              ),

              const SizedBox(height: 20),
              const Text("Sort By"),
              const SizedBox(height: 10),

              _sortTile("Name", SortType.name, controller),
              _sortTile("Price: Low → High", SortType.priceLowHigh, controller),
              _sortTile("Price: High → Low", SortType.priceHighLow, controller),
              _sortTile("Experience", SortType.experience, controller),

              const SizedBox(height: 20),

              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: controller.resetFilters,
                  child: const Text("Reset Filters"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _sortTile(
    String title,
    SortType type,
    ServiceHomeController controller,
  ) {
    return Obx(
      () => RadioListTile<SortType>(
        title: Text(title),
        value: type,
        groupValue: controller.selectedSort.value,
        onChanged: controller.setSort,
      ),
    );
  }
}

class _WorkerCard extends StatelessWidget {
  final WorkerModel worker;

  const _WorkerCard({required this.worker});

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      tween: Tween<double>(begin: 0, end: 1),
      duration: const Duration(milliseconds: 500),
      builder: (context, double value, child) {
        return Opacity(
          opacity: value,
          child: Transform.translate(
            offset: Offset(0, 20 * (1 - value)),
            child: child,
          ),
        );
      },
      child: GestureDetector(
        onTap: () {
          Get.toNamed('/worker-profile', arguments: worker);
        },
        child: Container(
          margin: const EdgeInsets.only(bottom: 16),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.08),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Hero(
                    tag: worker.id,
                    child: CircleAvatar(
                      radius: 30,
                      backgroundImage: worker.photoUrl.isNotEmpty
                          ? NetworkImage(worker.photoUrl)
                          : null,
                      child: worker.photoUrl.isEmpty
                          ? const Icon(Icons.person)
                          : null,
                    ),
                  ),
                  const SizedBox(width: 14),

                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          worker.name,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '${worker.skill} • ${worker.experience}',
                          style: const TextStyle(color: Colors.black54),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '₹${worker.chargePerDay}/day • ${worker.location}',
                          style: const TextStyle(
                            color: Color(0xFF2563EB),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 6),

                        /// ⭐ Rating Row
                        Row(
                          children: [
                            const Icon(
                              Icons.star,
                              color: Colors.amber,
                              size: 18,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              worker.averageRating.toStringAsFixed(1),
                              style: const TextStyle(
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const SizedBox(width: 6),
                            Text(
                              '(${worker.totalReviews} reviews)',
                              style: const TextStyle(
                                color: Colors.black54,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              Row(
                children: [
                  Expanded(
                    child: _ActionButton(
                      icon: Icons.call,
                      label: 'Call',
                      color: Colors.green,
                      onTap: () async {
                        final url = Uri.parse('tel:${worker.phone}');
                        if (await canLaunchUrl(url)) {
                          launchUrl(url);
                        }
                      },
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _ActionButton(
                      icon: Icons.chat,
                      label: 'WhatsApp',
                      color: Colors.teal,
                      onTap: () async {
                        final url = Uri.parse(
                          'https://wa.me/${worker.whatsapp}',
                        );
                        if (await canLaunchUrl(url)) {
                          launchUrl(url);
                        }
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  const _ActionButton({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 44,
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(14),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color, size: 18),
            const SizedBox(width: 6),
            Text(
              label,
              style: TextStyle(color: color, fontWeight: FontWeight.w700),
            ),
          ],
        ),
      ),
    );
  }
}

// // // import 'package:flutter/material.dart';
// // // import 'package:get/get.dart';
// // // import '../controller/service_home_controller.dart';
// // // import '../model/worker_model.dart';
// // // import 'package:url_launcher/url_launcher.dart';

// // // class ServiceHomeScreen extends StatelessWidget {
// // //   const ServiceHomeScreen({super.key});

// // //   @override
// // //   Widget build(BuildContext context) {
// // //     final controller = Get.put(ServiceHomeController());

// // //     return Scaffold(
// // //       backgroundColor: const Color(0xFFF7FAFF),
// // //       appBar: AppBar(
// // //         title: const Text('Find Workers'),
// // //         backgroundColor: Colors.white,
// // //         foregroundColor: Colors.black,
// // //         elevation: 0,
// // //         actions: [
// // //           IconButton(
// // //             icon: const CircleAvatar(
// // //               backgroundColor: Color(0xFF2563EB),
// // //               child: Icon(Icons.person, color: Colors.white),
// // //             ),
// // //             onPressed: () {
// // //               Get.toNamed('/service-profile');
// // //             },
// // //           ),
// // //           IconButton(
// // //             icon: const Icon(Icons.filter_list),
// // //             onPressed: () => _openFilterSheet(context, controller),
// // //           ),
// // //         ],
// // //       ),
// // //       body: Column(
// // //         children: [
// // //           const SizedBox(height: 12),

// // //           /// 🔍 Search
// // //           Padding(
// // //             padding: const EdgeInsets.symmetric(horizontal: 20),
// // //             child: TextField(
// // //               onChanged: controller.onSearch,
// // //               decoration: InputDecoration(
// // //                 hintText: 'Search electrician, plumber...',
// // //                 prefixIcon: const Icon(Icons.search),
// // //                 filled: true,
// // //                 fillColor: Colors.white,
// // //                 border: OutlineInputBorder(
// // //                   borderRadius: BorderRadius.circular(16),
// // //                   borderSide: BorderSide.none,
// // //                 ),
// // //               ),
// // //             ),
// // //           ),

// // //           const SizedBox(height: 12),

// // //           /// 🔧 Profession chips
// // //           Obx(() {
// // //             final professions = [
// // //               'Electrician',
// // //               'Plumber',
// // //               'Driver',
// // //               'Painter',
// // //               'Cleaner',
// // //               'Carpenter',
// // //               'Mechanic',
// // //             ];

// // //             return SizedBox(
// // //               height: 42,
// // //               child: ListView.separated(
// // //                 padding: const EdgeInsets.symmetric(horizontal: 20),
// // //                 scrollDirection: Axis.horizontal,
// // //                 itemBuilder: (context, index) {
// // //                   final prof = professions[index];
// // //                   final isSelected =
// // //                       controller.selectedProfession.value == prof;

// // //                   return ChoiceChip(
// // //                     label: Text(prof),
// // //                     selected: isSelected,
// // //                     onSelected: (_) => controller.setProfession(prof),
// // //                     selectedColor: const Color(0xFF2563EB),
// // //                     labelStyle: TextStyle(
// // //                       color: isSelected ? Colors.white : Colors.black,
// // //                       fontWeight: FontWeight.w600,
// // //                     ),
// // //                   );
// // //                 },
// // //                 separatorBuilder: (_, __) => const SizedBox(width: 10),
// // //                 itemCount: professions.length,
// // //               ),
// // //             );
// // //           }),
// // //           const SizedBox(height: 20),

// // //           /// 👷 Workers
// // //           Expanded(
// // //             child: Obx(() {
// // //               if (controller.isLoading.value) {
// // //                 return const Center(child: CircularProgressIndicator());
// // //               }

// // //               if (controller.filteredWorkers.isEmpty) {
// // //                 return const Center(child: Text("No workers found"));
// // //               }

// // //               return ListView.builder(
// // //                 padding: const EdgeInsets.symmetric(horizontal: 20),
// // //                 itemCount: controller.filteredWorkers.length,
// // //                 itemBuilder: (context, index) {
// // //                   final worker = controller.filteredWorkers[index];
// // //                   return _WorkerCard(worker: worker);
// // //                 },
// // //               );
// // //             }),
// // //           ),
// // //         ],
// // //       ),
// // //     );
// // //   }

// // //   // void _openFilterSheet(
// // //   //   BuildContext context,
// // //   //   ServiceHomeController controller,
// // //   // ) {
// // //   //   Get.bottomSheet(
// // //   //     Container(
// // //   //       padding: const EdgeInsets.all(20),
// // //   //       decoration: const BoxDecoration(
// // //   //         color: Colors.white,
// // //   //         borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
// // //   //       ),
// // //   //       child: SingleChildScrollView(
// // //   //         child: Column(
// // //   //           crossAxisAlignment: CrossAxisAlignment.start,
// // //   //           children: [
// // //   //             const Text(
// // //   //               "Filters",
// // //   //               style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
// // //   //             ),
// // //   //             const SizedBox(height: 20),

// // //   //             const Text("Location"),
// // //   //             const SizedBox(height: 10),
// // //   //             Wrap(
// // //   //               spacing: 10,
// // //   //               children: controller.getLocations().map((loc) {
// // //   //                 return ChoiceChip(
// // //   //                   label: Text(loc),
// // //   //                   selected: controller.selectedLocation.value == loc,
// // //   //                   onSelected: (_) => controller.setLocation(loc),
// // //   //                 );
// // //   //               }).toList(),
// // //   //             ),

// // //   //             const SizedBox(height: 20),
// // //   //             const Text("Sort By"),
// // //   //             const SizedBox(height: 10),

// // //   //             _sortTile("Name", SortType.name, controller),
// // //   //             _sortTile("Price: Low → High", SortType.priceLowHigh, controller),
// // //   //             _sortTile("Price: High → Low", SortType.priceHighLow, controller),
// // //   //             _sortTile("Experience", SortType.experience, controller),

// // //   //             const SizedBox(height: 20),

// // //   //             SizedBox(
// // //   //               width: double.infinity,
// // //   //               child: OutlinedButton(
// // //   //                 onPressed: controller.resetFilters,
// // //   //                 child: const Text("Reset Filters"),
// // //   //               ),
// // //   //             ),
// // //   //           ],
// // //   //         ),
// // //   //       ),
// // //   //     ),
// // //   //   );
// // //   // }
// // //   void _openFilterSheet(
// // //     BuildContext context,
// // //     ServiceHomeController controller,
// // //   ) {
// // //     Get.bottomSheet(
// // //       Container(
// // //         padding: const EdgeInsets.all(20),
// // //         decoration: const BoxDecoration(
// // //           color: Colors.white,
// // //           borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
// // //         ),
// // //         child: SingleChildScrollView(
// // //           child: Column(
// // //             crossAxisAlignment: CrossAxisAlignment.start,
// // //             children: [
// // //               const Text(
// // //                 "Filters",
// // //                 style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
// // //               ),
// // //               const SizedBox(height: 20),

// // //               /// 📍 Location
// // //               const Text("Location"),
// // //               const SizedBox(height: 10),
// // //               Obx(
// // //                 () => Wrap(
// // //                   spacing: 10,
// // //                   children: controller.getLocations().map((loc) {
// // //                     return ChoiceChip(
// // //                       label: Text(loc),
// // //                       selected: controller.selectedLocation.value == loc,
// // //                       onSelected: (_) => controller.setLocation(loc),
// // //                     );
// // //                   }).toList(),
// // //                 ),
// // //               ),

// // //               const SizedBox(height: 20),

// // //               /// ↕️ Sort
// // //               const Text("Sort By"),
// // //               const SizedBox(height: 10),

// // //               _sortTile("Name", SortType.name, controller),
// // //               _sortTile("Price: Low → High", SortType.priceLowHigh, controller),
// // //               _sortTile("Price: High → Low", SortType.priceHighLow, controller),
// // //               _sortTile("Experience", SortType.experience, controller),

// // //               const SizedBox(height: 24),

// // //               /// 🔘 Buttons Row
// // //               Row(
// // //                 children: [
// // //                   Expanded(
// // //                     child: OutlinedButton(
// // //                       onPressed: () {
// // //                         controller.resetFilters();
// // //                         Get.back(); // close sheet
// // //                       },
// // //                       child: const Text("Reset"),
// // //                     ),
// // //                   ),
// // //                   const SizedBox(width: 12),
// // //                   Expanded(
// // //                     child: ElevatedButton(
// // //                       onPressed: () {
// // //                         controller.applyFilters(); // apply filters
// // //                         Get.back(); // close sheet
// // //                       },
// // //                       child: const Text("Apply"),
// // //                     ),
// // //                   ),
// // //                 ],
// // //               ),
// // //             ],
// // //           ),
// // //         ),
// // //       ),
// // //       isScrollControlled: true,
// // //     );
// // //   }

// // //   Widget _sortTile(
// // //     String title,
// // //     SortType type,
// // //     ServiceHomeController controller,
// // //   ) {
// // //     return Obx(
// // //       () => RadioListTile<SortType>(
// // //         title: Text(title),
// // //         value: type,
// // //         groupValue: controller.selectedSort.value,
// // //         onChanged: controller.setSort,
// // //       ),
// // //     );
// // //   }
// // // }

// // // class _WorkerCard extends StatelessWidget {
// // //   final WorkerModel worker;

// // //   const _WorkerCard({required this.worker});

// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return TweenAnimationBuilder(
// // //       tween: Tween<double>(begin: 0, end: 1),
// // //       duration: const Duration(milliseconds: 500),
// // //       builder: (context, double value, child) {
// // //         return Opacity(
// // //           opacity: value,
// // //           child: Transform.translate(
// // //             offset: Offset(0, 20 * (1 - value)),
// // //             child: child,
// // //           ),
// // //         );
// // //       },
// // //       child: GestureDetector(
// // //         onTap: () {
// // //           Get.toNamed('/worker-profile', arguments: worker);
// // //         },
// // //         child: Container(
// // //           margin: const EdgeInsets.only(bottom: 16),
// // //           padding: const EdgeInsets.all(16),
// // //           decoration: BoxDecoration(
// // //             color: Colors.white,
// // //             borderRadius: BorderRadius.circular(20),
// // //             boxShadow: [
// // //               BoxShadow(
// // //                 color: Colors.black.withOpacity(0.08),
// // //                 blurRadius: 20,
// // //                 offset: const Offset(0, 10),
// // //               ),
// // //             ],
// // //           ),
// // //           child: Column(
// // //             children: [
// // //               Row(
// // //                 children: [
// // //                   Hero(
// // //                     tag: worker.id,
// // //                     child: CircleAvatar(
// // //                       radius: 30,
// // //                       backgroundImage: worker.photoUrl.isNotEmpty
// // //                           ? NetworkImage(worker.photoUrl)
// // //                           : null,
// // //                       child: worker.photoUrl.isEmpty
// // //                           ? const Icon(Icons.person)
// // //                           : null,
// // //                     ),
// // //                   ),
// // //                   const SizedBox(width: 14),

// // //                   Expanded(
// // //                     child: Column(
// // //                       crossAxisAlignment: CrossAxisAlignment.start,
// // //                       children: [
// // //                         Text(
// // //                           worker.name,
// // //                           style: const TextStyle(
// // //                             fontSize: 16,
// // //                             fontWeight: FontWeight.w800,
// // //                           ),
// // //                         ),
// // //                         const SizedBox(height: 4),
// // //                         Text(
// // //                           '${worker.skill} • ${worker.experience}',
// // //                           style: const TextStyle(color: Colors.black54),
// // //                         ),
// // //                         const SizedBox(height: 4),
// // //                         Text(
// // //                           '₹${worker.chargePerDay}/day • ${worker.location}',
// // //                           style: const TextStyle(
// // //                             color: Color(0xFF2563EB),
// // //                             fontWeight: FontWeight.w600,
// // //                           ),
// // //                         ),
// // //                         const SizedBox(height: 6),

// // //                         /// ⭐ Rating Row
// // //                         // Row(
// // //                         //   children: [
// // //                         //     const Icon(
// // //                         //       Icons.star,
// // //                         //       color: Colors.amber,
// // //                         //       size: 18,
// // //                         //     ),
// // //                         //     const SizedBox(width: 4),
// // //                         //     Text(
// // //                         //       worker.averageRating.toStringAsFixed(1),
// // //                         //       style: const TextStyle(
// // //                         //         fontWeight: FontWeight.w700,
// // //                         //       ),
// // //                         //     ),
// // //                         //     const SizedBox(width: 6),
// // //                         //     Text(
// // //                         //       '(${worker.totalReviews} reviews)',
// // //                         //       style: const TextStyle(
// // //                         //         color: Colors.black54,
// // //                         //         fontSize: 12,
// // //                         //       ),
// // //                         //     ),
// // //                         //   ],
// // //                         // ),
// // //                         Row(
// // //                           children: [
// // //                             Icon(Icons.star, size: 16, color: Colors.amber),
// // //                             const SizedBox(width: 4),
// // //                             Text(
// // //                               worker.averageRating.toString(),
// // //                               style: const TextStyle(
// // //                                 fontWeight: FontWeight.bold,
// // //                               ),
// // //                             ),
// // //                             const SizedBox(width: 6),
// // //                             Text(
// // //                               "(${worker.totalReviews})",
// // //                               style: const TextStyle(color: Colors.grey),
// // //                             ),
// // //                           ],
// // //                         ),
// // //                       ],
// // //                     ),
// // //                   ),
// // //                 ],
// // //               ),

// // //               const SizedBox(height: 16),

// // //               Row(
// // //                 children: [
// // //                   Expanded(
// // //                     child: _ActionButton(
// // //                       icon: Icons.call,
// // //                       label: 'Call',
// // //                       color: Colors.green,
// // //                       onTap: () async {
// // //                         final url = Uri.parse('tel:${worker.phone}');
// // //                         if (await canLaunchUrl(url)) {
// // //                           launchUrl(url);
// // //                         }
// // //                       },
// // //                     ),
// // //                   ),
// // //                   const SizedBox(width: 12),
// // //                   Expanded(
// // //                     child: _ActionButton(
// // //                       icon: Icons.chat,
// // //                       label: 'WhatsApp',
// // //                       color: Colors.teal,
// // //                       onTap: () async {
// // //                         final url = Uri.parse(
// // //                           'https://wa.me/${worker.whatsapp}',
// // //                         );
// // //                         if (await canLaunchUrl(url)) {
// // //                           launchUrl(url);
// // //                         }
// // //                       },
// // //                     ),
// // //                   ),
// // //                 ],
// // //               ),
// // //             ],
// // //           ),
// // //         ),
// // //       ),
// // //     );
// // //   }
// // // }

// // // class _ActionButton extends StatelessWidget {
// // //   final IconData icon;
// // //   final String label;
// // //   final Color color;
// // //   final VoidCallback onTap;

// // //   const _ActionButton({
// // //     required this.icon,
// // //     required this.label,
// // //     required this.color,
// // //     required this.onTap,
// // //   });

// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return GestureDetector(
// // //       onTap: onTap,
// // //       child: Container(
// // //         height: 44,
// // //         decoration: BoxDecoration(
// // //           color: color.withOpacity(0.1),
// // //           borderRadius: BorderRadius.circular(14),
// // //         ),
// // //         child: Row(
// // //           mainAxisAlignment: MainAxisAlignment.center,
// // //           children: [
// // //             Icon(icon, color: color, size: 18),
// // //             const SizedBox(width: 6),
// // //             Text(
// // //               label,
// // //               style: TextStyle(color: color, fontWeight: FontWeight.w700),
// // //             ),
// // //           ],
// // //         ),
// // //       ),
// // //     );
// // //   }
// // // }
// // import 'package:flutter/material.dart';
// // import 'package:get/get.dart';
// // import '../controller/service_home_controller.dart';
// // import '../model/worker_model.dart';
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
// //         actions: [
// //           IconButton(
// //             icon: const CircleAvatar(
// //               backgroundColor: Color(0xFF2563EB),
// //               child: Icon(Icons.person, color: Colors.white),
// //             ),
// //             onPressed: () => Get.toNamed('/service-profile'),
// //           ),
// //           IconButton(
// //             icon: const Icon(Icons.filter_list),
// //             onPressed: () => _openFilterSheet(context, controller),
// //           ),
// //         ],
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

// //           const SizedBox(height: 12),

// //           /// 🔧 Profession Chips
// //           Obx(() {
// //             final professions = [
// //               'Electrician',
// //               'Plumber',
// //               'Driver',
// //               'Painter',
// //               'Cleaner',
// //               'Carpenter',
// //               'Mechanic',
// //             ];

// //             return SizedBox(
// //               height: 42,
// //               child: ListView.separated(
// //                 padding: const EdgeInsets.symmetric(horizontal: 20),
// //                 scrollDirection: Axis.horizontal,
// //                 itemBuilder: (context, index) {
// //                   final prof = professions[index];
// //                   final isSelected =
// //                       controller.selectedProfession.value == prof;

// //                   return ChoiceChip(
// //                     label: Text(prof),
// //                     selected: isSelected,
// //                     onSelected: (_) => controller.setProfession(prof),
// //                     selectedColor: const Color(0xFF2563EB),
// //                     labelStyle: TextStyle(
// //                       color: isSelected ? Colors.white : Colors.black,
// //                       fontWeight: FontWeight.w600,
// //                     ),
// //                   );
// //                 },
// //                 separatorBuilder: (_, __) => const SizedBox(width: 10),
// //                 itemCount: professions.length,
// //               ),
// //             );
// //           }),

// //           const SizedBox(height: 20),

// //           /// 👷 Workers List
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

// //   void _openFilterSheet(
// //     BuildContext context,
// //     ServiceHomeController controller,
// //   ) {
// //     Get.bottomSheet(
// //       Container(
// //         padding: const EdgeInsets.all(20),
// //         decoration: const BoxDecoration(
// //           color: Colors.white,
// //           borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
// //         ),
// //         child: SingleChildScrollView(
// //           child: Column(
// //             crossAxisAlignment: CrossAxisAlignment.start,
// //             children: [
// //               const Text(
// //                 "Filters",
// //                 style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
// //               ),
// //               const SizedBox(height: 20),

// //               /// 📍 Location
// //               const Text("Location"),
// //               const SizedBox(height: 10),
// //               Obx(
// //                 () => Wrap(
// //                   spacing: 10,
// //                   children: controller.getLocations().map((loc) {
// //                     return ChoiceChip(
// //                       label: Text(loc),
// //                       selected: controller.selectedLocation.value == loc,
// //                       onSelected: (_) => controller.setLocation(loc),
// //                     );
// //                   }).toList(),
// //                 ),
// //               ),

// //               const SizedBox(height: 20),

// //               /// ↕️ Sort
// //               const Text("Sort By"),
// //               const SizedBox(height: 10),

// //               _sortTile("Name", SortType.name, controller),
// //               _sortTile("Price: Low → High", SortType.priceLowHigh, controller),
// //               _sortTile("Price: High → Low", SortType.priceHighLow, controller),
// //               _sortTile("Experience", SortType.experience, controller),

// //               const SizedBox(height: 24),

// //               /// Buttons
// //               Row(
// //                 children: [
// //                   Expanded(
// //                     child: OutlinedButton(
// //                       onPressed: () {
// //                         controller.resetFilters();
// //                         Get.back();
// //                       },
// //                       child: const Text("Reset"),
// //                     ),
// //                   ),
// //                   const SizedBox(width: 12),
// //                   Expanded(
// //                     child: ElevatedButton(
// //                       onPressed: () {
// //                         controller.applyFilters();
// //                         Get.back();
// //                       },
// //                       child: const Text("Apply"),
// //                     ),
// //                   ),
// //                 ],
// //               ),
// //             ],
// //           ),
// //         ),
// //       ),
// //       isScrollControlled: true,
// //     );
// //   }

// //   Widget _sortTile(
// //     String title,
// //     SortType type,
// //     ServiceHomeController controller,
// //   ) {
// //     return Obx(
// //       () => RadioListTile<SortType>(
// //         title: Text(title),
// //         value: type,
// //         groupValue: controller.selectedSort.value,
// //         onChanged: controller.setSort,
// //       ),
// //     );
// //   }
// // }

// // class _WorkerCard extends StatelessWidget {
// //   final WorkerModel worker;

// //   const _WorkerCard({required this.worker});

// //   @override
// //   Widget build(BuildContext context) {
// //     return GestureDetector(
// //       onTap: () => Get.toNamed('/worker-profile', arguments: worker),
// //       child: Container(
// //         margin: const EdgeInsets.only(bottom: 16),
// //         padding: const EdgeInsets.all(16),
// //         decoration: BoxDecoration(
// //           color: Colors.white,
// //           borderRadius: BorderRadius.circular(20),
// //           boxShadow: [
// //             BoxShadow(
// //               color: Colors.black.withOpacity(0.08),
// //               blurRadius: 20,
// //               offset: const Offset(0, 10),
// //             ),
// //           ],
// //         ),
// //         child: Column(
// //           children: [
// //             Row(
// //               children: [
// //                 Hero(
// //                   tag: worker.id,
// //                   child: CircleAvatar(
// //                     radius: 30,
// //                     backgroundImage: worker.photoUrl.isNotEmpty
// //                         ? NetworkImage(worker.photoUrl)
// //                         : null,
// //                     child: worker.photoUrl.isEmpty
// //                         ? const Icon(Icons.person)
// //                         : null,
// //                   ),
// //                 ),
// //                 const SizedBox(width: 14),
// //                 Expanded(
// //                   child: Column(
// //                     crossAxisAlignment: CrossAxisAlignment.start,
// //                     children: [
// //                       Text(
// //                         worker.name,
// //                         style: const TextStyle(
// //                           fontSize: 16,
// //                           fontWeight: FontWeight.w800,
// //                         ),
// //                       ),
// //                       const SizedBox(height: 4),
// //                       Text(
// //                         '${worker.skill} • ${worker.experience}',
// //                         style: const TextStyle(color: Colors.black54),
// //                       ),
// //                       const SizedBox(height: 4),
// //                       Text(
// //                         '₹${worker.chargePerDay}/day • ${worker.location}',
// //                         style: const TextStyle(
// //                           color: Color(0xFF2563EB),
// //                           fontWeight: FontWeight.w600,
// //                         ),
// //                       ),
// //                       const SizedBox(height: 6),
// //                       Row(
// //                         children: [
// //                           const Icon(Icons.star,
// //                               size: 16, color: Colors.amber),
// //                           const SizedBox(width: 4),
// //                           Text(
// //                             worker.averageRating.toStringAsFixed(1),
// //                             style: const TextStyle(
// //                               fontWeight: FontWeight.bold,
// //                             ),
// //                           ),
// //                           const SizedBox(width: 6),
// //                           Text(
// //                             "(${worker.totalReviews})",
// //                             style: const TextStyle(color: Colors.grey),
// //                           ),
// //                         ],
// //                       ),
// //                     ],
// //                   ),
// //                 ),
// //               ],
// //             ),
// //             const SizedBox(height: 16),
// //             Row(
// //               children: [
// //                 Expanded(
// //                   child: _ActionButton(
// //                     icon: Icons.call,
// //                     label: 'Call',
// //                     color: Colors.green,
// //                     onTap: () async {
// //                       final url = Uri.parse('tel:${worker.phone}');
// //                       if (await canLaunchUrl(url)) {
// //                         launchUrl(url);
// //                       }
// //                     },
// //                   ),
// //                 ),
// //                 const SizedBox(width: 12),
// //                 Expanded(
// //                   child: _ActionButton(
// //                     icon: Icons.chat,
// //                     label: 'WhatsApp',
// //                     color: Colors.teal,
// //                     onTap: () async {
// //                       final url =
// //                           Uri.parse('https://wa.me/${worker.whatsapp}');
// //                       if (await canLaunchUrl(url)) {
// //                         launchUrl(url);
// //                       }
// //                     },
// //                   ),
// //                 ),
// //               ],
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }

// // class _ActionButton extends StatelessWidget {
// //   final IconData icon;
// //   final String label;
// //   final Color color;
// //   final VoidCallback onTap;

// //   const _ActionButton({
// //     required this.icon,
// //     required this.label,
// //     required this.color,
// //     required this.onTap,
// //   });

// //   @override
// //   Widget build(BuildContext context) {
// //     return GestureDetector(
// //       onTap: onTap,
// //       child: Container(
// //         height: 44,
// //         decoration: BoxDecoration(
// //           color: color.withOpacity(0.1),
// //           borderRadius: BorderRadius.circular(14),
// //         ),
// //         child: Row(
// //           mainAxisAlignment: MainAxisAlignment.center,
// //           children: [
// //             Icon(icon, color: color, size: 18),
// //             const SizedBox(width: 6),
// //             Text(
// //               label,
// //               style: TextStyle(color: color, fontWeight: FontWeight.w700),
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }
// // import 'package:flutter/material.dart';
// // import 'package:get/get.dart';
// // import '../controller/service_home_controller.dart';
// // import '../model/worker_model.dart';
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
// //         actions: [
// //           IconButton(
// //             icon: const CircleAvatar(
// //               backgroundColor: Color(0xFF2563EB),
// //               child: Icon(Icons.person, color: Colors.white),
// //             ),
// //             onPressed: () => Get.toNamed('/service-profile'),
// //           ),
// //           IconButton(
// //             icon: const Icon(Icons.filter_list),
// //             onPressed: () => _openFilterSheet(context, controller),
// //           ),
// //         ],
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

// //           const SizedBox(height: 12),

// //           /// 🔧 Profession Chips
// //           Obx(() {
// //             final professions = [
// //               'Electrician',
// //               'Plumber',
// //               'Driver',
// //               'Painter',
// //               'Cleaner',
// //               'Carpenter',
// //               'Mechanic',
// //             ];

// //             return SizedBox(
// //               height: 42,
// //               child: ListView.separated(
// //                 padding: const EdgeInsets.symmetric(horizontal: 20),
// //                 scrollDirection: Axis.horizontal,
// //                 itemBuilder: (context, index) {
// //                   final prof = professions[index];
// //                   final isSelected =
// //                       controller.selectedProfession.value == prof;

// //                   return ChoiceChip(
// //                     label: Text(prof),
// //                     selected: isSelected,
// //                     onSelected: (_) => controller.setProfession(prof),
// //                     selectedColor: const Color(0xFF2563EB),
// //                     labelStyle: TextStyle(
// //                       color: isSelected ? Colors.white : Colors.black,
// //                       fontWeight: FontWeight.w600,
// //                     ),
// //                   );
// //                 },
// //                 separatorBuilder: (_, __) => const SizedBox(width: 10),
// //                 itemCount: professions.length,
// //               ),
// //             );
// //           }),

// //           const SizedBox(height: 20),

// //           /// 👷 Workers List
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

// //   void _openFilterSheet(
// //     BuildContext context,
// //     ServiceHomeController controller,
// //   ) {
// //     Get.bottomSheet(
// //       Container(
// //         padding: const EdgeInsets.all(20),
// //         decoration: const BoxDecoration(
// //           color: Colors.white,
// //           borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
// //         ),
// //         child: SingleChildScrollView(
// //           child: Column(
// //             crossAxisAlignment: CrossAxisAlignment.start,
// //             children: [
// //               const Text(
// //                 "Filters",
// //                 style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
// //               ),
// //               const SizedBox(height: 20),

// //               /// 📍 Location
// //               const Text("Location"),
// //               const SizedBox(height: 10),
// //               Obx(
// //                 () => Wrap(
// //                   spacing: 10,
// //                   children: controller.getLocations().map((loc) {
// //                     return ChoiceChip(
// //                       label: Text(loc),
// //                       selected: controller.selectedLocation.value == loc,
// //                       onSelected: (_) => controller.setLocation(loc),
// //                     );
// //                   }).toList(),
// //                 ),
// //               ),

// //               const SizedBox(height: 20),

// //               /// ↕️ Sort
// //               const Text("Sort By"),
// //               const SizedBox(height: 10),

// //               _sortTile("Name", SortType.name, controller),
// //               _sortTile("Price: Low → High", SortType.priceLowHigh, controller),
// //               _sortTile("Price: High → Low", SortType.priceHighLow, controller),
// //               _sortTile("Experience", SortType.experience, controller),

// //               const SizedBox(height: 24),

// //               /// Buttons
// //               Row(
// //                 children: [
// //                   Expanded(
// //                     child: OutlinedButton(
// //                       onPressed: () {
// //                         controller.resetFilters();
// //                         Get.back();
// //                       },
// //                       child: const Text("Reset"),
// //                     ),
// //                   ),
// //                   const SizedBox(width: 12),
// //                   Expanded(
// //                     child: ElevatedButton(
// //                       onPressed: () {
// //                         controller.applyFilters();
// //                         Get.back();
// //                       },
// //                       child: const Text("Apply"),
// //                     ),
// //                   ),
// //                 ],
// //               ),
// //             ],
// //           ),
// //         ),
// //       ),
// //       isScrollControlled: true,
// //     );
// //   }

// //   Widget _sortTile(
// //     String title,
// //     SortType type,
// //     ServiceHomeController controller,
// //   ) {
// //     return Obx(
// //       () => RadioListTile<SortType>(
// //         title: Text(title),
// //         value: type,
// //         groupValue: controller.selectedSort.value,
// //         onChanged: controller.setSort,
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
//         actions: [
//           IconButton(
//             icon: const CircleAvatar(
//               backgroundColor: Color(0xFF2563EB),
//               child: Icon(Icons.person, color: Colors.white),
//             ),
//             onPressed: () {
//               Get.toNamed('/service-profile');
//             },
//           ),
//           IconButton(
//             icon: const Icon(Icons.filter_list),
//             onPressed: () => _openFilterSheet(context, controller),
//           ),
//         ],
//       ),
//       body: Column(
//         children: [
//           const SizedBox(height: 12),

//           // Search
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

//           // Profession Chips
//           Obx(() {
//             final professions = [
//               'Electrician',
//               'Plumber',
//               'Driver',
//               'Painter',
//               'Cleaner',
//               'Carpenter',
//               'Mechanic',
//             ];

//             return SizedBox(
//               height: 42,
//               child: ListView.separated(
//                 padding: const EdgeInsets.symmetric(horizontal: 20),
//                 scrollDirection: Axis.horizontal,
//                 itemCount: professions.length,
//                 separatorBuilder: (_, __) => const SizedBox(width: 10),
//                 itemBuilder: (context, index) {
//                   final prof = professions[index];
//                   final isSelected =
//                       controller.selectedProfession.value == prof;

//                   return ChoiceChip(
//                     label: Text(prof),
//                     selected: isSelected,
//                     onSelected: (_) => controller.setProfession(prof),
//                     selectedColor: const Color(0xFF2563EB),
//                     labelStyle: TextStyle(
//                       color: isSelected ? Colors.white : Colors.black,
//                     ),
//                   );
//                 },
//               ),
//             );
//           }),

//           const SizedBox(height: 16),

//           // Worker List
//           Expanded(
//             child: Obx(() {
//               if (controller.isLoading.value) {
//                 return const Center(child: CircularProgressIndicator());
//               }

//               if (controller.filteredWorkers.isEmpty) {
//                 return const Center(child: Text("No workers found"));
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

//   void _openFilterSheet(
//     BuildContext context,
//     ServiceHomeController controller,
//   ) {
//     Get.bottomSheet(
//       Container(
//         padding: const EdgeInsets.all(20),
//         decoration: const BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
//         ),
//         child: SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const Text(
//                 "Filters",
//                 style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
//               ),
//               const SizedBox(height: 20),

//               const Text("Location"),
//               const SizedBox(height: 10),

//               Obx(
//                 () => Wrap(
//                   spacing: 10,
//                   children: controller.getLocations().map((loc) {
//                     return ChoiceChip(
//                       label: Text(loc),
//                       selected: controller.selectedLocation.value == loc,
//                       onSelected: (_) => controller.setLocation(loc),
//                     );
//                   }).toList(),
//                 ),
//               ),

//               const SizedBox(height: 20),
//               const Text("Sort By"),
//               const SizedBox(height: 10),

//               _sortTile("Name", SortType.name, controller),
//               _sortTile("Price: Low → High", SortType.priceLowHigh, controller),
//               _sortTile("Price: High → Low", SortType.priceHighLow, controller),
//               _sortTile("Experience", SortType.experience, controller),

//               const SizedBox(height: 24),

//               Row(
//                 children: [
//                   Expanded(
//                     child: OutlinedButton(
//                       onPressed: () {
//                         controller.resetFilters();
//                         Get.back();
//                       },
//                       child: const Text("Reset"),
//                     ),
//                   ),
//                   const SizedBox(width: 12),
//                   Expanded(
//                     child: ElevatedButton(
//                       onPressed: () {
//                         controller.applyFilters();
//                         Get.back();
//                       },
//                       child: const Text("Apply"),
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//       isScrollControlled: true,
//     );
//   }

//   Widget _sortTile(
//     String title,
//     SortType type,
//     ServiceHomeController controller,
//   ) {
//     return Obx(
//       () => RadioListTile<SortType>(
//         title: Text(title),
//         value: type,
//         groupValue: controller.selectedSort.value,
//         onChanged: controller.setSort,
//       ),
//     );
//   }
// }

// class _WorkerCard extends StatelessWidget {
//   final WorkerModel worker;

//   const _WorkerCard({required this.worker});

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () => Get.toNamed('/worker-profile', arguments: worker),
//       child: Container(
//         margin: const EdgeInsets.only(bottom: 16),
//         padding: const EdgeInsets.all(16),
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(20),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black.withOpacity(0.08),
//               blurRadius: 20,
//               offset: const Offset(0, 10),
//             ),
//           ],
//         ),
//         child: Column(
//           children: [
//             Row(
//               children: [
//                 Hero(
//                   tag: worker.id,
//                   child: CircleAvatar(
//                     radius: 30,
//                     backgroundImage: worker.photoUrl.isNotEmpty
//                         ? NetworkImage(worker.photoUrl)
//                         : null,
//                     child: worker.photoUrl.isEmpty
//                         ? const Icon(Icons.person)
//                         : null,
//                   ),
//                 ),
//                 const SizedBox(width: 14),
//                 Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         worker.name,
//                         style: const TextStyle(
//                           fontSize: 16,
//                           fontWeight: FontWeight.w800,
//                         ),
//                       ),
//                       const SizedBox(height: 4),
//                       Text(
//                         '${worker.skill} • ${worker.experience}',
//                         style: const TextStyle(color: Colors.black54),
//                       ),
//                       const SizedBox(height: 4),
//                       Text(
//                         '₹${worker.chargePerDay}/day • ${worker.location}',
//                         style: const TextStyle(
//                           color: Color(0xFF2563EB),
//                           fontWeight: FontWeight.w600,
//                         ),
//                       ),
//                       const SizedBox(height: 6),
//                       Row(
//                         children: [
//                           const Icon(Icons.star, size: 16, color: Colors.amber),
//                           const SizedBox(width: 4),
//                           Text(
//                             worker.averageRating.toStringAsFixed(1),
//                             style: const TextStyle(fontWeight: FontWeight.bold),
//                           ),
//                           const SizedBox(width: 6),
//                           Text(
//                             "(${worker.totalReviews})",
//                             style: const TextStyle(color: Colors.grey),
//                           ),
//                         ],
//                       ),

//                       // Row(
//                       //   children: [
//                       //     const Icon(Icons.star, size: 16, color: Colors.amber),
//                       //     const SizedBox(width: 4),
//                       //     Text(
//                       //       worker.averageRating.toStringAsFixed(1),
//                       //       style: const TextStyle(fontWeight: FontWeight.bold),
//                       //     ),
//                       //     const SizedBox(width: 6),
//                       //     Text(
//                       //       "(${worker.totalReviews})",
//                       //       style: const TextStyle(color: Colors.grey),
//                       //     ),
//                       //   ],
//                       // ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 16),
//             Row(
//               children: [
//                 Expanded(
//                   child: _ActionButton(
//                     icon: Icons.call,
//                     label: 'Call',
//                     color: Colors.green,
//                     onTap: () async {
//                       final url = Uri.parse('tel:${worker.phone}');
//                       if (await canLaunchUrl(url)) {
//                         launchUrl(url);
//                       }
//                     },
//                   ),
//                 ),
//                 const SizedBox(width: 12),
//                 Expanded(
//                   child: _ActionButton(
//                     icon: Icons.chat,
//                     label: 'WhatsApp',
//                     color: Colors.teal,
//                     onTap: () async {
//                       final url = Uri.parse('https://wa.me/${worker.whatsapp}');
//                       if (await canLaunchUrl(url)) {
//                         launchUrl(url);
//                       }
//                     },
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
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

              /// 📍 Location
              const Text("Location"),
              const SizedBox(height: 10),
              Obx(() {
                return Wrap(
                  spacing: 10,
                  children: controller.getLocations().map((loc) {
                    return ChoiceChip(
                      label: Text(loc),
                      selected: controller.selectedLocation.value == loc,
                      onSelected: (_) => controller.setLocation(loc),
                    );
                  }).toList(),
                );
              }),

              const SizedBox(height: 20),

              /// ↕️ Sort
              const Text("Sort By"),
              const SizedBox(height: 10),

              _sortTile("Name", SortType.name, controller),
              _sortTile("Price: Low → High", SortType.priceLowHigh, controller),
              _sortTile("Price: High → Low", SortType.priceHighLow, controller),
              _sortTile("Experience", SortType.experience, controller),

              const SizedBox(height: 24),

              /// 🔘 Buttons
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        controller.resetFilters();
                        Get.back(); // close sheet
                      },
                      child: const Text("Reset"),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        controller.applyFilters();
                        Get.back(); // close sheet
                      },
                      child: const Text("Apply"),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      isScrollControlled: true,
    );
  }

  // void _openFilterSheet(
  //   BuildContext context,
  //   ServiceHomeController controller,
  // ) {
  //   Get.bottomSheet(
  //     Container(
  //       padding: const EdgeInsets.all(20),
  //       decoration: const BoxDecoration(
  //         color: Colors.white,
  //         borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
  //       ),
  //       child: SingleChildScrollView(
  //         child: Column(
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           children: [
  //             const Text(
  //               "Filters",
  //               style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
  //             ),
  //             const SizedBox(height: 20),

  //             const Text("Location"),
  //             const SizedBox(height: 10),
  //             Wrap(
  //               spacing: 10,
  //               children: controller.getLocations().map((loc) {
  //                 return ChoiceChip(
  //                   label: Text(loc),
  //                   selected: controller.selectedLocation.value == loc,
  //                   onSelected: (_) => controller.setLocation(loc),
  //                 );
  //               }).toList(),
  //             ),

  //             const SizedBox(height: 20),
  //             const Text("Sort By"),
  //             const SizedBox(height: 10),

  //             _sortTile("Name", SortType.name, controller),
  //             _sortTile("Price: Low → High", SortType.priceLowHigh, controller),
  //             _sortTile("Price: High → Low", SortType.priceHighLow, controller),
  //             _sortTile("Experience", SortType.experience, controller),

  //             const SizedBox(height: 20),

  //             SizedBox(
  //               width: double.infinity,
  //               child: OutlinedButton(
  //                 onPressed: controller.resetFilters,
  //                 child: const Text("Reset Filters"),
  //               ),
  //             ),
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  // }

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
                        // Row(
                        //   children: [
                        //     const Icon(
                        //       Icons.star,
                        //       color: Colors.amber,
                        //       size: 18,
                        //     ),
                        //     const SizedBox(width: 4),
                        //     Text(
                        //       worker.averageRating.toStringAsFixed(1),
                        //       style: const TextStyle(
                        //         fontWeight: FontWeight.w700,
                        //       ),
                        //     ),
                        //     const SizedBox(width: 6),
                        //     Text(
                        //       '(${worker.totalReviews} reviews)',
                        //       style: const TextStyle(
                        //         color: Colors.black54,
                        //         fontSize: 12,
                        //       ),
                        //     ),
                        //   ],
                        // ),
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

import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:jobportal/controller/profile_image_controller.dart';
import 'package:jobportal/features/profile/edit_profile.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    /// ✅ Inject controller ONCE (very important)
    Get.put(ProfileImageController(), permanent: true);

    final user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFF7FAFF), Color(0xFFEFF4FF)],
          ),
        ),
        child: SafeArea(
          child: user == null
              ? const _LoggedOutView()
              : _ProfileView(uid: user.uid),
        ),
      ),
    );
  }
}

////////////////////////////////////////////////////////////////////////////////
/// 🔓 LOGGED OUT VIEW
////////////////////////////////////////////////////////////////////////////////

class _LoggedOutView extends StatelessWidget {
  const _LoggedOutView();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.person_outline, size: 90, color: Colors.grey),
          const SizedBox(height: 16),
          const Text(
            'You are not logged in',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 22),
          ElevatedButton(
            onPressed: () => Get.toNamed('/login'),
            child: const Text('Login'),
          ),
        ],
      ),
    );
  }
}

////////////////////////////////////////////////////////////////////////////////
/// 👤 PROFILE VIEW
////////////////////////////////////////////////////////////////////////////////

class _ProfileView extends StatelessWidget {
  final String uid;

  const _ProfileView({required this.uid});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
      stream: FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .snapshots(),
      builder: (context, snapshot) {
        /// ⏳ LOADING
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        /// ❌ NO DATA
        if (!snapshot.hasData || snapshot.data!.data() == null) {
          return const Center(child: Text('Profile not found'));
        }

        final data = snapshot.data!.data()!;
        final completion = calculateProfileCompletion(data);

        return SingleChildScrollView(
          padding: const EdgeInsets.all(22),
          child: Column(
            children: [
              /// 🖼 PROFILE IMAGE
              _ProfileAvatar(photoUrl: data['photoUrl']),
              const SizedBox(height: 18),

              /// 👤 NAME
              Text(
                data['fullName'] ?? 'User',
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w900,
                ),
              ),

              const SizedBox(height: 6),

              /// 📧 EMAIL
              Text(
                data['email'] ?? '',
                style: const TextStyle(color: Colors.grey),
              ),

              const SizedBox(height: 22),

              /// 📊 PROFILE COMPLETION
              ProfileCompletionCard(percent: completion),

              const SizedBox(height: 24),

              /// ✏️ EDIT PROFILE
              SizedBox(
                width: 180,
                height: 44,
                child: OutlinedButton.icon(
                  onPressed: () {
                    Get.to(
                      () => EditProfileScreen(
                        uid: uid,
                        initialData: Map<String, dynamic>.from(data),
                      ),
                    );
                  },
                  icon: const Icon(Icons.edit, size: 18),
                  label: const Text(
                    'Edit Profile',
                    style: TextStyle(fontWeight: FontWeight.w700),
                  ),
                  style: OutlinedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 32),

              /// 🚪 LOGOUT
              SizedBox(
                width: double.infinity,
                height: 50,
                child: OutlinedButton(
                  onPressed: () async {
                    await FirebaseAuth.instance.signOut();
                    Get.offAllNamed('/login');
                  },
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.red,
                    side: const BorderSide(color: Colors.red),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: const Text(
                    'Logout',
                    style: TextStyle(fontWeight: FontWeight.w700),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

int calculateProfileCompletion(Map<String, dynamic> data) {
  final requiredFields = [
    'fullName',
    'email',
    'phone',
    'gender',
    'age',
    'address',
    'educationQualification',
    'experienceType',
    'state',
    'district',
    'photoUrl',
  ];

  int filled = 0;

  for (final field in requiredFields) {
    final value = data[field];
    if (value != null && value.toString().trim().isNotEmpty) {
      filled++;
    }
  }

  return ((filled / requiredFields.length) * 100).round();
}

class ProfileCompletionCard extends StatelessWidget {
  final int percent;

  const ProfileCompletionCard({super.key, required this.percent});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22),
        gradient: const LinearGradient(
          colors: [Color(0xFFEFF6FF), Color(0xFFDBEAFE)],
        ),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.08), blurRadius: 24),
        ],
      ),
      child: Row(
        children: [
          /// 🔵 PROGRESS RING
          SizedBox(
            height: 64,
            width: 64,
            child: Stack(
              alignment: Alignment.center,
              children: [
                CircularProgressIndicator(
                  value: percent / 100,
                  strokeWidth: 6,
                  backgroundColor: Colors.blue.shade100,
                  valueColor: const AlwaysStoppedAnimation(Color(0xFF2563EB)),
                ),
                Text(
                  '$percent%',
                  style: const TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(width: 18),

          /// 📊 TEXT
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Profile Completion',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800),
                ),
                const SizedBox(height: 6),
                Text(
                  percent == 100
                      ? 'Your profile is complete 🎉'
                      : 'Complete your profile to apply faster',
                  style: const TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ProfileAvatar extends StatelessWidget {
  final String? photoUrl;
  const _ProfileAvatar({this.photoUrl});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ProfileImageController>();

    return Obx(() {
      return Stack(
        alignment: Alignment.center,
        children: [
          /// 🔵 UPLOAD PROGRESS RING
          if (controller.isUploading.value)
            SizedBox(
              height: 124,
              width: 124,
              child: CircularProgressIndicator(
                value: controller.uploadProgress.value,
                strokeWidth: 6,
                backgroundColor: Colors.blue.shade100,
                valueColor: const AlwaysStoppedAnimation(Color(0xFF2563EB)),
              ),
            ),

          /// 👤 AVATAR
          Container(
            height: 110,
            width: 110,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: const LinearGradient(
                colors: [Color(0xFF60A5FA), Color(0xFF2563EB)],
              ),
              boxShadow: [
                BoxShadow(color: Colors.blue.withOpacity(0.35), blurRadius: 30),
              ],
            ),
            child: CircleAvatar(
              radius: 52,
              backgroundColor: Colors.white,
              backgroundImage: (photoUrl != null && photoUrl!.isNotEmpty)
                  ? NetworkImage(photoUrl!)
                  : null,
              child: (photoUrl == null || photoUrl!.isEmpty)
                  ? const Icon(Icons.person, size: 54, color: Colors.grey)
                  : null,
            ),
          ),

          /// ✏️ EDIT BUTTON (ONLY WHEN NOT UPLOADING)
          if (!controller.isUploading.value)
            Positioned(
              bottom: 6,
              right: 6,
              child: GestureDetector(
                onTap: () => _showAvatarOptions(context, controller, photoUrl),
                child: Container(
                  height: 32,
                  width: 32,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.blue.withOpacity(0.4),
                        blurRadius: 12,
                      ),
                    ],
                  ),
                  child: const Icon(Icons.edit, size: 16, color: Colors.white),
                ),
              ),
            ),
        ],
      );
    });
  }
}

//   /// 🧩 OPTIONS SHEET
//   void _showAvatarOptions(
//     BuildContext context,
//     ProfileImageController controller,
//   ) {
//     showModalBottomSheet(
//       context: context,
//       shape: const RoundedRectangleBorder(
//         borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
//       ),
//       builder: (_) => Padding(
//         padding: const EdgeInsets.all(22),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             ListTile(
//               leading: const Icon(Icons.photo_library),
//               title: const Text('Change photo'),
//               onTap: () {
//                 Navigator.pop(context);
//                 controller.pickAndUploadImage();
//               },
//             ),
//             if (photoUrl != null && photoUrl!.isNotEmpty)
//               ListTile(
//                 leading: const Icon(Icons.delete, color: Colors.red),
//                 title: const Text(
//                   'Delete photo',
//                   style: TextStyle(color: Colors.red),
//                 ),
//                 onTap: () {
//                   Navigator.pop(context);
//                   controller.deleteProfileImage();
//                 },
//               ),
//           ],
//         ),
//       ),
//     );
//   }
// }
void _showAvatarOptions(
  BuildContext context,
  ProfileImageController controller,
  String? photoUrl,
) {
  showModalBottomSheet(
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (_) {
      return SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text('Change photo'),
              onTap: () {
                Navigator.pop(context);
                controller.pickAndUploadImage();
              },
            ),
            if (photoUrl != null && photoUrl.isNotEmpty)
              ListTile(
                leading: const Icon(Icons.delete, color: Colors.red),
                title: const Text(
                  'Remove photo',
                  style: TextStyle(color: Colors.red),
                ),
                onTap: () {
                  Navigator.pop(context);
                  _confirmDeleteAvatar(context, controller);
                },
              ),
          ],
        ),
      );
    },
  );
}

// void _confirmDeleteImage(
//   BuildContext context,
//   ProfileImageController controller,
// ) {
//   Get.dialog(
//     AlertDialog(
//       title: const Text('Remove Profile Photo'),
//       content: const Text(
//         'Are you sure you want to delete your profile image?',
//       ),
//       actions: [
//         TextButton(
//           onPressed: Get.back,
//           child: const Text('Cancel'),
//         ),
//         TextButton(
//           onPressed: () async {
//             Get.back();
//             await controller.deleteProfileImage();
//           },
//           child: const Text(
//             'Delete',
//             style: TextStyle(color: Colors.red),
//           ),
//         ),
//       ],
//     ),
//   );
// }
void _confirmDeleteAvatar(
  BuildContext context,
  ProfileImageController controller,
) {
  Get.dialog(
    AlertDialog(
      title: const Text('Remove Profile Photo'),
      content: const Text(
        'Are you sure you want to delete your profile image?',
      ),
      actions: [
        TextButton(onPressed: Get.back, child: const Text('Cancel')),
        TextButton(
          onPressed: () async {
            Get.back();
            await controller.deleteProfileImage();
          },
          child: const Text('Delete', style: TextStyle(color: Colors.red)),
        ),
      ],
    ),
  );
}

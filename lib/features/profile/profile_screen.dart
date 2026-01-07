// import 'package:flutter/material.dart';

// class ProfileScreen extends StatelessWidget {
//   const ProfileScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Column(
//         children: [
//           /// PROFILE HEADER
//           Container(
//             padding: const EdgeInsets.all(20),
//             decoration: BoxDecoration(
//               color: Colors.blue.shade50,
//               borderRadius: const BorderRadius.only(
//                 bottomLeft: Radius.circular(28),
//                 bottomRight: Radius.circular(28),
//               ),
//             ),
//             child: Row(
//               children: [
//                 CircleAvatar(
//                   radius: 32,
//                   backgroundColor: Colors.blue.shade200,
//                   child: const Icon(
//                     Icons.person,
//                     size: 36,
//                     color: Colors.white,
//                   ),
//                 ),
//                 const SizedBox(width: 16),
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: const [
//                     Text(
//                       'Job Seeker',
//                       style: TextStyle(
//                         fontSize: 18,
//                         fontWeight: FontWeight.w700,
//                       ),
//                     ),
//                     SizedBox(height: 4),
//                     Text(
//                       'View & manage your profile',
//                       style: TextStyle(color: Colors.grey),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),

//           const SizedBox(height: 20),

//           /// PROFILE OPTIONS
//           _profileTile(
//             icon: Icons.person_outline,
//             title: 'Edit Profile',
//             onTap: () {},
//           ),
//           _profileTile(
//             icon: Icons.work_outline,
//             title: 'My Applications',
//             onTap: () {},
//           ),
//           _profileTile(
//             icon: Icons.settings_outlined,
//             title: 'Settings',
//             onTap: () {},
//           ),
//           _profileTile(
//             icon: Icons.help_outline,
//             title: 'Help & Support',
//             onTap: () {},
//           ),

//           const Spacer(),

//           /// LOGOUT
//           Padding(
//             padding: const EdgeInsets.all(16),
//             child: SizedBox(
//               width: double.infinity,
//               height: 46,
//               child: OutlinedButton(
//                 style: OutlinedButton.styleFrom(
//                   foregroundColor: Colors.red,
//                   side: const BorderSide(color: Colors.red),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(14),
//                   ),
//                 ),
//                 onPressed: () {
//                   // FirebaseAuth.instance.signOut();
//                   // Get.offAllNamed('/login');
//                 },
//                 child: const Text(
//                   'Logout',
//                   style: TextStyle(fontWeight: FontWeight.w600),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   static Widget _profileTile({
//     required IconData icon,
//     required String title,
//     required VoidCallback onTap,
//   }) {
//     return ListTile(
//       leading: Icon(icon, color: Colors.blue),
//       title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
//       trailing: const Icon(Icons.chevron_right),
//       onTap: onTap,
//     );
//   }
// }
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
          child: user == null ? _LoggedOutView() : _ProfileView(uid: user.uid),
        ),
      ),
    );
  }
}

////////////////////////////////////////////////////////////////////////////////
/// 🔓 LOGGED OUT VIEW
////////////////////////////////////////////////////////////////////////////////

class _LoggedOutView extends StatelessWidget {
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
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
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
    return StreamBuilder<DocumentSnapshot>(
      stream: FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }

        final data = snapshot.data!.data() as Map<String, dynamic>? ?? {};

        return SingleChildScrollView(
          padding: const EdgeInsets.all(22),
          child: Column(
            children: [
              /// PROFILE IMAGE
              _ProfileAvatar(),

              const SizedBox(height: 18),

              /// NAME
              Text(
                data['fullName'] ?? 'User',
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w900,
                ),
              ),

              const SizedBox(height: 6),

              Text(
                data['email'] ?? '',
                style: const TextStyle(color: Colors.grey),
              ),

              const SizedBox(height: 26),

              /// PERSONAL INFO CARD
              _GlassCard(
                title: 'Personal Details',
                children: [
                  _info('Phone', data['phone']),
                  _info('Gender', data['gender']),
                  _info('Age', data['age']?.toString()),
                  _info('Address', data['address']),
                ],
              ),

              const SizedBox(height: 18),

              /// EDUCATION & EXPERIENCE
              _GlassCard(
                title: 'Education & Experience',
                children: [
                  _info('Qualification', data['educationQualification']),
                  _info('Experience', data['experienceType']),
                  if (data['experienceType'] == 'experienced')
                    _info('Years', data['experienceDetails']?['years']),
                ],
              ),

              const SizedBox(height: 18),

              /// LOCATION
              _GlassCard(
                title: 'Location',
                children: [
                  _info('State', data['state']),
                  _info('District', data['district']),
                ],
              ),

              const SizedBox(height: 30),

              /// LOGOUT
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

  Widget _info(String label, String? value) {
    if (value == null || value.isEmpty) return const SizedBox();
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Text(label, style: const TextStyle(color: Colors.grey)),
          ),
          Expanded(
            flex: 5,
            child: Text(
              value,
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }
}

////////////////////////////////////////////////////////////////////////////////
/// 🖼 PROFILE AVATAR
////////////////////////////////////////////////////////////////////////////////

class _ProfileAvatar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
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
          child: const CircleAvatar(
            radius: 52,
            backgroundColor: Colors.white,
            child: Icon(Icons.person, size: 54, color: Colors.grey),
          ),
        ),
        Positioned(
          bottom: 6,
          right: 6,
          child: Container(
            height: 32,
            width: 32,
            decoration: BoxDecoration(
              color: Colors.blue,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(color: Colors.blue.withOpacity(0.4), blurRadius: 12),
              ],
            ),
            child: const Icon(Icons.edit, size: 16, color: Colors.white),
          ),
        ),
      ],
    );
  }
}

////////////////////////////////////////////////////////////////////////////////
/// 🧊 GLASS CARD
////////////////////////////////////////////////////////////////////////////////

class _GlassCard extends StatelessWidget {
  final String title;
  final List<Widget> children;

  const _GlassCard({required this.title, required this.children});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(22),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 14, sigmaY: 14),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.7),
            borderRadius: BorderRadius.circular(22),
            boxShadow: [
              BoxShadow(color: Colors.black.withOpacity(0.08), blurRadius: 24),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 14),
              ...children,
            ],
          ),
        ),
      ),
    );
  }
}

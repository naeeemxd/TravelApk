import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Firebase Auth
import 'package:tripvs/OnboardingScreen.dart'; // Onboarding screen for navigation
import 'package:tripvs/profileEdit.dart'; // Profile edit screen for updating profile

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ProfilePage(),
    );
  }
}

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  // Logout function
  Future<void> _logout(BuildContext context) async {
    // Log out from Firebase
    await FirebaseAuth.instance.signOut();

    // Navigate to the onboarding screen after logout
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const OnboardingScreen()),
      (route) => false, // Remove all previous routes
    );
  }

  @override
  Widget build(BuildContext context) {
    final User? user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return StreamBuilder<DocumentSnapshot>(
      stream: FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (!snapshot.hasData || snapshot.data == null) {
          return const Scaffold(
            body: Center(child: Text('No user data found')),
          );
        }

        // Retrieve user data
        var userData = snapshot.data!.data() as Map<String, dynamic>;
        String? photoURL = userData['photoURL'];

        return Scaffold(
          backgroundColor: Colors.grey[200],
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            centerTitle: true,
            title: const Text(
              'Profile',
              style: TextStyle(color: Colors.black),
            ),
            actions: [
              // Edit profile button
              IconButton(
                icon: const Icon(Icons.edit, color: Colors.black),
                onPressed: () {
                  // Navigate to the profile edit screen
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ProfileEdit()),
                  );
                },
              ),
            ],
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 20),
                // Profile picture with fallback image
                CircleAvatar(
                  radius: 50,
                  backgroundImage: photoURL != null
                      ? NetworkImage(photoURL)
                      : const NetworkImage(
                          "https://i.postimg.cc/hvCvRj8p/th.jpg"),
                  backgroundColor: Colors.orange[100],
                ),
                const SizedBox(height: 10),
                // Name and email from Firestore
                Text(
                  userData['name'] ?? user.displayName ?? 'User',
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Text(
                  userData['email'] ?? user.email ?? 'user@example.com',
                  style: const TextStyle(fontSize: 16, color: Colors.grey),
                ),
                const SizedBox(height: 20),
                // Stats cards section
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildStatCard('Reward Points', '360'),
                      _buildStatCard('Travel Trips', '238'),
                      _buildStatCard('Bucket List', '473'),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                // Options list with various features (e.g., Profile, Bookmarked, Log out)
                _buildOption(Icons.person, 'Profile', () {}),
                _buildOption(Icons.bookmark, 'Bookmarked', () {}),
                _buildOption(Icons.history, 'Previous Trips', () {}),
                _buildOption(Icons.logout, 'Log out', () => _logout(context)),
                _buildOption(Icons.info, 'Version', () {}),
              ],
            ),
          ),
        );
      },
    );
  }

  // Widget to build stat cards (Reward Points, Travel Trips, etc.)
  Widget _buildStatCard(String title, String value) {
    return Expanded(
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Text(
                value,
                style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.orange),
              ),
              const SizedBox(height: 5),
              Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 14, color: Colors.grey),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Widget to build options (Profile, Bookmarked, Logout, etc.)
  Widget _buildOption(IconData icon, String title, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: Colors.black),
      title: Text(title),
      trailing: const Icon(Icons.arrow_forward_ios, color: Colors.grey),
      onTap: onTap,
    );
  }
}

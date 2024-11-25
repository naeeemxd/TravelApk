import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tripvs/calander.dart';
import 'package:tripvs/popularpackages.dart';
import 'package:tripvs/profile.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const ExploreScreen(),
    const ScheduleScreen(),
    const PopularPackagesScreen(),
    const ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.calendar),
            label: "Schedule",
          ),
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.search),
            label: "Search",
          ),
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.user),
            label: "Profile",
          ),
        ],
      ),
    );
  }
}

// Firestore Service
class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<List<Map<String, dynamic>>> fetchCollection(String collection) async {
    try {
      final QuerySnapshot snapshot = await _db.collection(collection).get();
      return snapshot.docs
          .map((doc) => doc.data() as Map<String, dynamic>)
          .toList();
    } catch (e) {
      print("Error fetching collection: $e");
      return [];
    }
  }
}

// Explore Screen
class ExploreScreen extends StatelessWidget {
  const ExploreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: const Padding(
          padding: EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundImage: NetworkImage(
              'https://i.postimg.cc/hvCvRj8p/th.jpg',
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(FontAwesomeIcons.bell, color: Colors.black),
            onPressed: () {
              // Navigate to notifications
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Explore the",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w400),
              ),
              RichText(
                text: const TextSpan(
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                  children: [
                    TextSpan(
                      text: "Beautiful ",
                      style: TextStyle(color: Colors.black),
                    ),
                    TextSpan(
                      text: "world!",
                      style: TextStyle(color: Colors.orange),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                "Best Destination",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 16),
              BestDestinationSection(),
              const SizedBox(height: 25),
              const Text(
                "Special Trip Offers!",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 16),
              SpecialTripOffersSection(),
            ],
          ),
        ),
      ),
    );
  }
}

// Best Destination Section
// Best Destination Section
class BestDestinationSection extends StatelessWidget {
  final FirestoreService firestoreService = FirestoreService();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: firestoreService.fetchCollection('destinations'),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return const Center(child: Text('Error loading destinations'));
        }
        if (snapshot.data == null || snapshot.data!.isEmpty) {
          return const Center(child: Text('No destinations available.'));
        }
        final destinations = snapshot.data!;
        return SizedBox(
          height: 200,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: destinations.length,
            itemBuilder: (context, index) {
              final destination = destinations[index];
              return DestinationCard(
                title: destination['title'] ?? 'Unknown',
                subtitle: destination['subtitle'] ?? 'Unknown',
                rating: (destination['rating'] as num?)?.toDouble() ?? 0.0,
                imageUrl: destination['imageUrl'] ??
                    'https://via.placeholder.com/150',
                details: destination['details'] ?? 'No information available.',
              );
            },
          ),
        );
      },
    );
  }
}

// Special Trip Offers Section
class SpecialTripOffersSection extends StatelessWidget {
  final FirestoreService firestoreService = FirestoreService();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: firestoreService.fetchCollection('special_trip_offers'),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return const Center(child: Text('Error loading offers'));
        }
        if (snapshot.data == null || snapshot.data!.isEmpty) {
          return const Center(child: Text('No special offers available.'));
        }
        final offers = snapshot.data!;
        return SizedBox(
          height: 240,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: offers.length,
            itemBuilder: (context, index) {
              final offer = offers[index];
              return TripPackageAd(
                title: offer['title'] ?? 'Unknown',
                subtitle: offer['subtitle'] ?? 'Unknown',
                price: (offer['price'] as num?)?.toDouble() ?? 0.0,
                imageUrl:
                    offer['imageUrl'] ?? 'https://via.placeholder.com/150',
                details: offer['details'] ?? 'No information available.',
              );
            },
          ),
        );
      },
    );
  }
}

// Reusable Widgets for Cards and Ads
class DestinationCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final double rating;
  final String imageUrl;
  final String details;

  const DestinationCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.rating,
    required this.imageUrl,
    required this.details,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DestinationDetails(
              title: title,
              subtitle: subtitle,
              rating: rating,
              imageUrl: imageUrl,
              details: details,
            ),
          ),
        );
      },
      child: Container(
        width: 180,
        margin: const EdgeInsets.only(right: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              blurRadius: 10,
              spreadRadius: 1,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(16)),
              child: Image.network(
                imageUrl,
                height: 120,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      )),
                  Text(subtitle,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                      )),
                  Row(
                    children: [
                      Icon(
                        Icons.star,
                        color: Colors.orange[700],
                        size: 16,
                      ),
                      Text(
                        '$rating',
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.orange,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Trip Package Ad Widget
class TripPackageAd extends StatelessWidget {
  final String title;
  final String subtitle;
  final double price;
  final String imageUrl;
  final String details;

  const TripPackageAd({
    super.key,
    required this.title,
    required this.subtitle,
    required this.price,
    required this.imageUrl,
    required this.details,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => TripDetails(
              title: title,
              subtitle: subtitle,
              price: price,
              imageUrl: imageUrl,
              details: details,
            ),
          ),
        );
      },
      child: Container(
        width: 220,
        margin: const EdgeInsets.only(right: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              blurRadius: 10,
              spreadRadius: 1,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(16)),
              child: Image.network(
                imageUrl,
                height: 140,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      )),
                  Text(subtitle,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                      )),
                  Text('\$${price.toStringAsFixed(2)}',
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// DestinationDetails & TripDetails remain the same as before, just make sure to use 'details' field wherever necessary.

class DestinationDetails extends StatelessWidget {
  final String title;
  final String subtitle;
  final double rating;
  final String imageUrl;
  final String details;

  const DestinationDetails({
    super.key,
    required this.title,
    required this.subtitle,
    required this.rating,
    required this.imageUrl,
    required this.details,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.network(imageUrl),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(subtitle, style: const TextStyle(fontSize: 16)),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(
                        Icons.star,
                        color: Colors.orange,
                        size: 24,
                      ),
                      Text(
                        '$rating',
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.orange,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    details,
                    style: const TextStyle(fontSize: 14),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TripDetails extends StatelessWidget {
  final String title;
  final String subtitle;
  final double price;
  final String imageUrl;
  final String details;

  const TripDetails({
    super.key,
    required this.title,
    required this.subtitle,
    required this.price,
    required this.imageUrl,
    required this.details,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.network(imageUrl),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(subtitle, style: const TextStyle(fontSize: 16)),
                  const SizedBox(height: 8),
                  Text(
                    '\$$price',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    details,
                    style: const TextStyle(fontSize: 14),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

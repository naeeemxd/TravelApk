import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Travel App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const PopularPackagesScreen(),
    );
  }
}

class PopularPackagesScreen extends StatefulWidget {
  const PopularPackagesScreen({Key? key}) : super(key: key);

  @override
  State<PopularPackagesScreen> createState() => _PopularPackagesScreenState();
}

class _PopularPackagesScreenState extends State<PopularPackagesScreen> {
  @override
  void initState() {
    super.initState();
    _debugFirestoreData(); // Debugging function added here
  }

  Future<void> _debugFirestoreData() async {
    try {
      // Fetch all documents from the `destinations` collection
      final snapshot =
          await FirebaseFirestore.instance.collection('packagess').get();

      if (snapshot.docs.isEmpty) {
        print('Firestore: No documents found in the `packages` collection.');
      } else {
        print('Firestore: packages retrieved successfully:');
        for (var doc in snapshot.docs) {
          print(doc.data());
        }
      }
    } catch (e) {
      print('Error accessing Firestore: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Popular Packages',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "All Popular Trip Packages",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Expanded(
                child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('packagess')
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  print("Error fetching packages: ${snapshot.error}");
                  return const Center(child: Text("Error loading packages"));
                }
                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  print("No data found in 'packages' collection");
                  return const Center(child: Text("No packages found"));
                }

                final packages = snapshot.data!.docs;
                packages.forEach((doc) {
                  print(
                      "Package Data: ${doc.data()}"); // Print package data for debugging
                });

                return ListView.builder(
                  itemCount: packages.length,
                  itemBuilder: (context, index) {
                    final package = packages[index];
                    return _PackageCard(
                      imageUrl: package['imageUrl'] ?? "Unknown",
                      title: package['title'] ?? "Unknown",
                      date: package['date'] ?? "Unknown",
                      rating: (package['rating'] ?? 0.0).toDouble(),
                      persons: package['persons'] ?? 0,
                      price: package['price'] ?? 0,
                    );
                  },
                );
              },
            )),
          ],
        ),
      ),
    );
  }
}

class _PackageCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String date;
  final double rating;
  final int persons;
  final int price;

  const _PackageCard({
    Key? key,
    required this.imageUrl,
    required this.title,
    required this.date,
    required this.rating,
    required this.persons,
    required this.price,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 3,
      child: Row(
        children: [
          ClipRRect(
            borderRadius:
                const BorderRadius.horizontal(left: Radius.circular(16)),
            child: Image.network(
              imageUrl,
              width: 100,
              height: 100,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(
                width: 100,
                height: 100,
                color: Colors.grey,
                child: const Icon(Icons.broken_image),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    date,
                    style: const TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(Icons.star, size: 16, color: Colors.orange),
                      Text(
                        rating.toString(),
                        style: const TextStyle(fontSize: 12),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        "$persons Persons Joined",
                        style:
                            const TextStyle(color: Colors.grey, fontSize: 12),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            decoration: BoxDecoration(
              color: Colors.orange,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Text(
              "\$$price",
              style: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}

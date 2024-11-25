import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({super.key});

  @override
  _AdminPageState createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Controllers for Destinations
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _subtitleController = TextEditingController();
  final TextEditingController _imageUrlController = TextEditingController();
  final TextEditingController _ratingController = TextEditingController();
  final TextEditingController _aboutController = TextEditingController();
  final TextEditingController _priceController =
      TextEditingController(); // Price Controller

  // Controllers for Special Trip Offers
  final TextEditingController _tripTitleController = TextEditingController();
  final TextEditingController _tripSubtitleController = TextEditingController();
  final TextEditingController _tripImageUrlController = TextEditingController();
  final TextEditingController _tripDetailsController = TextEditingController();
  final TextEditingController _tripPriceController =
      TextEditingController(); // Price Controller
  final TextEditingController _tripRatingController =
      TextEditingController(); // Rating Controller

  String? _errorMessage;

  // Add a new destination
  Future<void> _addDestination() async {
    setState(() {
      _errorMessage = null; // Clear previous error messages
    });

    if (_titleController.text.isEmpty ||
        _subtitleController.text.isEmpty ||
        _imageUrlController.text.isEmpty ||
        _ratingController.text.isEmpty ||
        _aboutController.text.isEmpty ||
        _priceController.text.isEmpty) {
      // Check for price
      setState(() {
        _errorMessage = "All fields are required.";
      });
      return;
    }

    final rating = double.tryParse(_ratingController.text);
    final price = double.tryParse(_priceController.text); // Parse price
    if (rating == null || rating < 0 || rating > 5) {
      setState(() {
        _errorMessage = "Rating must be a number between 0 and 5.";
      });
      return;
    }

    if (price == null || price < 0) {
      setState(() {
        _errorMessage = "Price must be a valid number greater than 0.";
      });
      return;
    }

    await _db.collection('destinations').add({
      'title': _titleController.text,
      'subtitle': _subtitleController.text,
      'imageUrl': _imageUrlController.text,
      'rating': rating,
      'about': _aboutController.text,
      'price': price, // Store price
    });

    _titleController.clear();
    _subtitleController.clear();
    _imageUrlController.clear();
    _ratingController.clear();
    _aboutController.clear();
    _priceController.clear(); // Clear price
    Navigator.of(context).pop();
  }

  // Add a new special trip offer
  Future<void> _addSpecialTripOffer() async {
    setState(() {
      _errorMessage = null;
    });

    if (_tripTitleController.text.isEmpty ||
        _tripSubtitleController.text.isEmpty ||
        _tripImageUrlController.text.isEmpty ||
        _tripDetailsController.text.isEmpty ||
        _tripPriceController.text.isEmpty ||
        _tripRatingController.text.isEmpty) {
      // Add validation for price and rating
      setState(() {
        _errorMessage = "All fields are required.";
      });
      return;
    }

    final rating = double.tryParse(_tripRatingController.text);
    final price = double.tryParse(_tripPriceController.text); // Parse price
    if (rating == null || rating < 0 || rating > 5) {
      setState(() {
        _errorMessage = "Rating must be a number between 0 and 5.";
      });
      return;
    }

    if (price == null || price < 0) {
      setState(() {
        _errorMessage = "Price must be a valid number greater than 0.";
      });
      return;
    }

    await _db.collection('special_trip_offers').add({
      'title': _tripTitleController.text,
      'subtitle': _tripSubtitleController.text,
      'imageUrl': _tripImageUrlController.text,
      'details': _tripDetailsController.text,
      'price': price, // Store price
      'rating': rating, // Store rating
    });

    _tripTitleController.clear();
    _tripSubtitleController.clear();
    _tripImageUrlController.clear();
    _tripDetailsController.clear();
    _tripPriceController.clear(); // Clear price
    _tripRatingController.clear(); // Clear rating
    Navigator.of(context).pop();
  }

  // Delete a destination
  Future<void> _deleteDestination(String id) async {
    await _db.collection('destinations').doc(id).delete();
  }

  // Delete a special trip offer
  Future<void> _deleteSpecialTripOffer(String id) async {
    await _db.collection('special_trip_offers').doc(id).delete();
  }

  // Show Add Special Trip Offer Dialog
  void _showAddSpecialTripOfferDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add Special Trip Offer'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: _tripTitleController,
                  decoration: const InputDecoration(labelText: 'Trip Title'),
                ),
                TextField(
                  controller: _tripSubtitleController,
                  decoration: const InputDecoration(labelText: 'Trip Subtitle'),
                ),
                TextField(
                  controller: _tripImageUrlController,
                  decoration: const InputDecoration(labelText: 'Image URL'),
                ),
                TextField(
                  controller: _tripDetailsController,
                  decoration: const InputDecoration(labelText: 'Details'),
                ),
                TextField(
                  controller: _tripPriceController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(labelText: 'Price'),
                ),
                TextField(
                  controller: _tripRatingController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(labelText: 'Rating (0-5)'),
                ),
                if (_errorMessage != null)
                  Text(
                    _errorMessage!,
                    style: const TextStyle(
                        color: Colors.red, fontWeight: FontWeight.bold),
                  ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: _addSpecialTripOffer,
              child: const Text('Add Trip Offer'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Admin Panel')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ElevatedButton(
              onPressed: _showAddDestinationDialog,
              child: const Text('Add Destination'),
            ),
            ElevatedButton(
              onPressed: _showAddSpecialTripOfferDialog,
              child: const Text('Add Special Trip Offer'),
            ),
            const SizedBox(height: 32),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: _db.collection('destinations').snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasError) {
                    return const Center(
                        child: Text('Error loading destinations'));
                  }
                  final destinations = snapshot.data!.docs;

                  return ListView.builder(
                    itemCount: destinations.length,
                    itemBuilder: (context, index) {
                      final destination =
                          destinations[index].data() as Map<String, dynamic>;
                      final destinationId = destinations[index].id;

                      return Card(
                        margin: const EdgeInsets.only(bottom: 8),
                        child: ListTile(
                          title: Text(destination['title'] ?? 'No Title'),
                          subtitle:
                              Text(destination['subtitle'] ?? 'No Subtitle'),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () async {
                              await _deleteDestination(destinationId);
                            },
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: _db.collection('special_trip_offers').snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasError) {
                    return const Center(
                        child: Text('Error loading trip offers'));
                  }
                  final trips = snapshot.data!.docs;

                  return ListView.builder(
                    itemCount: trips.length,
                    itemBuilder: (context, index) {
                      final trip = trips[index].data() as Map<String, dynamic>;
                      final tripId = trips[index].id;

                      return Card(
                        margin: const EdgeInsets.only(bottom: 8),
                        child: ListTile(
                          title: Text(trip['title'] ?? 'No Title'),
                          subtitle: Text(trip['subtitle'] ?? 'No Subtitle'),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () async {
                              await _deleteSpecialTripOffer(tripId);
                            },
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Show Add Destination Dialog
  void _showAddDestinationDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add Destination'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: _titleController,
                  decoration:
                      const InputDecoration(labelText: 'Destination Title'),
                ),
                TextField(
                  controller: _subtitleController,
                  decoration:
                      const InputDecoration(labelText: 'Destination Subtitle'),
                ),
                TextField(
                  controller: _imageUrlController,
                  decoration: const InputDecoration(labelText: 'Image URL'),
                ),
                TextField(
                  controller: _ratingController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(labelText: 'Rating (0-5)'),
                ),
                TextField(
                  controller: _aboutController,
                  decoration:
                      const InputDecoration(labelText: 'About the Destination'),
                ),
                TextField(
                  controller: _priceController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(labelText: 'Price'),
                ),
                if (_errorMessage != null)
                  Text(
                    _errorMessage!,
                    style: const TextStyle(
                        color: Colors.red, fontWeight: FontWeight.bold),
                  ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: _addDestination,
              child: const Text('Add Destination'),
            ),
          ],
        );
      },
    );
  }
}

import 'package:flutter/material.dart';

class DestinationDetailsPage extends StatelessWidget {
  final String title;
  final String subtitle;
  final double rating;
  final String imageUrl;
  final String about;

  const DestinationDetailsPage({
    super.key,
    required this.title,
    required this.subtitle,
    required this.rating,
    required this.imageUrl,
    required this.about,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.network(
                  imageUrl,
                  height: 250,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                        fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    subtitle,
                    style: const TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      const Icon(Icons.star, color: Colors.orange),
                      const SizedBox(width: 8),
                      Text(
                        rating.toStringAsFixed(1),
                        style: const TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    "About Destination",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    about,
                    style: const TextStyle(fontSize: 16, color: Colors.black87),
                  ),
                  Center(
              child: SizedBox(
                width: 380,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text("Booking Confirmation"),
                        content: const Text(
                            "Your booking request has been submitted successfully."),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text("Close"),
                          ),
                        ],
                      ),
                    );
                  },
                  // child: _isLoading
                  //     ? const CircularProgressIndicator(
                  //         valueColor:
                  //             AlwaysStoppedAnimation<Color>(Colors.white),
                  //       )
                  //     : const Text(
                  //         "Sign In",
                  //         style:
                  //             TextStyle(fontSize: 16, color: Colors.white),
                  //       ),
                  child: const Text(
                    "Book Now",
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ),
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

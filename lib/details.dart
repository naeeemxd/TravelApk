import 'package:flutter/material.dart';

class DestinationDetailsPage extends StatelessWidget {
  final String title;
  final String subtitle;
  final double rating;
  final String imageUrl;

  const DestinationDetailsPage({
    super.key,
    required this.title,
    required this.subtitle,
    required this.rating,
    required this.imageUrl,
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
            // SizedBox(
            //   height: 30,
            // ),
            // Image Section
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
            const SizedBox(height: 16),
            // Title and subtitle
            // Text(
            //   title,
            //   style: const TextStyle(
            //     fontSize: 24,
            //     fontWeight: FontWeight.bold,
            //   ),
            // ),
            const SizedBox(height: 16),

            // Destination Info Section
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),

                  // Subtitle
                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Rating Row
                  Row(
                    children: [
                      const Icon(Icons.star, color: Colors.orange, size: 24),
                      const SizedBox(width: 8),
                      Text(
                        rating.toStringAsFixed(1),
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Description Section
                  const Text(
                    "About Destination",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    "Discover the beauty and serenity of this destination. "
                    "From its picturesque views to its cultural richness, "
                    "it offers an unforgettable experience.",
                    style: TextStyle(fontSize: 16, color: Colors.black87),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // Action Section
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 16.0),
            //   child: ElevatedButton(
            //     style: ElevatedButton.styleFrom(
            //       backgroundColor: Colors.orange,
            //       shape: RoundedRectangleBorder(
            //         borderRadius: BorderRadius.circular(12),
            //       ),
            //       padding: const EdgeInsets.symmetric(vertical: 16),
            //     ),
            //     onPressed: () {
            //       // Handle booking logic
            //       showDialog(
            //         context: context,
            //         builder: (context) => AlertDialog(
            //           title: const Text("Booking Confirmation"),
            //           content: const Text(
            //               "Your booking request has been submitted successfully."),
            //           actions: [
            //             TextButton(
            //               onPressed: () => Navigator.pop(context),
            //               child: const Text("Close"),
            //             ),
            //           ],
            //         ),
            //       );
            //     },
            //     child: const Text(
            //       "Book Now",
            //       style: TextStyle(fontSize: 18, color: Colors.white),
            //     ),
            //   ),
            // ),

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
    );
  }
}

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Favorite Places',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const FavoritePlacesPage(),
    );
  }
}

class FavoritePlacesPage extends StatelessWidget {
  const FavoritePlacesPage({Key? key}) : super(key: key);

  final List<Map<String, String>> places = const [
    {
      "name": "Shakardu Resort",
      "location": "Alappuzha, Kerala",
      "imageUrl":
          "https://th.bing.com/th/id/OIP.DynQ3JpnpXMjqhaw4sTrqAHaEK?w=329&h=185&c=7&r=0&o=5&dpr=1.5&pid=1.7",
    },
    {
      "name": "Fort",
      "location": "Rajasthan",
      "imageUrl":
          "https://th.bing.com/th?id=OIP.ayttPunhSjiA5ywhMtpqQAHaE8&w=306&h=204&c=8&rs=1&qlt=90&o=6&dpr=1.5&pid=3.1&rm=2",
    },
    {
      "name": "Kachura Resort",
      "location": "Vellima, Goa",
      "imageUrl":
          "https://www.ecofleetuk.com/wp/wp-content/uploads/2016/12/PIXABAY-FREE-road-685655_1920.jpg",
    },
    {
      "name": "India Gate",
      "location": "New Delhi",
      "imageUrl":
          "https://th.bing.com/th?id=OLC.WwP1SNdyLXq%2feQ480x360&w=210&h=140&c=8&rs=1&qlt=90&o=6&dpr=1.5&pid=3.1&rm=2",
    },
    {
      "name": "Rangauti Resort",
      "location": "Manali, Mall Road",
      "imageUrl":
          "https://nofilmschool.com/sites/default/files/styles/article_wide/public/bigstock.jpg?itok=Snv4I36d",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorite Places'),
        leading: const Icon(Icons.arrow_back),
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 3 / 2.8,
          ),
          itemCount: places.length,
          itemBuilder: (context, index) {
            final place = places[index];
            final imageUrl = place['imageUrl'] ??
                'https://via.placeholder.com/150'; // Fallback image
            final name = place['name'] ?? 'Unknown Place';
            final location = place['location'] ?? 'Unknown Location';

            return Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(12),
                    ),
                    child: Image.network(
                      imageUrl,
                      height: 100,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Container(
                        height: 100,
                        width: double.infinity,
                        color: Colors.grey[300],
                        child: const Icon(
                          Icons.broken_image,
                          color: Colors.grey,
                          size: 50,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          name,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            const Icon(Icons.location_on,
                                size: 14, color: Colors.grey),
                            const SizedBox(width: 4),
                            Expanded(
                              child: Text(
                                location,
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

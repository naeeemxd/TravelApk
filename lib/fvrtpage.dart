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
      "name": "Taj Mahal",
      "location": "Agra",
      "imageUrl":
          "https://th.bing.com/th?id=OIP.idZSUFG2cJO0yfa3ZrhZiwHaFE&w=302&h=206&c=8&rs=1&qlt=90&o=6&dpr=1.5&pid=3.1&rm=2",
    },
    {
      "name": "Fort",
      "location": "Rajastan",
      "imageUrl":
          "https://th.bing.com/th?id=OIP.ayttPunhSjiA5ywhMtpqQAHaE8&w=306&h=204&c=8&rs=1&qlt=90&o=6&dpr=1.5&pid=3.1&rm=2",
    },
    {
      "name": "IndiaGate",
      "location": "New,Delhi",
      "imageUrl":
          "https://th.bing.com/th?id=OLC.WwP1SNdyLXq%2feQ480x360&w=210&h=140&c=8&rs=1&qlt=90&o=6&dpr=1.5&pid=3.1&rm=2",
    },
    {
      "name": "Rangauti Resort",
      "location": "manali, Mall Road",
      "imageUrl":
          "https://th.bing.com/th/id/OIP.DynQ3JpnpXMjqhaw4sTrqAHaEK?w=329&h=185&c=7&r=0&o=5&dpr=1.5&pid=1.7",
    },
    {
      "name": "Kachura Resort",
      "location": "Vellima, Goa",
      "imageUrl":
          "https://th.bing.com/th/id/OIP.DynQ3JpnpXMjqhaw4sTrqAHaEK?w=329&h=185&c=7&r=0&o=5&dpr=1.5&pid=1.7",
    },
    {
      "name": "Shakardu Resort",
      "location": "Alappuzha, Kerala",
      "imageUrl":
          "https://th.bing.com/th/id/OIP.DynQ3JpnpXMjqhaw4sTrqAHaEK?w=329&h=185&c=7&r=0&o=5&dpr=1.5&pid=1.7",
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
                      place['imageUrl']!,
                      height: 100,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          place['name']!,
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
                                place['location']!,
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

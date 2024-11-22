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
      title: 'Travel App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const PopularPackagesScreen(),
    );
  }
}

class PopularPackagesScreen extends StatelessWidget {
  const PopularPackagesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final packages = [
      {
        "imageUrl":
            "https://th.bing.com/th?id=OLC.WwP1SNdyLXq%2feQ480x360&w=210&h=140&c=8&rs=1&qlt=90&o=6&dpr=1.5&pid=3.1&rm=2",
        "title": "Taj Mahal, Agra",
        "date": "12 Dec - 14 Dec",
        "rating": 4.8,
        "persons": 20,
        "price": 15000
      },
      {
        "imageUrl":
            "https://th.bing.com/th/id/OIP.ER2OmFFsqNnQujjePjET_wHaFt?pid=ImgDet&w=192&h=148&c=7&dpr=1.5",
        "title": "Jaipur, Rajasthan",
        "date": "20 Dec - 25 Dec",
        "rating": 4.5,
        "persons": 18,
        "price": 20000
      },
      {
        "imageUrl":
            "https://th.bing.com/th/id/OIP.euV7CrNJeXDDX0-2XsmDPwHaE8?w=272&h=182&c=7&r=0&o=5&dpr=1.5&pid=1.7",
        "title": "Goa Beaches",
        "date": "5 Jan - 10 Jan",
        "rating": 4.7,
        "persons": 25,
        "price": 30000
      },
      {
        "imageUrl":
            "https://nofilmschool.com/sites/default/files/styles/article_wide/public/bigstock.jpg?itok=Snv4I36d",
        "title": "Darjeeling, WB",
        "date": "12 Jan - 15 Jan",
        "rating": 4.6,
        "persons": 22,
        "price": 18000
      },
    ];

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
              child: ListView.builder(
                itemCount: packages.length,
                itemBuilder: (context, index) {
                  final package = packages[index];
                  return _PackageCard(
                    imageUrl: package["imageUrl"] as String,
                    title: package["title"] as String,
                    date: package["date"] as String,
                    rating: package["rating"] as double,
                    persons: package["persons"] as int,
                    price: package["price"] as int,
                  );
                },
              ),
            ),
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

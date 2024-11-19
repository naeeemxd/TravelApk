import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DetailsScreen(),
    );
  }
}

class DetailsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Top Image with AppBar overlay
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 300,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                      'https://i.postimg.cc/W4ZdjrqK/image.png'), // Replace with your image URL
                  fit: BoxFit.cover,
                ),
              ),
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.white,
                        child: Icon(Icons.arrow_back, color: Colors.black),
                      ),
                      CircleAvatar(
                        backgroundColor: Colors.white,
                        child: Icon(Icons.favorite_border, color: Colors.black),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          // Bottom section
          Positioned(
            top: 260,
            left: 0,
            right: 0,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
              ),
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Destination Title and Info
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Niladri Reservoir",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            "Tekergat, Sunamganj",
                            style: TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                      CircleAvatar(
                        backgroundImage: NetworkImage(
                            'https://via.placeholder.com/150'), // Replace with avatar URL
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  // Ratings, Price, and Location
                  Row(
                    children: [
                      Icon(Icons.location_on, color: Colors.orange, size: 16),
                      SizedBox(width: 4),
                      Text("Tekergat"),
                      Spacer(),
                      Row(
                        children: [
                          Icon(Icons.star, color: Colors.orange, size: 16),
                          SizedBox(width: 4),
                          Text(
                            "4.7",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(" (2498)", style: TextStyle(color: Colors.grey)),
                        ],
                      ),
                      Spacer(),
                      Text(
                        "\$59/Person",
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  // Image Icons Carousel
                  SizedBox(
                    height: 60,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: List.generate(
                        5,
                        (index) => Padding(
                          padding: const EdgeInsets.only(right: 16),
                          child: CircleAvatar(
                            backgroundImage: NetworkImage(
                                'https://via.placeholder.com/100'), // Replace with images
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  // About Section
                  Text(
                    "About Destination",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "You will get a complete travel package on the beaches. Packages in the form of airline tickets, recommended hotel rooms, transportation, and more. Have you ever been on holiday to the Greek...",
                    style: TextStyle(color: Colors.grey),
                  ),
                  SizedBox(height: 4),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      "Read More",
                      style: TextStyle(color: Colors.blue),
                    ),
                  ),
                  // Book Now Button
                  SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      onPressed: () {},
                      child: Text(
                        "Book Now",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

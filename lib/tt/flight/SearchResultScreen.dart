import 'package:flutter/material.dart';

class SearchResultScreen extends StatelessWidget {
  final DateTime departureDate;
  const SearchResultScreen({Key? key, required this.departureDate}) : super(key: key);

  // Dummy flight data
  final List<Map<String, dynamic>> flights = const [
    {
      "airline": "Indigo",
      "flightNumber": "IN 230",
      "departureTime": "5:50 AM",
      "arrivalTime": "7:30 AM",
      "duration": "01 hr 40 min",
      "from": "DEL (Delhi)",
      "to": "CCU (Kolkata)",
      "class": "Business Class",
      "price": 230
    },
    {
      "airline": "Delta",
      "flightNumber": "IN 231",
      "departureTime": "4:30 AM",
      "arrivalTime": "6:30 AM",
      "duration": "01 hr 40 min",
      "from": "DEL (Delhi)",
      "to": "CCU (Kolkata)",
      "class": "Economy Class",
      "price": 360
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Result'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: flights.length,
          itemBuilder: (context, index) {
            final flight = flights[index];
            return Card(
              margin: const EdgeInsets.only(bottom: 16.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              elevation: 4.0,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(flight["airline"], style: const TextStyle(fontWeight: FontWeight.bold)),
                        Text("From \$${flight["price"]}",
                            style: const TextStyle(
                              color: Colors.orange,
                              fontWeight: FontWeight.bold,
                            )),
                      ],
                    ),
                    const SizedBox(height: 8.0),
                    Row(
                      children: [
                        Text(flight["departureTime"]),
                        const Icon(Icons.flight, color: Colors.orange),
                        Text(flight["arrivalTime"]),
                      ],
                    ),
                    const SizedBox(height: 8.0),
                    Text(flight["duration"]),
                    ElevatedButton(
                      onPressed: () {},
                      child: const Text('Check'),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

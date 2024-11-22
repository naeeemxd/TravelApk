import 'package:flutter/material.dart';

class DummyFlightBookingScreen extends StatefulWidget {
  @override
  _DummyFlightBookingScreenState createState() =>
      _DummyFlightBookingScreenState();
}

class _DummyFlightBookingScreenState extends State<DummyFlightBookingScreen> {
  List<Map<String, String>> availableFlights = [
    {'airline': 'Lufthansa', 'country': 'Germany', 'altitude': '11000 meters'},
    {'airline': 'Swiss', 'country': 'Switzerland', 'altitude': '13000 meters'},
    {'airline': 'Air France', 'country': 'France', 'altitude': '12000 meters'},
  ];

  void _bookFlight(Map<String, String> flight) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Flight Booking Confirmation'),
          content: Text(
              'You have successfully booked a flight with ${flight['airline']} to ${flight['country']}.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dummy Flight Booking'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: availableFlights.length,
          itemBuilder: (context, index) {
            final flight = availableFlights[index];
            return Card(
              elevation: 3,
              margin: EdgeInsets.symmetric(vertical: 8),
              child: ListTile(
                title: Text('Airline: ${flight['airline']}'),
                subtitle: Text(
                    'Country: ${flight['country']}\nAltitude: ${flight['altitude']}'),
                onTap: () => _bookFlight(flight),
              ),
            );
          },
        ),
      ),
    );
  }
}

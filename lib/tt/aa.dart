import 'package:flutter/material.dart';
import 'package:tripvs/tt/scrn.dart';
// import 'flight_data_screen.dart'; // Import the screen

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flight Tracker',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: DummyFlightBookingScreen(),
    );
  }
}

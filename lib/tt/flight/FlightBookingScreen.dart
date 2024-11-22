import 'package:flutter/material.dart';
import 'package:tripvs/tt/flight/DepartureDateScreen.dart';
import 'package:tripvs/tt/flight/SearchResultScreen.dart';
// import 'departure_date_screen.dart';

class BookFlightScreen extends StatefulWidget {
  const BookFlightScreen({Key? key}) : super(key: key);

  @override
  State<BookFlightScreen> createState() => _BookFlightScreenState();
}

class _BookFlightScreenState extends State<BookFlightScreen> {
  final TextEditingController fromController = TextEditingController(text: "Delhi DEL");
  final TextEditingController toController = TextEditingController(text: "Kolkata CCU");
  DateTime? selectedDepartureDate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Book Flight"),
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Flight input fields
            TextField(
              controller: fromController,
              readOnly: true,
              decoration: const InputDecoration(
                labelText: "From",
                prefixIcon: Icon(Icons.flight_takeoff),
              ),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: toController,
              readOnly: true,
              decoration: const InputDecoration(
                labelText: "To",
                prefixIcon: Icon(Icons.flight_land),
              ),
            ),
            const SizedBox(height: 16.0),
            GestureDetector(
              onTap: () async {
                final date = await Navigator.push<DateTime>(
                  context,
                  MaterialPageRoute(builder: (context) => const DepartureDateScreen()),
                );
                if (date != null) {
                  setState(() {
                    selectedDepartureDate = date;
                  });
                }
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      selectedDepartureDate != null
                          ? "${selectedDepartureDate!.toLocal()}".split(' ')[0]
                          : "Select Departure Date",
                      style: TextStyle(
                        fontSize: 16,
                        color: selectedDepartureDate != null ? Colors.black : Colors.grey,
                      ),
                    ),
                    const Icon(Icons.calendar_today, color: Colors.orange),
                  ],
                ),
              ),
            ),
            const Spacer(),

            ElevatedButton(
              onPressed: selectedDepartureDate != null
                  ? () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              SearchResultScreen(departureDate: selectedDepartureDate!),
                        ),
                      );
                    }
                  : null,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
                backgroundColor: Colors.orange,
              ),
              child: const Text("Search", style: TextStyle(fontSize: 16.0)),
            ),
          ],
        ),
      ),
    );
  }
}

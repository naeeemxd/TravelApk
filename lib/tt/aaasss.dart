import 'dart:convert';
import 'package:http/http.dart' as http;

class OpenSkyService {
  final String baseUrl = 'https://opensky-network.org/api';

  Future<List<dynamic>> fetchFlightStates() async {
    final response = await http.get(Uri.parse('$baseUrl/states/all'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['states'] ?? [];
    } else {
      throw Exception('Failed to fetch flight data: ${response.statusCode}');
    }
  }
}
  
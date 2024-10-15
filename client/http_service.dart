import 'dart:convert';
import 'package:http/http.dart' as http;
import 'lib/models/parking_space.dart';

class HttpService {
  final String baseUrl;

  HttpService(this.baseUrl);

  Future<List<ParkingSpace>> fetchParkingSpaces() async {
    final response = await http.get(Uri.parse('$baseUrl/parking-spaces'));
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((item) => ParkingSpace.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load parking spaces');
    }
  }

  Future<void> createParkingSpace(ParkingSpace parkingSpace) async {
    final response = await http.post(
      Uri.parse('$baseUrl/parking-spaces'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(parkingSpace.toJson()),
    );

    if (response.statusCode != 201) {
      throw Exception('Failed to create parking space');
    }
  }
}

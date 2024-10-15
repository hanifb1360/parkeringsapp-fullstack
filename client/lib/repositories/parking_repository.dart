import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/parking.dart';

class ParkingRepository {
  final String baseUrl;

  ParkingRepository(this.baseUrl);

  // Fetch all parkings
  Future<List<Parking>> fetchAll() async {
    final response = await http.get(Uri.parse('$baseUrl/parkings'));
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) => Parking.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load parkings');
    }
  }

  // Fetch a parking by vehicle registration number or ID
  Future<Parking?> getById(String regNumber) async {
    final response = await http.get(Uri.parse('$baseUrl/parkings/$regNumber'));
    if (response.statusCode == 200) {
      return Parking.fromJson(json.decode(response.body));
    } else if (response.statusCode == 404) {
      return null; // Parking not found
    } else {
      throw Exception('Failed to load parking');
    }
  }

  // Create a new parking
  Future<void> createParking(Parking parking) async {
    final response = await http.post(
      Uri.parse('$baseUrl/parkings'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(parking.toJson()),
    );
    if (response.statusCode != 201) {
      throw Exception('Failed to create parking');
    }
  }

  // Update an existing parking
  Future<void> updateParking(String id, Parking parking) async {
    final response = await http.put(
      Uri.parse('$baseUrl/parkings/$id'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(parking.toJson()),
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to update parking');
    }
  }

  // Delete a parking
  Future<void> deleteParking(String id) async {
    final response = await http.delete(Uri.parse('$baseUrl/parkings/$id'));
    if (response.statusCode != 200) {
      throw Exception('Failed to delete parking');
    }
  }
}

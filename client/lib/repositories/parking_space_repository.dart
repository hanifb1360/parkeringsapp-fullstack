import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/parking_space.dart';
import '../http_service.dart'; // Import the baseUrl here

class ParkingSpaceRepository {
  // Fetch all parking spaces
  Future<List<ParkingSpace>> fetchAll() async {
    final response = await http.get(Uri.parse('$baseUrl/parking-spaces'));
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) => ParkingSpace.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load parking spaces');
    }
  }

  // Fetch a parking space by ID
  Future<ParkingSpace?> getById(String id) async {
    final response = await http.get(Uri.parse('$baseUrl/parking-spaces/$id'));
    if (response.statusCode == 200) {
      return ParkingSpace.fromJson(json.decode(response.body));
    } else if (response.statusCode == 404) {
      return null; // Parking space not found
    } else {
      throw Exception('Failed to load parking space');
    }
  }

  // Create a new parking space
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

  // Update an existing parking space
  Future<void> updateParkingSpace(String id, ParkingSpace parkingSpace) async {
    final response = await http.put(
      Uri.parse('$baseUrl/parking-spaces/$id'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(parkingSpace.toJson()),
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to update parking space');
    }
  }

  // Delete a parking space
  Future<void> deleteParkingSpace(String id) async {
    final response =
        await http.delete(Uri.parse('$baseUrl/parking-spaces/$id'));
    if (response.statusCode != 200) {
      throw Exception('Failed to delete parking space');
    }
  }
}

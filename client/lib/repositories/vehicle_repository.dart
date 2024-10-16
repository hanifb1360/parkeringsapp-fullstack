import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/vehicle.dart';

class VehicleRepository {
  final String baseUrl;

  VehicleRepository(this.baseUrl);

  // Fetch all vehicles
  Future<List<Vehicle>> fetchAll() async {
    final response = await http.get(Uri.parse('$baseUrl/vehicles'));
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) => Vehicle.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load vehicles');
    }
  }

  // Create a new vehicle
  Future<void> createVehicle(Vehicle vehicle) async {
    final response = await http.post(
      Uri.parse('$baseUrl/vehicles'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(vehicle.toJson()),
    );
    if (response.statusCode != 201) {
      throw Exception('Failed to create vehicle');
    }
  }

  // Update an existing vehicle
  Future<void> updateVehicle(String regNumber, Vehicle vehicle) async {
    final response = await http.put(
      Uri.parse('$baseUrl/vehicles/$regNumber'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(vehicle.toJson()),
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to update vehicle');
    }
  }

  // Delete a vehicle
  Future<void> deleteVehicle(String regNumber) async {
    final response =
        await http.delete(Uri.parse('$baseUrl/vehicles/$regNumber'));
    if (response.statusCode != 200) {
      throw Exception('Failed to delete vehicle');
    }
  }

  // Fetch a vehicle by registration number (ID)
  Future<Vehicle?> getById(String regNumber) async {
    final response = await http.get(Uri.parse('$baseUrl/vehicles/$regNumber'));

    if (response.statusCode == 200) {
      return Vehicle.fromJson(json.decode(response.body));
    } else if (response.statusCode == 404) {
      return null; // Vehicle not found
    } else {
      throw Exception('Failed to load vehicle');
    }
  }

  // Fetch vehicles by owner's personal number
  Future<List<Vehicle>> getByOwner(String ownerPersonalNumber) async {
    final response = await http
        .get(Uri.parse('$baseUrl/vehicles?owner=$ownerPersonalNumber'));
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) => Vehicle.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load vehicles for the owner');
    }
  }
}

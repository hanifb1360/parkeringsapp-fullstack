import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/vehicle.dart';

class VehicleRepository {
  final String baseUrl;

  VehicleRepository(this.baseUrl);

  Future<List<Vehicle>> fetchAll() async {
    final response = await http.get(Uri.parse('$baseUrl/vehicles'));
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) => Vehicle.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load vehicles');
    }
  }

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

  Future<void> deleteVehicle(String regNumber) async {
    final response =
        await http.delete(Uri.parse('$baseUrl/vehicles/$regNumber'));
    if (response.statusCode != 200) {
      throw Exception('Failed to delete vehicle');
    }
  }
}

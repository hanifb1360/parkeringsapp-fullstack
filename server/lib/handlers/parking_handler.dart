import 'dart:convert';
import 'package:shelf/shelf.dart';
import '../repositories/parking_repository.dart';
import '../models/parking.dart';

class ParkingHandler {
  final ParkingRepository repository;

  ParkingHandler(this.repository);

  // Handle GET request to fetch all parking records
  Future<Response> getAll(Request request) async {
    final parkings = await repository.getAll();
    return Response.ok(jsonEncode(parkings.map((p) => p.toJson()).toList()));
  }

  // Handle GET request to fetch a parking by ID
  Future<Response> getById(Request request, String id) async {
    final parking = await repository.getById(int.parse(id));
    return parking != null
        ? Response.ok(jsonEncode(parking.toJson()))
        : Response.notFound('Parking not found');
  }

  // Handle POST request to create a new parking record
  Future<Response> create(Request request) async {
    final payload = await request.readAsString();
    final data = jsonDecode(payload) as Map<String, dynamic>;
    final parking = Parking.fromJson(data);
    await repository.create(parking);
    return Response(201, body: 'Parking created');
  }

  // Handle PUT request to update a parking record by ID
  Future<Response> update(Request request, String id) async {
    final payload = await request.readAsString();
    final data = jsonDecode(payload) as Map<String, dynamic>;
    final parking = Parking.fromJson(data);
    await repository.update(int.parse(id), parking);
    return Response.ok('Parking updated');
  }

  // Handle DELETE request to remove a parking by ID
  Future<Response> delete(Request request, String id) async {
    await repository.delete(int.parse(id));
    return Response.ok('Parking deleted');
  }
}

import 'dart:convert';
import 'package:shelf/shelf.dart';
import '../repositories/vehicle_repository.dart';
import '../models/vehicle.dart';

class VehicleHandler {
  final VehicleRepository repository;

  VehicleHandler(this.repository);

  Future<Response> getAll(Request request) async {
    try {
      final vehicles = await repository.getAll();
      return Response.ok(jsonEncode(vehicles.map((v) => v.toJson()).toList()));
    } catch (e) {
      return Response.internalServerError(body: 'Failed to fetch vehicles: $e');
    }
  }

  Future<Response> getById(Request request, String id) async {
    try {
      final vehicleId = int.tryParse(id);
      if (vehicleId == null) {
        return Response.badRequest(body: 'Invalid vehicle ID');
      }
      final vehicle = await repository.getById(vehicleId);
      return vehicle != null
          ? Response.ok(jsonEncode(vehicle.toJson()))
          : Response.notFound('Vehicle not found');
    } catch (e) {
      return Response.internalServerError(body: 'Failed to fetch vehicle: $e');
    }
  }

  Future<Response> create(Request request) async {
    try {
      final payload = await request.readAsString();
      final data = jsonDecode(payload) as Map<String, dynamic>;
      final vehicle = Vehicle.fromJson(data);
      await repository.create(vehicle);
      return Response(201, body: 'Vehicle created');
    } catch (e) {
      return Response.internalServerError(body: 'Failed to create vehicle: $e');
    }
  }

  Future<Response> update(Request request, String id) async {
    try {
      final vehicleId = int.tryParse(id);
      if (vehicleId == null) {
        return Response.badRequest(body: 'Invalid vehicle ID');
      }
      final payload = await request.readAsString();
      final data = jsonDecode(payload) as Map<String, dynamic>;
      final vehicle = Vehicle.fromJson(data);
      await repository.update(vehicleId, vehicle);
      return Response.ok('Vehicle updated');
    } catch (e) {
      return Response.internalServerError(body: 'Failed to update vehicle: $e');
    }
  }

  Future<Response> delete(Request request, String id) async {
    try {
      final vehicleId = int.tryParse(id);
      if (vehicleId == null) {
        return Response.badRequest(body: 'Invalid vehicle ID');
      }
      await repository.delete(vehicleId);
      return Response.ok('Vehicle deleted');
    } catch (e) {
      return Response.internalServerError(body: 'Failed to delete vehicle: $e');
    }
  }
}

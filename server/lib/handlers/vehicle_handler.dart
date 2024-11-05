import 'dart:convert';
import 'package:shelf/shelf.dart';
import '../repositories/vehicle_repository.dart';
import '../models/vehicle.dart';

class VehicleHandler {
  final VehicleRepository repository;

  VehicleHandler(this.repository);

  Future<Response> getAll(Request request) async {
    final vehicles = await repository.getAll();
    return Response.ok(jsonEncode(vehicles.map((v) => v.toJson()).toList()));
  }

  Future<Response> getById(Request request, String id) async {
    final vehicle = await repository.getById(int.parse(id));
    return vehicle != null
        ? Response.ok(jsonEncode(vehicle.toJson()))
        : Response.notFound('Vehicle not found');
  }

  Future<Response> create(Request request) async {
    final payload = await request.readAsString();
    final data = jsonDecode(payload) as Map<String, dynamic>;
    final vehicle = Vehicle.fromJson(data);
    await repository.create(vehicle);
    return Response(201, body: 'Vehicle created');
  }

  Future<Response> update(Request request, String id) async {
    final payload = await request.readAsString();
    final data = jsonDecode(payload) as Map<String, dynamic>;
    final vehicle = Vehicle.fromJson(data);
    await repository.update(int.parse(id), vehicle);
    return Response.ok('Vehicle updated');
  }

  Future<Response> delete(Request request, String id) async {
    await repository.delete(int.parse(id));
    return Response.ok('Vehicle deleted');
  }
}

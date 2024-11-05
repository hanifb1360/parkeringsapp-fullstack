import 'dart:convert';
import 'package:shelf/shelf.dart';
import '../repositories/parking_space_repository.dart';
import '../models/parking_space.dart';

class ParkingSpaceHandler {
  final ParkingSpaceRepository repository;

  ParkingSpaceHandler(this.repository);

  Future<Response> getAll(Request request) async {
    final parkingSpaces = await repository.getAll();
    return Response.ok(
        jsonEncode(parkingSpaces.map((p) => p.toJson()).toList()));
  }

  Future<Response> getById(Request request, String id) async {
    final parkingSpace = await repository.getById(int.parse(id));
    return parkingSpace != null
        ? Response.ok(jsonEncode(parkingSpace.toJson()))
        : Response.notFound('Parking space not found');
  }

  Future<Response> create(Request request) async {
    final payload = await request.readAsString();
    final data = jsonDecode(payload) as Map<String, dynamic>;
    final parkingSpace = ParkingSpace.fromJson(data);
    await repository.create(parkingSpace);
    return Response(201, body: 'Parking space created');
  }

  Future<Response> update(Request request, String id) async {
    final payload = await request.readAsString();
    final data = jsonDecode(payload) as Map<String, dynamic>;
    final parkingSpace = ParkingSpace.fromJson(data);
    await repository.update(int.parse(id), parkingSpace);
    return Response.ok('Parking space updated');
  }

  Future<Response> delete(Request request, String id) async {
    await repository.delete(int.parse(id));
    return Response.ok('Parking space deleted');
  }
}

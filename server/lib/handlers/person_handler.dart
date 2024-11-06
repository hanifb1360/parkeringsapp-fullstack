import 'dart:convert';
import 'package:shelf/shelf.dart';
import '../repositories/person_repository.dart';
import '../models/person.dart';

class PersonHandler {
  final PersonRepository repository;

  PersonHandler(this.repository);

  Future<Response> getAll(Request request) async {
    try {
      final persons = await repository.getAll();
      return Response.ok(jsonEncode(persons.map((p) => p.toJson()).toList()));
    } catch (e) {
      return Response.internalServerError(body: 'Failed to fetch persons: $e');
    }
  }

  Future<Response> getById(Request request, String id) async {
    try {
      final personId = int.tryParse(id);
      if (personId == null) {
        return Response.badRequest(body: 'Invalid person ID');
      }
      final person = await repository.getById(personId);
      return person != null
          ? Response.ok(jsonEncode(person.toJson()))
          : Response.notFound('Person not found');
    } catch (e) {
      return Response.internalServerError(body: 'Failed to fetch person: $e');
    }
  }

  Future<Response> create(Request request) async {
    try {
      final payload = await request.readAsString();
      final data = jsonDecode(payload) as Map<String, dynamic>;
      final person = Person.fromJson(data);
      await repository.create(person);
      return Response(201, body: 'Person created');
    } catch (e) {
      return Response.internalServerError(body: 'Failed to create person: $e');
    }
  }

  Future<Response> update(Request request, String id) async {
    try {
      final personId = int.tryParse(id);
      if (personId == null) {
        return Response.badRequest(body: 'Invalid person ID');
      }
      final payload = await request.readAsString();
      final data = jsonDecode(payload) as Map<String, dynamic>;
      final person = Person.fromJson(data);
      await repository.update(personId, person);
      return Response.ok('Person updated');
    } catch (e) {
      return Response.internalServerError(body: 'Failed to update person: $e');
    }
  }

  Future<Response> delete(Request request, String id) async {
    try {
      final personId = int.tryParse(id);
      if (personId == null) {
        return Response.badRequest(body: 'Invalid person ID');
      }
      await repository.delete(personId);
      return Response.ok('Person deleted');
    } catch (e) {
      return Response.internalServerError(body: 'Failed to delete person: $e');
    }
  }
}

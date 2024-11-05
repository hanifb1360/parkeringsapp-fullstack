import 'dart:convert';
import 'package:shelf/shelf.dart';
import '../repositories/person_repository.dart';
import '../models/person.dart';

class PersonHandler {
  final PersonRepository repository;

  PersonHandler(this.repository);

  Future<Response> getAll(Request request) async {
    final persons = await repository.getAll();
    return Response.ok(jsonEncode(persons.map((p) => p.toJson()).toList()));
  }

  Future<Response> getById(Request request, String id) async {
    final person = await repository.getById(int.parse(id));
    return person != null
        ? Response.ok(jsonEncode(person.toJson()))
        : Response.notFound('Person not found');
  }

  Future<Response> create(Request request) async {
    final payload = await request.readAsString();
    final data = jsonDecode(payload) as Map<String, dynamic>;
    final person = Person.fromJson(data);
    await repository.create(person);
    return Response(201, body: 'Person created');
  }

  Future<Response> update(Request request, String id) async {
    final payload = await request.readAsString();
    final data = jsonDecode(payload) as Map<String, dynamic>;
    final person = Person.fromJson(data);
    await repository.update(int.parse(id), person);
    return Response.ok('Person updated');
  }

  Future<Response> delete(Request request, String id) async {
    await repository.delete(int.parse(id));
    return Response.ok('Person deleted');
  }
}

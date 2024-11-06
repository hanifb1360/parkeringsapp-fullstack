import 'package:objectbox/objectbox.dart';
import '../models/person.dart';
import 'dart:async';

class PersonRepository {
  final Box<Person> _box;

  PersonRepository(this._box);

  Future<List<Person>> getAll() async {
    try {
      return _box.getAll();
    } catch (e) {
      throw Exception("Failed to fetch persons: $e");
    }
  }

  Future<Person?> getById(int id) async {
    try {
      return _box.get(id);
    } catch (e) {
      throw Exception("Failed to fetch person by ID: $e");
    }
  }

  Future<Person> create(Person person) async {
    try {
      person.id = _box.put(person);
      return person;
    } catch (e) {
      throw Exception("Failed to create person: $e");
    }
  }

  Future<Person> update(int id, Person updatedPerson) async {
    try {
      final existingPerson = await getById(id);
      if (existingPerson != null) {
        updatedPerson.id = id;
        _box.put(updatedPerson);
        return updatedPerson;
      } else {
        throw Exception("Person not found");
      }
    } catch (e) {
      throw Exception("Failed to update person: $e");
    }
  }

  Future<Person> delete(int id) async {
    try {
      final existingPerson = await getById(id);
      if (existingPerson != null) {
        _box.remove(id);
        return existingPerson;
      } else {
        throw Exception("Person not found");
      }
    } catch (e) {
      throw Exception("Failed to delete person: $e");
    }
  }
}

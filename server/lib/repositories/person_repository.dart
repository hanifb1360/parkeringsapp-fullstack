import 'package:objectbox/objectbox.dart';
import '../models/person.dart';
import 'dart:async';

class PersonRepository {
  final Box<Person> _box;

  PersonRepository(this._box);

  Future<List<Person>> getAll() async {
    return _box.getAll();
  }

  Future<Person?> getById(int id) async {
    return _box.get(id);
  }

  Future<Person> create(Person person) async {
    person.id = _box.put(person);
    return person;
  }

  Future<Person> update(int id, Person updatedPerson) async {
    final existingPerson = await getById(id);
    if (existingPerson != null) {
      updatedPerson.id = id;
      _box.put(updatedPerson);
      return updatedPerson;
    } else {
      throw Exception("Person not found");
    }
  }

  Future<Person> delete(int id) async {
    final existingPerson = await getById(id);
    if (existingPerson != null) {
      _box.remove(id);
      return existingPerson;
    } else {
      throw Exception("Person not found");
    }
  }
}

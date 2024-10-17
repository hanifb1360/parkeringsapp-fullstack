import 'package:objectbox/objectbox.dart';
import '../models/person.dart';
import 'dart:async';

class PersonRepository {
  final Box<Person> _box; // Box to store Person objects

  // Constructor
  PersonRepository(this._box);

  Future<List<Person>> getAll() async {
    return _box.getAll(); // Get all Person objects from ObjectBox
  }

  Future<Person?> getById(int id) async {
    return _box.get(id); // Get a Person object by ID from ObjectBox
  }

  Future<void> create(Person person) async {
    person.id =
        _box.put(person); // Directly assign the returned ID to person.id
  }

  Future<bool> update(int id, Person updatedPerson) async {
    final existingPerson = await getById(id);
    if (existingPerson != null) {
      updatedPerson.id =
          id; // Ensure the ID is set for the updated Person object
      _box.put(updatedPerson); // Update the Person object in ObjectBox
      return true;
    }
    return false;
  }

  Future<bool> delete(int id) async {
    final existingPerson = await getById(id);
    if (existingPerson != null) {
      _box.remove(id); // Remove the Person object from ObjectBox
      return true;
    }
    return false;
  }
}

import '../models/person.dart';
import '../http_service.dart';

class PersonRepository {
  // Fetch all persons
  Future<List<Person>> fetchAll() async {
    print('Attempting to fetch all persons');
    final data = await apiClient.get('/persons');
    return (data as List).map((json) => Person.fromJson(json)).toList();
  }

  // Fetch a person by personal number
  Future<Person?> getById(String personalNumber) async {
    final data = await apiClient.get('/persons/$personalNumber');
    return data != null ? Person.fromJson(data) : null;
  }

  // Create a new person
  Future<void> createPerson(Person person) async {
    await apiClient.post('/persons', person.toJson());
    print('Person created successfully');
  }

  // Update an existing person
  Future<void> updatePerson(String personalNumber, Person person) async {
    await apiClient.put('/persons/$personalNumber', person.toJson());
    print('Person updated successfully');
  }

  // Delete a person
  Future<void> deletePerson(String personalNumber) async {
    await apiClient.delete('/persons/$personalNumber');
    print('Person deleted successfully');
  }
}

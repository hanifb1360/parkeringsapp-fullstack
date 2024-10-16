import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/person.dart';

class PersonRepository {
  final String baseUrl;

  PersonRepository(this.baseUrl);

  // Fetch all persons
  Future<List<Person>> fetchAll() async {
    final response = await http.get(Uri.parse('$baseUrl/persons'));
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) => Person.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load persons');
    }
  }

  // Fetch a person by personal number
  Future<Person?> getById(String personalNumber) async {
    final response =
        await http.get(Uri.parse('$baseUrl/persons/$personalNumber'));
    if (response.statusCode == 200) {
      return Person.fromJson(json.decode(response.body));
    } else if (response.statusCode == 404) {
      return null; // Person not found
    } else {
      throw Exception('Failed to load person');
    }
  }

  // Create a new person
  Future<void> createPerson(Person person) async {
    final response = await http.post(
      Uri.parse('$baseUrl/persons'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(person.toJson()),
    );
    if (response.statusCode != 201) {
      throw Exception('Failed to create person');
    }
  }

  // Update an existing person
  Future<void> updatePerson(String personalNumber, Person person) async {
    final response = await http.put(
      Uri.parse('$baseUrl/persons/$personalNumber'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(person.toJson()),
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to update person');
    }
  }

  // Delete a person
  Future<void> deletePerson(String personalNumber) async {
    final response =
        await http.delete(Uri.parse('$baseUrl/persons/$personalNumber'));
    if (response.statusCode != 200) {
      throw Exception('Failed to delete person');
    }
  }
}

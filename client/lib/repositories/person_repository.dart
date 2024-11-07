import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/person.dart';
import '../http_service.dart';

class PersonRepository {
  // Fetch all persons
  Future<List<Person>> fetchAll() async {
    print('Attempting to fetch all persons from $baseUrl/persons');

    try {
      final response =
          await http.get(Uri.parse('http://localhost:8080/persons'));
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((json) => Person.fromJson(json)).toList();
      } else {
        print('Error: Received non-200 status code ${response.statusCode}');
        throw Exception('Failed to load persons');
      }
    } catch (e) {
      print('Error: Could not reach server - $e');
      rethrow;
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
    print('Attempted to create person with status: ${response.statusCode}');
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
    print('Attempted to update person with status: ${response.statusCode}');
    if (response.statusCode != 200) {
      throw Exception('Failed to update person');
    }
  }

  // Delete a person
  Future<void> deletePerson(String personalNumber) async {
    final response =
        await http.delete(Uri.parse('$baseUrl/persons/$personalNumber'));
    print('Attempted to delete person with status: ${response.statusCode}');
    if (response.statusCode != 200) {
      throw Exception('Failed to delete person');
    }
  }
}

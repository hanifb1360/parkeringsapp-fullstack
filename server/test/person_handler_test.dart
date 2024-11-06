import 'dart:convert';
import 'package:shelf/shelf.dart';
import 'package:test/test.dart';
import 'package:server/handlers/person_handler.dart';
import 'package:server/repositories/person_repository.dart';
import 'package:server/models/person.dart';
import 'package:server/objectbox.g.dart';
import 'dart:io';

// Mock repository implementation
class MockPersonRepository extends PersonRepository {
  MockPersonRepository(super.box);

  @override
  Future<List<Person>> getAll() async {
    return [Person(id: 1, name: 'John Doe', email: 'john.doe@example.com')];
  }

  @override
  Future<Person?> getById(int id) async {
    return id == 1
        ? Person(id: 1, name: 'John Doe', email: 'john.doe@example.com')
        : null;
  }

  @override
  Future<Person> create(Person person) async {
    return person;
  }

  @override
  Future<Person> update(int id, Person updatedPerson) async {
    if (id == 1) {
      return updatedPerson;
    } else {
      throw Exception('Person not found');
    }
  }

  @override
  Future<Person> delete(int id) async {
    if (id == 1) {
      return Person(id: 1, name: 'John Doe', email: 'john.doe@example.com');
    } else {
      throw Exception('Person not found');
    }
  }
}

void main() {
  late MockPersonRepository mockRepository;
  late PersonHandler handler;
  late Store store;

  setUp(() {
    store = Store(
      getObjectBoxModel(),
      directory:
          './objectbox_test_${DateTime.now().millisecondsSinceEpoch}', // Unique directory for each test run
    );
    final box = store.box<Person>();
    mockRepository = MockPersonRepository(box);
    handler = PersonHandler(mockRepository);
  });

  tearDown(() {
    store.close(); // Close the store after each test
    Directory(store.directoryPath).deleteSync(recursive: true); // Clean up
  });

  test('GET /persons returns a list of persons', () async {
    final request = Request('GET', Uri.parse('http://localhost/persons'));
    final response = await handler.getAll(request);

    expect(response.statusCode, equals(200));
    expect(await response.readAsString(), contains('John Doe'));
  });

  test('GET /persons/<id> returns a person if found', () async {
    final request = Request('GET', Uri.parse('http://localhost/persons/1'));
    final response = await handler.getById(request, '1');

    expect(response.statusCode, equals(200));
    expect(await response.readAsString(), contains('John Doe'));
  });

  test('GET /persons/<id> returns 404 if not found', () async {
    final request = Request('GET', Uri.parse('http://localhost/persons/2'));
    final response = await handler.getById(request, '2');

    expect(response.statusCode, equals(404));
  });

  test('POST /persons creates a new person', () async {
    final payload =
        jsonEncode({'name': 'Jane Doe', 'email': 'jane.doe@example.com'});
    final request =
        Request('POST', Uri.parse('http://localhost/persons'), body: payload);
    final response = await handler.create(request);

    expect(response.statusCode, equals(201));
    expect(await response.readAsString(), contains('Person created'));
  });

  test('PUT /persons/<id> updates a person if found', () async {
    final payload = jsonEncode(
        {'name': 'Updated Name', 'email': 'updated.email@example.com'});
    final request =
        Request('PUT', Uri.parse('http://localhost/persons/1'), body: payload);
    final response = await handler.update(request, '1');

    expect(response.statusCode, equals(200));
    expect(await response.readAsString(), contains('Person updated'));
  });

  test('DELETE /persons/<id> deletes a person if found', () async {
    final request = Request('DELETE', Uri.parse('http://localhost/persons/1'));
    final response = await handler.delete(request, '1');

    expect(response.statusCode, equals(200));
    expect(await response.readAsString(), contains('Person deleted'));
  });
}

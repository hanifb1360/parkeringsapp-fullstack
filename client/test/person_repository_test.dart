import 'package:test/test.dart';
import 'package:parkeringsapp/repositories/person_repository.dart';
import 'package:parkeringsapp/models/person.dart';

void main() {
  group('PersonRepository', () {
    final repository = PersonRepository();

    // Rensa lagret före varje test
    setUp(() {
      repository.clear();
    });

    test('should add a person', () {
      final person = Person(personalNumber: '123', name: 'John Doe');
      repository.add(person);

      final allPersons = repository.getAll();
      expect(allPersons, contains(person));
    });

    test('should retrieve all persons', () {
      final person1 = Person(personalNumber: '123', name: 'John Doe');
      final person2 = Person(personalNumber: '456', name: 'Jane Doe');
      repository.add(person1);
      repository.add(person2);

      final allPersons = repository.getAll();
      expect(allPersons.length, 2);
      expect(allPersons, containsAll([person1, person2]));
    });

    test('should retrieve a person by ID', () {
      final person = Person(personalNumber: '123', name: 'John Doe');
      repository.add(person);

      final retrievedPerson = repository.getById('123');
      expect(retrievedPerson, equals(person));
    });

    test('should update a person', () {
      final person = Person(personalNumber: '123', name: 'John Doe');
      repository.add(person);

      final updatedPerson = Person(personalNumber: '123', name: 'Johnny Doe');
      repository.update(updatedPerson);

      final retrievedPerson = repository.getById('123');
      expect(retrievedPerson.name, 'Johnny Doe'); // Update should be reflected
    });

    test('should delete a person', () {
      final person = Person(personalNumber: '123', name: 'John Doe');
      repository.add(person);

      repository.delete('123');

      expect(() => repository.getById('123'), throwsA(isA<Exception>()));
    });
  });
}

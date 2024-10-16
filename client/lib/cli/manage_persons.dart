import 'dart:io';
import '../repositories/person_repository.dart';
import '../models/person.dart';

void managePersons() async {
  final repository = PersonRepository('http://localhost:8080'); // Pass base URL

  while (true) {
    print('\nDu har valt att hantera Personer.');
    print('1. Skapa ny person');
    print('2. Visa alla personer');
    print('3. Uppdatera person');
    print('4. Ta bort person');
    print('5. Gå tillbaka till huvudmenyn');
    stdout.write('Välj ett alternativ (1-5): ');
    var choice = stdin.readLineSync();

    switch (choice) {
      case '1':
        // Skapa en ny person
        stdout.write('Ange namn: ');
        var name = stdin.readLineSync();
        stdout.write('Ange personnummer: ');
        var personalNumber = stdin.readLineSync();
        stdout.write('Ange email: ');
        var email = stdin.readLineSync();

        var person =
            Person(personalNumber: personalNumber!, name: name!, email: email!);
        await repository.createPerson(person);
        print('Person skapad: $person');
        break;

      case '2':
        // Visa alla registrerade personer
        var persons = await repository.fetchAll();
        if (persons.isEmpty) {
          print('Inga personer registrerade.');
        } else {
          for (var person in persons) {
            print(person);
          }
        }
        break;

      case '3':
        // Uppdatera en befintlig person
        stdout.write('Ange personnummer för den person du vill uppdatera: ');
        var personalNumber = stdin.readLineSync();
        var person = await repository.getById(personalNumber!);

        if (person == null) {
          print('Personen hittades inte.');
          break;
        }

        stdout.write('Ange nytt namn: ');
        var newName = stdin.readLineSync();
        stdout.write('Ange ny email: ');
        var newEmail = stdin.readLineSync();

        person.name = newName!;
        person.email = newEmail!;

        await repository.updatePerson(person.personalNumber, person);
        print('Person uppdaterad: $person');
        break;

      case '4':
        // Ta bort en person
        stdout.write('Ange personnummer för den person du vill ta bort: ');
        var personalNumber = stdin.readLineSync();
        await repository.deletePerson(personalNumber!);
        print('Person borttagen.');
        break;

      case '5':
        // Gå tillbaka till huvudmenyn
        return;

      default:
        print('Ogiltigt val, försök igen.');
    }
  }
}

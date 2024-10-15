import 'dart:io';
import '../repositories/person_repository.dart';
import '../models/person.dart';

void managePersons() {
  final repository = PersonRepository(); // Singleton-instans

  while (true) {
    // Visa meny för att hantera personer
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
        if (name == null || name.isEmpty) {
          print('Ogiltigt namn, försök igen.');
          continue;
        }
        stdout.write('Ange personnummer: ');
        var personalNumber = stdin.readLineSync();
        if (personalNumber == null || personalNumber.isEmpty) {
          print('Ogiltigt personnummer, försök igen.');
          continue;
        }
        var person = Person(name: name, personalNumber: personalNumber);
        repository.add(person);
        print('Person skapad: $person');
        break;
      case '2':
        // Visa alla registrerade personer
        var persons = repository.getAll();
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
        if (personalNumber == null || personalNumber.isEmpty) {
          print('Ogiltigt personnummer, försök igen.');
          continue;
        }
        var person = repository.getById(personalNumber);
        // Ingen behov av null-kontroll här, eftersom personen inte kan vara null
        stdout.write('Ange nytt namn: ');
        var newName = stdin.readLineSync();
        if (newName == null || newName.isEmpty) {
          print('Ogiltigt namn, försök igen.');
          continue;
        }
        person.name = newName;
        repository.update(person);
        print('Person uppdaterad: $person');
        break;
      case '4':
        // Ta bort en person
        stdout.write('Ange personnummer för den person du vill ta bort: ');
        var personalNumber = stdin.readLineSync();
        if (personalNumber == null || personalNumber.isEmpty) {
          print('Ogiltigt personnummer, försök igen.');
          continue;
        }
        repository.delete(personalNumber);
        print('Person borttagen.');
        break;
      case '5':
        // Gå tillbaka till huvudmenyn
        return;
      default:
        // Ogiltigt alternativ
        print('Ogiltigt val, försök igen.');
    }
  }
}

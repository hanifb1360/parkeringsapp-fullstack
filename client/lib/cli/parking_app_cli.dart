import 'dart:io';

import 'manage_persons.dart';
import 'manage_vehicles.dart';
import 'manage_parking_spaces.dart';
import 'manage_parkings.dart';

Future<void> runCLI() async {
  while (true) {
    print('\nVälkommen till Parkeringsappen!');
    print('Vad vill du hantera?');
    print('1. Personer');
    print('2. Fordon');
    print('3. Parkeringsplatser');
    print('4. Parkeringar');
    print('5. Avsluta');
    stdout.write('Välj ett alternativ (1-5): ');
    var choice = stdin.readLineSync();

    switch (choice) {
      case '1':
        print('Navigating to managePersons...');
        await managePersons();
        break;
      case '2':
        print('Navigating to manageVehicles...');
        await manageVehicles();
        break;
      case '3':
        print('Navigating to manageParkingSpaces...');
        await manageParkingSpaces();
        break;
      case '4':
        print('Navigating to manageParkings...');
        await manageParkings();
        break;
      case '5':
        print('Avslutar...');
        return;
      default:
        print('Ogiltigt val, försök igen.');
    }
  }
}

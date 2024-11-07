import 'dart:io';
import '../repositories/vehicle_repository.dart';
import '../repositories/person_repository.dart';
import 'vehicle_search.dart';
import '../models/vehicle.dart';

void manageVehicles() async {
  final vehicleRepo = VehicleRepository();
  final personRepo = PersonRepository();

  print('\nDu har valt att hantera Fordon.');
  print('1. Skapa nytt fordon');
  print('2. Visa alla fordon');
  print('3. Uppdatera fordon');
  print('4. Ta bort fordon');
  print('5. Sök fordon efter ägare');
  print('6. Gå tillbaka till huvudmenyn');
  stdout.write('Välj ett alternativ (1-6): ');
  var choice = stdin.readLineSync();

  switch (choice) {
    case '1':
      stdout.write('Ange registreringsnummer: ');
      var registrationNumber = stdin.readLineSync();
      stdout.write('Ange modell (bil, motorcykel, etc.): ');
      var model = stdin.readLineSync();
      stdout.write('Ange ägarens personnummer: ');
      var ownerPersonalNumber = stdin.readLineSync();

      var owner =
          await personRepo.getById(ownerPersonalNumber!); // Fetch owner by ID
      if (owner == null) {
        print('Ägaren hittades inte.');
        return;
      }

      var vehicle = Vehicle(
        regNumber: registrationNumber!,
        ownerPersonalNumber: ownerPersonalNumber,
        model: model!,
      );
      await vehicleRepo.createVehicle(vehicle);
      print('Fordon skapad: $vehicle');
      break;

    case '2':
      var vehicles = await vehicleRepo.fetchAll();
      if (vehicles.isEmpty) {
        print('Inga fordon registrerade.');
      } else {
        for (var vehicle in vehicles) {
          print(vehicle);
        }
      }
      break;

    case '3':
      stdout
          .write('Ange registreringsnummer för det fordon du vill uppdatera: ');
      var registrationNumber = stdin.readLineSync();
      var vehicle =
          await vehicleRepo.getById(registrationNumber!); // Fetch by reg number

      if (vehicle == null) {
        print('Fordon hittades inte.');
        return;
      }

      stdout.write('Ange ny modell (bil, motorcykel, etc.): ');
      var newModel = stdin.readLineSync();
      vehicle.model = newModel!;

      await vehicleRepo.updateVehicle(vehicle.regNumber, vehicle);
      print('Fordon uppdaterad: $vehicle');
      break;

    case '4':
      stdout.write('Ange registreringsnummer för det fordon du vill ta bort: ');
      var registrationNumber = stdin.readLineSync();
      await vehicleRepo
          .deleteVehicle(registrationNumber!); // Use registrationNumber
      print('Fordon borttagen.');
      break;

    case '5':
      await searchVehiclesByOwner(vehicleRepo);
      break;

    case '6':
      return;

    default:
      print('Ogiltigt val, försök igen.');
  }
}

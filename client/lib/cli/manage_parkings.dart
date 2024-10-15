import 'dart:io';
import '../repositories/parking_repository.dart';
import '../repositories/vehicle_repository.dart';
import '../repositories/parking_space_repository.dart';
import '../models/parking.dart';

// Funktion för att hantera parkeringar
void manageParkings() {
  final parkingRepo = ParkingRepository(); // Singleton-instans
  final vehicleRepo = VehicleRepository(); // Singleton-instans
  final parkingSpaceRepo = ParkingSpaceRepository(); // Singleton-instans

  print('\nDu har valt att hantera Parkeringar.');
  print('1. Skapa ny parkering');
  print('2. Visa alla parkeringar');
  print('3. Uppdatera parkering');
  print('4. Ta bort parkering');
  print('5. Gå tillbaka till huvudmenyn');
  stdout.write('Välj ett alternativ (1-5): ');
  var choice = stdin.readLineSync();

  switch (choice) {
    case '1':
      // Skapa ny parkering
      stdout.write('Ange fordonets registreringsnummer: ');
      var regNumber = stdin.readLineSync();
      var vehicle = vehicleRepo.getById(regNumber!); // Use getById instead
      stdout.write('Ange parkeringsplatsens ID: ');
      var parkingSpaceId = stdin.readLineSync();
      var parkingSpace =
          parkingSpaceRepo.getById(parkingSpaceId!); // Use getById
      var parking = Parking(
          vehicle: vehicle,
          parkingSpace: parkingSpace,
          startTime: DateTime.now(),
          endTime: null);
      parkingRepo.add(parking);
      print('Parkering skapad: $parking');
      break;

    case '2':
      // Visa alla parkeringar
      var parkings = parkingRepo.getAll();
      if (parkings.isEmpty) {
        print('Inga parkeringar registrerade.');
      } else {
        for (var parking in parkings) {
          print(parking);
        }
      }
      break;

    case '3':
      // Uppdatera och avsluta parkering
      stdout.write(
          'Ange fordonets registreringsnummer för den parkering du vill uppdatera: ');
      var regNumber = stdin.readLineSync();
      var parking = parkingRepo.getById(regNumber!); // Use getById
      stdout.write('Vill du avsluta parkeringen? (j/n): ');
      var shouldEnd = stdin.readLineSync();
      if (shouldEnd == 'j') {
        endParking(parking);
      } else {
        print('Parkeringen avslutas inte.');
      }
      break;

    case '4':
      // Ta bort parkering
      stdout.write(
          'Ange fordonets registreringsnummer för den parkering du vill ta bort: ');
      var regNumber = stdin.readLineSync();
      parkingRepo.delete(regNumber!); // Use regNumber as id
      print('Parkering borttagen.');
      break;

    case '5':
      // Gå tillbaka till huvudmenyn
      return;

    default:
      print('Ogiltigt val, försök igen.');
  }
}

// Funktion för att avsluta en parkering och beräkna kostnaden
void endParking(Parking parking) {
  final parkingRepo = ParkingRepository(); // Singleton-instans
  parking.endTime = DateTime.now(); // Sätt sluttid till nu
  parkingRepo.update(parking); // Uppdatera parkeringen i lagret
  print('Parkering avslutad.');

  // Beräkna kostnaden
  double cost = parking.calculateCost();
  print('Total kostnad: $cost SEK');
}

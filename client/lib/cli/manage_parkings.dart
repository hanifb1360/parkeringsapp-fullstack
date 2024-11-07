import 'dart:io';
import '../repositories/parking_repository.dart';
import '../repositories/vehicle_repository.dart';
import '../repositories/parking_space_repository.dart';
import '../models/parking.dart';

Future<void> manageParkings() async {
  final parkingRepo = ParkingRepository();
  final vehicleRepo = VehicleRepository();
  final parkingSpaceRepo = ParkingSpaceRepository();

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
      var vehicle =
          await vehicleRepo.getById(regNumber!); // Fetch vehicle by ID
      stdout.write('Ange parkeringsplatsens ID: ');
      var parkingSpaceId = stdin.readLineSync();
      var parkingSpace = await parkingSpaceRepo
          .getById(parkingSpaceId!); // Fetch parking space by ID

      if (vehicle == null || parkingSpace == null) {
        print('Ogiltigt fordon eller parkeringsplats.');
        break;
      }

      String parkingId = DateTime.now()
          .millisecondsSinceEpoch
          .toString(); // Generate parking ID

      var parking = Parking(
        id: parkingId, // Set the ID
        parkingSpaceId: parkingSpaceId,
        vehicleRegNumber: regNumber,
        startTime: DateTime.now(),
        endTime: null, // Initially, endTime is null
      );

      await parkingRepo.createParking(parking);
      print('Parkering skapad: $parking');
      break;

    case '2':
      // Visa alla parkeringar
      var parkings = await parkingRepo.fetchAll(); // Fetch all parkings
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
      var parking =
          await parkingRepo.getById(regNumber!); // Fetch parking by vehicle ID
      if (parking == null) {
        print('Ingen parkering hittades.');
        break;
      }

      stdout.write('Vill du avsluta parkeringen? (j/n): ');
      var shouldEnd = stdin.readLineSync();
      if (shouldEnd == 'j') {
        await endParking(parkingRepo, parking); // Pass parkingRepo and parking
      } else {
        print('Parkeringen avslutas inte.');
      }
      break;

    case '4':
      // Ta bort parkering
      stdout.write(
          'Ange fordonets registreringsnummer för den parkering du vill ta bort: ');
      var regNumber = stdin.readLineSync();
      await parkingRepo
          .deleteParking(regNumber!); // Delete parking by vehicle ID
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
Future<void> endParking(ParkingRepository parkingRepo, Parking parking) async {
  parking.endTime = DateTime.now(); // Set the end time to now
  await parkingRepo.updateParking(
      parking.id, parking); // Update the parking in the repository
  print('Parkering avslutad.');

  // Beräkna kostnaden
  double cost = parking.calculateCost();
  print('Total kostnad: $cost SEK');
}

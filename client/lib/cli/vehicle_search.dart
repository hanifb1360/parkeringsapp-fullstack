import 'dart:io';
import '../repositories/vehicle_repository.dart';

// Funktion för att söka efter fordon via ägare
Future<void> searchVehiclesByOwner(VehicleRepository vehicleRepo) async {
  stdout.write('Ange ägarens personnummer för att söka efter fordon: ');
  var ownerPersonalNumber = stdin.readLineSync();

  if (ownerPersonalNumber != null && ownerPersonalNumber.isNotEmpty) {
    var vehicles = await vehicleRepo.getByOwner(ownerPersonalNumber);

    if (vehicles.isEmpty) {
      print('Inga fordon hittades för den ägaren.');
    } else {
      for (var vehicle in vehicles) {
        print(vehicle);
      }
    }
  } else {
    print('Fel: Ange ett giltigt personnummer.');
  }
}

import 'dart:io';
import '../repositories/parking_space_repository.dart';
import '../models/parking_space.dart';

Future<void> manageParkingSpaces() async {
  final repository = ParkingSpaceRepository();

  print('\nDu har valt att hantera Parkeringsplatser.');
  print('1. Skapa ny parkeringsplats');
  print('2. Visa alla parkeringsplatser');
  print('3. Uppdatera parkeringsplats');
  print('4. Ta bort parkeringsplats');
  print('5. Gå tillbaka till huvudmenyn');
  stdout.write('Välj ett alternativ (1-5): ');
  var choice = stdin.readLineSync();

  switch (choice) {
    case '1':
      // Skapa ny parkeringsplats
      stdout.write('Ange ID: ');
      var id = stdin.readLineSync();
      if (id == null || id.isEmpty) {
        print('Ogiltigt ID, försök igen.');
        break;
      }
      stdout.write('Ange adress: ');
      var address = stdin.readLineSync();
      if (address == null || address.isEmpty) {
        print('Ogiltig adress, försök igen.');
        break;
      }
      stdout.write('Ange pris per timme: ');
      var pricePerHour = double.tryParse(stdin.readLineSync() ?? '');
      if (pricePerHour == null) {
        print('Ogiltigt pris, försök igen.');
        break;
      }
      var parkingSpace =
          ParkingSpace(id: id, address: address, pricePerHour: pricePerHour);
      await repository.createParkingSpace(parkingSpace);
      print('Parkeringsplats skapad: $parkingSpace');
      break;

    case '2':
      // Visa alla parkeringsplatser
      var parkingSpaces = await repository.fetchAll();
      if (parkingSpaces.isEmpty) {
        print('Inga parkeringsplatser registrerade.');
      } else {
        for (var parkingSpace in parkingSpaces) {
          print(parkingSpace);
        }
      }
      break;

    case '3':
      // Uppdatera parkeringsplats
      stdout.write('Ange ID för den parkeringsplats du vill uppdatera: ');
      var id = stdin.readLineSync();
      if (id == null || id.isEmpty) {
        print('Ogiltigt ID, försök igen.');
        break;
      }
      var parkingSpace = await repository.getById(id);
      if (parkingSpace == null) {
        print('Ingen parkeringsplats hittades med det ID:t.');
        break;
      }
      stdout.write('Ange ny adress: ');
      var newAddress = stdin.readLineSync();
      if (newAddress == null || newAddress.isEmpty) {
        print('Ogiltig adress, försök igen.');
        break;
      }
      stdout.write('Ange nytt pris per timme: ');
      var newPricePerHour = double.tryParse(stdin.readLineSync() ?? '');
      if (newPricePerHour == null) {
        print('Ogiltigt pris, försök igen.');
        break;
      }
      parkingSpace.address = newAddress;
      parkingSpace.pricePerHour = newPricePerHour;
      await repository.updateParkingSpace(id, parkingSpace);
      print('Parkeringsplats uppdaterad: $parkingSpace');
      break;

    case '4':
      // Ta bort parkeringsplats
      stdout.write('Ange ID för den parkeringsplats du vill ta bort: ');
      var id = stdin.readLineSync();
      if (id == null || id.isEmpty) {
        print('Ogiltigt ID, försök igen.');
        break;
      }
      await repository.deleteParkingSpace(id);
      print('Parkeringsplats borttagen.');
      break;

    case '5':
      // Gå tillbaka till huvudmenyn
      return;

    default:
      print('Ogiltigt val, försök igen.');
  }
}

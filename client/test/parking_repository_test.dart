import 'package:test/test.dart';
import 'package:parkeringsapp/repositories/parking_repository.dart';
import 'package:parkeringsapp/models/parking.dart';
import 'package:parkeringsapp/models/vehicle.dart';
import 'package:parkeringsapp/models/parking_space.dart';
import 'package:parkeringsapp/models/person.dart';

void main() {
  group('ParkingRepository', () {
    final repository = ParkingRepository();

    // Rensa lagret före varje test
    setUp(() {
      repository.clear();
    });

    test('should add a parking', () {
      final owner = Person(personalNumber: '123', name: 'John Doe');
      final vehicle =
          Vehicle(registrationNumber: 'ABC123', owner: owner, type: 'Car');
      final parkingSpace =
          ParkingSpace(id: 'PS123', address: 'Main St', pricePerHour: 10.0);
      final parking = Parking(
          vehicle: vehicle,
          parkingSpace: parkingSpace,
          startTime: DateTime.now());
      repository.add(parking);

      final allParkings = repository.getAll();
      expect(allParkings, contains(parking));
    });

    test('should retrieve all parkings', () {
      final owner1 = Person(personalNumber: '123', name: 'John Doe');
      final vehicle1 =
          Vehicle(registrationNumber: 'ABC123', owner: owner1, type: 'Car');
      final parkingSpace1 =
          ParkingSpace(id: 'PS123', address: 'Main St', pricePerHour: 10.0);
      final parking1 = Parking(
          vehicle: vehicle1,
          parkingSpace: parkingSpace1,
          startTime: DateTime.now());

      final owner2 = Person(personalNumber: '456', name: 'Jane Doe');
      final vehicle2 =
          Vehicle(registrationNumber: 'DEF456', owner: owner2, type: 'Car');
      final parkingSpace2 =
          ParkingSpace(id: 'PS456', address: 'Broadway', pricePerHour: 12.0);
      final parking2 = Parking(
          vehicle: vehicle2,
          parkingSpace: parkingSpace2,
          startTime: DateTime.now());

      repository.add(parking1);
      repository.add(parking2);

      final allParkings = repository.getAll();
      expect(allParkings.length, equals(2));
      expect(allParkings, containsAll([parking1, parking2]));
    });

    test(
        'should retrieve a parking by vehicle registration number (using getById)',
        () {
      final owner = Person(personalNumber: '123', name: 'John Doe');
      final vehicle =
          Vehicle(registrationNumber: 'ABC123', owner: owner, type: 'Car');
      final parkingSpace =
          ParkingSpace(id: 'PS123', address: 'Main St', pricePerHour: 10.0);
      final parking = Parking(
          vehicle: vehicle,
          parkingSpace: parkingSpace,
          startTime: DateTime.now());
      repository.add(parking);

      // Använd getById istället för getByVehicleRegistration
      final retrievedParking = repository.getById('ABC123');
      expect(retrievedParking, equals(parking));
    });

    test('should update a parking', () {
      final owner = Person(personalNumber: '123', name: 'John Doe');
      final vehicle =
          Vehicle(registrationNumber: 'ABC123', owner: owner, type: 'Car');
      final parkingSpace =
          ParkingSpace(id: 'PS123', address: 'Main St', pricePerHour: 10.0);
      final parking = Parking(
          vehicle: vehicle,
          parkingSpace: parkingSpace,
          startTime: DateTime.now());
      repository.add(parking);

      final updatedParking = Parking(
          vehicle: vehicle,
          parkingSpace: parkingSpace,
          startTime: parking.startTime,
          endTime: DateTime.now());
      repository.update(updatedParking);

      // Använd getById istället för getByVehicleRegistration
      final retrievedParking = repository.getById('ABC123');
      expect(retrievedParking.endTime, isNotNull);
    });

    test('should delete a parking', () {
      final owner = Person(personalNumber: '123', name: 'John Doe');
      final vehicle =
          Vehicle(registrationNumber: 'ABC123', owner: owner, type: 'Car');
      final parkingSpace =
          ParkingSpace(id: 'PS123', address: 'Main St', pricePerHour: 10.0);
      final parking = Parking(
          vehicle: vehicle,
          parkingSpace: parkingSpace,
          startTime: DateTime.now());
      repository.add(parking);

      repository.delete('ABC123');

      // Använd getById istället för getByVehicleRegistration
      expect(() => repository.getById('ABC123'), throwsA(isA<Exception>()));
    });
  });
}

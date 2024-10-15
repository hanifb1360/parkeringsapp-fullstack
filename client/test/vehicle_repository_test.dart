import 'package:test/test.dart';
import 'package:parkeringsapp/repositories/vehicle_repository.dart';
import 'package:parkeringsapp/models/vehicle.dart';
import 'package:parkeringsapp/models/person.dart';

void main() {
  group('VehicleRepository', () {
    final repository = VehicleRepository();

    // Clear the repository before each test
    setUp(() {
      repository.clear();
    });

    test('should add a vehicle', () {
      final owner = Person(personalNumber: '123', name: 'John Doe');
      final vehicle =
          Vehicle(registrationNumber: 'ABC123', owner: owner, type: 'Car');
      repository.add(vehicle);

      final allVehicles = repository.getAll();
      expect(allVehicles, contains(vehicle));
    });

    test('should retrieve all vehicles', () {
      final owner1 = Person(personalNumber: '123', name: 'John Doe');
      final owner2 = Person(personalNumber: '456', name: 'Jane Doe');
      final vehicle1 =
          Vehicle(registrationNumber: 'ABC123', owner: owner1, type: 'Car');
      final vehicle2 =
          Vehicle(registrationNumber: 'DEF456', owner: owner2, type: 'Car');
      repository.add(vehicle1);
      repository.add(vehicle2);

      final allVehicles = repository.getAll();
      expect(allVehicles.length, 2);
      expect(allVehicles, containsAll([vehicle1, vehicle2]));
    });

    test('should retrieve a vehicle by registration number (using getById)',
        () {
      final owner = Person(personalNumber: '123', name: 'John Doe');
      final vehicle =
          Vehicle(registrationNumber: 'ABC123', owner: owner, type: 'Car');
      repository.add(vehicle);

      // Use getById instead of getByRegistrationNumber
      final retrievedVehicle = repository.getById('ABC123');
      expect(retrievedVehicle, equals(vehicle));
    });

    test('should retrieve vehicles by owner', () {
      final owner = Person(personalNumber: '123', name: 'John Doe');
      final vehicle1 =
          Vehicle(registrationNumber: 'ABC123', owner: owner, type: 'Car');
      final vehicle2 =
          Vehicle(registrationNumber: 'DEF456', owner: owner, type: 'Car');
      repository.add(vehicle1);
      repository.add(vehicle2);

      final vehiclesByOwner = repository.getByOwner('123');
      expect(vehiclesByOwner.length, 2);
      expect(vehiclesByOwner, containsAll([vehicle1, vehicle2]));
    });

    test('should update a vehicle', () {
      final owner = Person(personalNumber: '123', name: 'John Doe');
      final vehicle =
          Vehicle(registrationNumber: 'ABC123', owner: owner, type: 'Car');
      repository.add(vehicle);

      final updatedVehicle =
          Vehicle(registrationNumber: 'ABC123', owner: owner, type: 'SUV');
      repository.update(updatedVehicle);

      // Use getById instead of getByRegistrationNumber
      final retrievedVehicle = repository.getById('ABC123');
      expect(retrievedVehicle.type, 'SUV'); // Update should be reflected
    });

    test('should delete a vehicle', () {
      final owner = Person(personalNumber: '123', name: 'John Doe');
      final vehicle =
          Vehicle(registrationNumber: 'ABC123', owner: owner, type: 'Car');
      repository.add(vehicle);

      repository.delete('ABC123');

      // Use getById instead of getByRegistrationNumber
      expect(() => repository.getById('ABC123'), throwsA(isA<Exception>()));
    });
  });
}

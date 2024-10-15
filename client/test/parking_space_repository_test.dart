import 'package:test/test.dart';
import 'package:parkeringsapp/repositories/parking_space_repository.dart';
import 'package:parkeringsapp/models/parking_space.dart';

void main() {
  group('ParkingSpaceRepository', () {
    final repository = ParkingSpaceRepository();

    // Clear the repository before each test
    setUp(() {
      repository.clear();
    });

    test('should add a parking space', () {
      final parkingSpace =
          ParkingSpace(id: 'PS123', address: 'Main St', pricePerHour: 10.0);
      repository.add(parkingSpace);

      final allParkingSpaces = repository.getAll();
      expect(allParkingSpaces, contains(parkingSpace));
    });

    test('should retrieve all parking spaces', () {
      final parkingSpace1 =
          ParkingSpace(id: 'PS123', address: 'Main St', pricePerHour: 10.0);
      final parkingSpace2 =
          ParkingSpace(id: 'PS456', address: 'Broadway', pricePerHour: 12.0);
      repository.add(parkingSpace1);
      repository.add(parkingSpace2);

      final allParkingSpaces = repository.getAll();
      expect(allParkingSpaces.length, equals(2));
      expect(allParkingSpaces, containsAll([parkingSpace1, parkingSpace2]));
    });

    test('should retrieve a parking space by ID', () {
      final parkingSpace =
          ParkingSpace(id: 'PS123', address: 'Main St', pricePerHour: 10.0);
      repository.add(parkingSpace);

      final retrievedParkingSpace = repository.getById('PS123');
      expect(retrievedParkingSpace, equals(parkingSpace));
    });

    test('should update a parking space', () {
      final parkingSpace =
          ParkingSpace(id: 'PS123', address: 'Main St', pricePerHour: 10.0);
      repository.add(parkingSpace);

      final updatedParkingSpace =
          ParkingSpace(id: 'PS123', address: 'Main St', pricePerHour: 15.0);
      repository.update(updatedParkingSpace);

      final retrievedParkingSpace = repository.getById('PS123');
      expect(retrievedParkingSpace.pricePerHour, equals(15.0));
    });

    test('should delete a parking space', () {
      final parkingSpace =
          ParkingSpace(id: 'PS123', address: 'Main St', pricePerHour: 10.0);
      repository.add(parkingSpace);

      repository.delete('PS123');

      expect(() => repository.getById('PS123'), throwsA(isA<Exception>()));
    });
  });
}

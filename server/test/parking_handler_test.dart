import 'dart:convert';
import 'package:shelf/shelf.dart';
import 'package:test/test.dart';
import 'package:server/handlers/parking_handler.dart';
import 'package:server/repositories/parking_repository.dart';
import 'package:server/models/parking.dart';
import 'package:server/objectbox.g.dart';
import 'dart:io';

class MockParkingRepository extends ParkingRepository {
  MockParkingRepository(super.box);

  @override
  Future<List<Parking>> getAll() async {
    return [
      Parking(
          id: 1,
          vehicleRegNumber: 'XYZ 123',
          spaceNumber: 'A1',
          startTime: DateTime.now())
    ];
  }

  @override
  Future<Parking?> getById(int id) async {
    return id == 1
        ? Parking(
            id: 1,
            vehicleRegNumber: 'XYZ 123',
            spaceNumber: 'A1',
            startTime: DateTime.now())
        : null;
  }

  @override
  Future<Parking> create(Parking parking) async {
    return parking;
  }

  @override
  Future<Parking> update(int id, Parking updatedParking) async {
    if (id == 1) {
      return updatedParking;
    } else {
      throw Exception('Parking not found');
    }
  }

  @override
  Future<Parking> delete(int id) async {
    if (id == 1) {
      return Parking(
          id: 1,
          vehicleRegNumber: 'XYZ 123',
          spaceNumber: 'A1',
          startTime: DateTime.now());
    } else {
      throw Exception('Parking not found');
    }
  }
}

void main() {
  late MockParkingRepository mockRepository;
  late ParkingHandler handler;
  late Store store;

  setUp(() {
    store = Store(
      getObjectBoxModel(),
      directory: './objectbox_test_${DateTime.now().millisecondsSinceEpoch}',
    );
    final box = store.box<Parking>();
    mockRepository = MockParkingRepository(box);
    handler = ParkingHandler(mockRepository);
  });

  tearDown(() {
    store.close();
    Directory(store.directoryPath).deleteSync(recursive: true);
  });

  test('GET /parkings returns a list of parkings', () async {
    final request = Request('GET', Uri.parse('http://localhost/parkings'));
    final response = await handler.getAll(request);

    expect(response.statusCode, equals(200));
    expect(await response.readAsString(), contains('XYZ 123'));
  });

  test('GET /parkings/<id> returns a parking if found', () async {
    final request = Request('GET', Uri.parse('http://localhost/parkings/1'));
    final response = await handler.getById(request, '1');

    expect(response.statusCode, equals(200));
    expect(await response.readAsString(), contains('XYZ 123'));
  });

  test('POST /parkings creates a new parking', () async {
    final payload = jsonEncode({
      'vehicleRegNumber': 'XYZ 123',
      'spaceNumber': 'A2',
      'startTime': DateTime.now().toIso8601String()
    });
    final request =
        Request('POST', Uri.parse('http://localhost/parkings'), body: payload);
    final response = await handler.create(request);

    expect(response.statusCode, equals(201));
    expect(await response.readAsString(), contains('Parking created'));
  });

  test('PUT /parkings/<id> updates a parking if found', () async {
    final payload = jsonEncode({
      'vehicleRegNumber': 'XYZ 123',
      'spaceNumber': 'A1',
      'startTime': DateTime.now().toIso8601String()
    });
    final request =
        Request('PUT', Uri.parse('http://localhost/parkings/1'), body: payload);
    final response = await handler.update(request, '1');

    expect(response.statusCode, equals(200));
    expect(await response.readAsString(), contains('Parking updated'));
  });

  test('DELETE /parkings/<id> deletes a parking if found', () async {
    final request = Request('DELETE', Uri.parse('http://localhost/parkings/1'));
    final response = await handler.delete(request, '1');

    expect(response.statusCode, equals(200));
    expect(await response.readAsString(), contains('Parking deleted'));
  });
}

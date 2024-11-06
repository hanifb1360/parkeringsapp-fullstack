import 'dart:convert';
import 'package:shelf/shelf.dart';
import 'package:test/test.dart';
import 'package:server/handlers/vehicle_handler.dart';
import 'package:server/repositories/vehicle_repository.dart';
import 'package:server/models/vehicle.dart';
import 'package:server/objectbox.g.dart';
import 'dart:io';

class MockVehicleRepository extends VehicleRepository {
  MockVehicleRepository(super.box);

  @override
  Future<List<Vehicle>> getAll() async {
    return [
      Vehicle(id: 1, licensePlate: 'XYZ 123', model: 'Sedan', color: 'Blue')
    ];
  }

  @override
  Future<Vehicle?> getById(int id) async {
    return id == 1
        ? Vehicle(id: 1, licensePlate: 'XYZ 123', model: 'Sedan', color: 'Blue')
        : null;
  }

  @override
  Future<Vehicle> create(Vehicle vehicle) async {
    return vehicle;
  }

  @override
  Future<Vehicle> update(int id, Vehicle updatedVehicle) async {
    if (id == 1) {
      return updatedVehicle;
    } else {
      throw Exception('Vehicle not found');
    }
  }

  @override
  Future<Vehicle> delete(int id) async {
    if (id == 1) {
      return Vehicle(
          id: 1, licensePlate: 'XYZ 123', model: 'Sedan', color: 'Blue');
    } else {
      throw Exception('Vehicle not found');
    }
  }
}

void main() {
  late MockVehicleRepository mockRepository;
  late VehicleHandler handler;
  late Store store;

  setUp(() {
    store = Store(
      getObjectBoxModel(),
      directory: './objectbox_test_${DateTime.now().millisecondsSinceEpoch}',
    );
    final box = store.box<Vehicle>();
    mockRepository = MockVehicleRepository(box);
    handler = VehicleHandler(mockRepository);
  });

  tearDown(() {
    store.close();
    Directory(store.directoryPath).deleteSync(recursive: true);
  });

  test('GET /vehicles returns a list of vehicles', () async {
    final request = Request('GET', Uri.parse('http://localhost/vehicles'));
    final response = await handler.getAll(request);

    expect(response.statusCode, equals(200));
    expect(await response.readAsString(), contains('XYZ 123'));
  });

  test('GET /vehicles/<id> returns a vehicle if found', () async {
    final request = Request('GET', Uri.parse('http://localhost/vehicles/1'));
    final response = await handler.getById(request, '1');

    expect(response.statusCode, equals(200));
    expect(await response.readAsString(), contains('XYZ 123'));
  });

  test('GET /vehicles/<id> returns 404 if not found', () async {
    final request = Request('GET', Uri.parse('http://localhost/vehicles/2'));
    final response = await handler.getById(request, '2');

    expect(response.statusCode, equals(404));
  });

  test('POST /vehicles creates a new vehicle', () async {
    final payload = jsonEncode(
        {'licensePlate': 'ABC 987', 'model': 'SUV', 'color': 'Black'});
    final request =
        Request('POST', Uri.parse('http://localhost/vehicles'), body: payload);
    final response = await handler.create(request);

    expect(response.statusCode, equals(201));
    expect(await response.readAsString(), contains('Vehicle created'));
  });

  test('PUT /vehicles/<id> updates a vehicle if found', () async {
    final payload = jsonEncode(
        {'licensePlate': 'XYZ 123', 'model': 'Sedan', 'color': 'Blue'});
    final request =
        Request('PUT', Uri.parse('http://localhost/vehicles/1'), body: payload);
    final response = await handler.update(request, '1');

    expect(response.statusCode, equals(200));
    expect(await response.readAsString(), contains('Vehicle updated'));
  });

  test('DELETE /vehicles/<id> deletes a vehicle if found', () async {
    final request = Request('DELETE', Uri.parse('http://localhost/vehicles/1'));
    final response = await handler.delete(request, '1');

    expect(response.statusCode, equals(200));
    expect(await response.readAsString(), contains('Vehicle deleted'));
  });
}

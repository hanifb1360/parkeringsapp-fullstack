import 'dart:convert';
import 'package:shelf/shelf.dart';
import 'package:test/test.dart';
import 'package:server/handlers/parking_space_handler.dart';
import 'package:server/repositories/parking_space_repository.dart';
import 'package:server/models/parking_space.dart';
import 'package:server/objectbox.g.dart';
import 'dart:io';

class MockParkingSpaceRepository extends ParkingSpaceRepository {
  MockParkingSpaceRepository(super.box);

  @override
  Future<List<ParkingSpace>> getAll() async {
    return [ParkingSpace(id: 1, spaceNumber: 'A1', isOccupied: false)];
  }

  @override
  Future<ParkingSpace?> getById(int id) async {
    return id == 1
        ? ParkingSpace(id: 1, spaceNumber: 'A1', isOccupied: false)
        : null;
  }

  @override
  Future<ParkingSpace> create(ParkingSpace space) async {
    return space;
  }

  @override
  Future<ParkingSpace> update(int id, ParkingSpace updatedSpace) async {
    if (id == 1) {
      return updatedSpace;
    } else {
      throw Exception('Parking space not found');
    }
  }

  @override
  Future<ParkingSpace> delete(int id) async {
    if (id == 1) {
      return ParkingSpace(id: 1, spaceNumber: 'A1', isOccupied: false);
    } else {
      throw Exception('Parking space not found');
    }
  }
}

void main() {
  late MockParkingSpaceRepository mockRepository;
  late ParkingSpaceHandler handler;
  late Store store;

  setUp(() {
    store = Store(
      getObjectBoxModel(),
      directory: './objectbox_test_${DateTime.now().millisecondsSinceEpoch}',
    );
    final box = store.box<ParkingSpace>();
    mockRepository = MockParkingSpaceRepository(box);
    handler = ParkingSpaceHandler(mockRepository);
  });

  tearDown(() {
    store.close();
    Directory(store.directoryPath).deleteSync(recursive: true);
  });

  test('GET /parking-spaces returns a list of parking spaces', () async {
    final request =
        Request('GET', Uri.parse('http://localhost/parking-spaces'));
    final response = await handler.getAll(request);

    expect(response.statusCode, equals(200));
    expect(await response.readAsString(), contains('A1'));
  });

  test('GET /parking-spaces/<id> returns a parking space if found', () async {
    final request =
        Request('GET', Uri.parse('http://localhost/parking-spaces/1'));
    final response = await handler.getById(request, '1');

    expect(response.statusCode, equals(200));
    expect(await response.readAsString(), contains('A1'));
  });

  test('POST /parking-spaces creates a new parking space', () async {
    final payload = jsonEncode({'spaceNumber': 'A2', 'isOccupied': false});
    final request = Request(
        'POST', Uri.parse('http://localhost/parking-spaces'),
        body: payload);
    final response = await handler.create(request);

    expect(response.statusCode, equals(201));
    expect(await response.readAsString(), contains('Parking space created'));
  });

  test('PUT /parking-spaces/<id> updates a parking space if found', () async {
    final payload = jsonEncode({'spaceNumber': 'A1', 'isOccupied': true});
    final request = Request(
        'PUT', Uri.parse('http://localhost/parking-spaces/1'),
        body: payload);
    final response = await handler.update(request, '1');

    expect(response.statusCode, equals(200));
    expect(await response.readAsString(), contains('Parking space updated'));
  });

  test('DELETE /parking-spaces/<id> deletes a parking space if found',
      () async {
    final request =
        Request('DELETE', Uri.parse('http://localhost/parking-spaces/1'));
    final response = await handler.delete(request, '1');

    expect(response.statusCode, equals(200));
    expect(await response.readAsString(), contains('Parking space deleted'));
  });
}

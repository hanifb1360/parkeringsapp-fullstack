import 'dart:io';
import 'package:server/objectbox.g.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart';
import 'package:shelf_router/shelf_router.dart';
import 'package:server/repositories/person_repository.dart';
import 'package:server/repositories/vehicle_repository.dart';
import 'package:server/repositories/parking_repository.dart';
import 'package:server/repositories/parking_space_repository.dart';
import 'package:server/models/person.dart';
import 'package:server/models/vehicle.dart';
import 'package:server/models/parking.dart';
import 'package:server/models/parking_space.dart';

// Declare repositories
late final PersonRepository personRepository;
late final VehicleRepository vehicleRepository;
late final ParkingRepository parkingRepository;
late final ParkingSpaceRepository parkingSpaceRepository;

// Initialize router
final _router = Router()
  ..get('/', _rootHandler)
  ..get('/echo/<message>', _echoHandler)
  ..get('/persons', _getAllPersonsHandler)
  ..post('/persons', _createPersonHandler)
  ..get('/persons/<id>', _getPersonByIdHandler)
  ..put('/persons/<id>', _updatePersonHandler)
  ..delete('/persons/<id>', _deletePersonHandler)
  ..get('/vehicles', _getAllVehiclesHandler)
  ..post('/vehicles', _createVehicleHandler)
  ..get('/vehicles/<id>', _getVehicleByIdHandler)
  ..put('/vehicles/<id>', _updateVehicleHandler)
  ..delete('/vehicles/<id>', _deleteVehicleHandler)
  ..get('/parkings', _getAllParkingsHandler)
  ..post('/parkings', _createParkingHandler)
  ..get('/parkings/<id>', _getParkingByIdHandler)
  ..put('/parkings/<id>', _updateParkingHandler)
  ..delete('/parkings/<id>', _deleteParkingHandler)
  ..get('/parking-spaces', _getAllParkingSpacesHandler)
  ..post('/parking-spaces', _createParkingSpaceHandler)
  ..get('/parking-spaces/<id>', _getParkingSpaceByIdHandler)
  ..put('/parking-spaces/<id>', _updateParkingSpaceHandler)
  ..delete('/parking-spaces/<id>', _deleteParkingSpaceHandler);

// Root handler
Response _rootHandler(Request req) {
  return Response.ok('Hello, World!\n');
}

Response _echoHandler(Request request) {
  final message = request.params['message'];
  return Response.ok('$message\n');
}

// Example handlers for PersonRepository
Future<Response> _getAllPersonsHandler(Request request) async {
  final persons = await personRepository.getAll();
  return Response.ok(persons.toString()); // Modify as per your serialization
}

Future<Response> _createPersonHandler(Request request) async {
  final person = Person(
      name: "New Person", personalNumber: "1234567890"); // Parse request data
  await personRepository.create(person);
  return Response.ok('Person created');
}

Future<Response> _getPersonByIdHandler(Request request) async {
  final id = int.parse(request.params['id']!);
  final person = await personRepository.getById(id);
  if (person != null) {
    return Response.ok(person.toString());
  } else {
    return Response.notFound('Person not found');
  }
}

Future<Response> _updatePersonHandler(Request request) async {
  final id = int.parse(request.params['id']!);
  final updatedPerson = Person(
      id: id,
      name: "Updated Person",
      personalNumber: "9876543210"); // Parse request
  final success = await personRepository.update(id, updatedPerson);
  return success
      ? Response.ok('Person updated')
      : Response.notFound('Person not found');
}

Future<Response> _deletePersonHandler(Request request) async {
  final id = int.parse(request.params['id']!);
  final success = await personRepository.delete(id);
  return success
      ? Response.ok('Person deleted')
      : Response.notFound('Person not found');
}

// Vehicle Handlers
Future<Response> _getAllVehiclesHandler(Request request) async {
  final vehicles = await vehicleRepository.getAll();
  return Response.ok(vehicles.toString());
}

Future<Response> _createVehicleHandler(Request request) async {
  final vehicle = Vehicle(
      regNumber: "ABC123", ownerPersonalNumber: "1234567890", model: "Sedan");
  await vehicleRepository.create(vehicle);
  return Response.ok('Vehicle created');
}

Future<Response> _getVehicleByIdHandler(Request request) async {
  final id = int.parse(request.params['id']!);
  final vehicle = await vehicleRepository.getById(id);
  if (vehicle != null) {
    return Response.ok(vehicle.toString());
  } else {
    return Response.notFound('Vehicle not found');
  }
}

Future<Response> _updateVehicleHandler(Request request) async {
  final id = int.parse(request.params['id']!);
  final updatedVehicle = Vehicle(
    id: id,
    regNumber: "Updated Reg",
    ownerPersonalNumber: "9876543210",
    model: "Updated Model",
  ); // Parse request
  final success = await vehicleRepository.update(id, updatedVehicle);
  return success
      ? Response.ok('Vehicle updated')
      : Response.notFound('Vehicle not found');
}

Future<Response> _deleteVehicleHandler(Request request) async {
  final id = int.parse(request.params['id']!);
  final success = await vehicleRepository.delete(id);
  return success
      ? Response.ok('Vehicle deleted')
      : Response.notFound('Vehicle not found');
}

// Parking Handlers
Future<Response> _getAllParkingsHandler(Request request) async {
  final parkings = await parkingRepository.getAll();
  return Response.ok(parkings.toString());
}

Future<Response> _createParkingHandler(Request request) async {
  final parking = Parking(
    vehicleRegNumber: "ABC123",
    spaceNumber: "1A",
    startTime: DateTime.now(), // Use appropriate DateTime value
  );
  await parkingRepository.create(parking);
  return Response.ok('Parking created');
}

Future<Response> _getParkingByIdHandler(Request request) async {
  final id = int.parse(request.params['id']!);
  final parking = await parkingRepository.getById(id);
  if (parking != null) {
    return Response.ok(parking.toString());
  } else {
    return Response.notFound('Parking not found');
  }
}

Future<Response> _updateParkingHandler(Request request) async {
  final id = int.parse(request.params['id']!);
  final updatedParking = Parking(
    id: id,
    vehicleRegNumber: "UpdatedRegNumber",
    spaceNumber: "UpdatedSpaceNumber",
    startTime: DateTime.now(), // Use appropriate DateTime value
  );
  final success = await parkingRepository.update(id, updatedParking);
  return success
      ? Response.ok('Parking updated')
      : Response.notFound('Parking not found');
}

Future<Response> _deleteParkingHandler(Request request) async {
  final id = int.parse(request.params['id']!);
  final success = await parkingRepository.delete(id);
  return success
      ? Response.ok('Parking deleted')
      : Response.notFound('Parking not found');
}

// ParkingSpace Handlers
Future<Response> _getAllParkingSpacesHandler(Request request) async {
  final parkingSpaces = await parkingSpaceRepository.getAll();
  return Response.ok(parkingSpaces.toString());
}

Future<Response> _createParkingSpaceHandler(Request request) async {
  final parkingSpace = ParkingSpace(
    spaceNumber: "NewSpaceNumber", // Provide the correct space number
    isOccupied: false, // Provide the correct occupancy status
  );
  await parkingSpaceRepository.create(parkingSpace);
  return Response.ok('ParkingSpace created');
}

Future<Response> _getParkingSpaceByIdHandler(Request request) async {
  final id = int.parse(request.params['id']!);
  final parkingSpace = await parkingSpaceRepository.getById(id);
  if (parkingSpace != null) {
    return Response.ok(parkingSpace.toString());
  } else {
    return Response.notFound('ParkingSpace not found');
  }
}

Future<Response> _updateParkingSpaceHandler(Request request) async {
  final id = int.parse(request.params['id']!);
  final updatedParkingSpace = ParkingSpace(
    id: id,
    spaceNumber: "UpdatedSpaceNumber", // Provide the correct space number
    isOccupied: false, // Provide the correct occupancy status
  );
  final success = await parkingSpaceRepository.update(id, updatedParkingSpace);
  return success
      ? Response.ok('ParkingSpace updated')
      : Response.notFound('ParkingSpace not found');
}

Future<Response> _deleteParkingSpaceHandler(Request request) async {
  final id = int.parse(request.params['id']!);
  final success = await parkingSpaceRepository.delete(id);
  return success
      ? Response.ok('ParkingSpace deleted')
      : Response.notFound('ParkingSpace not found');
}

// Main function to start the server and initialize ObjectBox
void main(List<String> args) async {
  // Initialize ObjectBox store
  final store = Store(getObjectBoxModel());

  // Initialize repositories with their respective boxes
  personRepository = PersonRepository(store.box<Person>());
  vehicleRepository = VehicleRepository(store.box<Vehicle>());
  parkingRepository = ParkingRepository(store.box<Parking>());
  parkingSpaceRepository = ParkingSpaceRepository(store.box<ParkingSpace>());

  // Set up and start the server
  final ip = InternetAddress.anyIPv4;
  final handler =
      Pipeline().addMiddleware(logRequests()).addHandler(_router.call);
  final port = int.parse(Platform.environment['PORT'] ?? '8080');
  final server = await serve(handler, ip, port);
  print('Server listening on port ${server.port}');
}

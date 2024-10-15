import '../models/parking_space.dart';

class ParkingSpaceRepository {
  static final ParkingSpaceRepository _instance =
      ParkingSpaceRepository._internal();

  ParkingSpaceRepository._internal();

  factory ParkingSpaceRepository() {
    return _instance;
  }

  final List<ParkingSpace> _parkingSpaces = [];

  void add(ParkingSpace parkingSpace) {
    _parkingSpaces.add(parkingSpace);
  }

  List<ParkingSpace> getAll() {
    return _parkingSpaces;
  }

  ParkingSpace getById(String id) {
    return _parkingSpaces.firstWhere(
      (p) => p.id == id,
      orElse: () => throw Exception('Parking space not found'),
    );
  }

  void update(ParkingSpace parkingSpace) {
    var index = _parkingSpaces.indexWhere((p) => p.id == parkingSpace.id);
    if (index != -1) {
      _parkingSpaces[index] = parkingSpace;
    }
  }

  void delete(String id) {
    _parkingSpaces.removeWhere((p) => p.id == id);
  }

  // att rensa förvaret bara för testning
  void clear() {
    _parkingSpaces.clear();
  }
}

import '../models/parking.dart';

class ParkingRepository {
  static final ParkingRepository _instance = ParkingRepository._internal();

  ParkingRepository._internal();

  factory ParkingRepository() {
    return _instance;
  }

  final List<Parking> _parkings = [];

  void add(Parking parking) {
    _parkings.add(parking);
  }

  List<Parking> getAll() {
    return _parkings;
  }

  Parking getById(String id) {
    return _parkings.firstWhere(
      (p) =>
          p.vehicle.registrationNumber ==
          id, // Use vehicle registration as the ID
      orElse: () => throw Exception('Parking not found'),
    );
  }

  void update(Parking parking) {
    var index = _parkings.indexWhere((p) =>
        p.vehicle.registrationNumber == parking.vehicle.registrationNumber);
    if (index != -1) {
      _parkings[index] = parking;
    }
  }

  void delete(String id) {
    _parkings.removeWhere((p) =>
        p.vehicle.registrationNumber == id); // Use id as vehicle registration
  }

  // Method to clear repository for testing
  void clear() {
    _parkings.clear();
  }
}

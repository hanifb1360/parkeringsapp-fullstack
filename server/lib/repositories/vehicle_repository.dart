import 'package:objectbox/objectbox.dart';
import '../models/vehicle.dart';
import 'dart:async';

class VehicleRepository {
  final Box<Vehicle> _box; // Box to store Vehicle objects

  // Constructor
  VehicleRepository(this._box);

  Future<List<Vehicle>> getAll() async {
    return _box.getAll(); // Get all Vehicle objects from ObjectBox
  }

  Future<Vehicle?> getById(int id) async {
    return _box.get(id); // Get a Vehicle object by ID from ObjectBox
  }

  Future<void> create(Vehicle vehicle) async {
    vehicle.id =
        _box.put(vehicle); // Directly assign the returned ID to vehicle.id
  }

  Future<bool> update(int id, Vehicle updatedVehicle) async {
    final existingVehicle = await getById(id);
    if (existingVehicle != null) {
      updatedVehicle.id =
          id; // Ensure the ID is set for the updated Vehicle object
      _box.put(updatedVehicle); // Update the Vehicle object in ObjectBox
      return true;
    }
    return false;
  }

  Future<bool> delete(int id) async {
    final existingVehicle = await getById(id);
    if (existingVehicle != null) {
      _box.remove(id); // Remove the Vehicle object from ObjectBox
      return true;
    }
    return false;
  }
}

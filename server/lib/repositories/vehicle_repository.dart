import 'package:objectbox/objectbox.dart';
import '../models/vehicle.dart';
import 'dart:async';

class VehicleRepository {
  final Box<Vehicle> _box;

  VehicleRepository(this._box);

  Future<List<Vehicle>> getAll() async {
    return _box.getAll();
  }

  Future<Vehicle?> getById(int id) async {
    return _box.get(id);
  }

  Future<Vehicle> create(Vehicle vehicle) async {
    vehicle.id = _box.put(vehicle);
    return vehicle;
  }

  Future<Vehicle> update(int id, Vehicle updatedVehicle) async {
    final existingVehicle = await getById(id);
    if (existingVehicle != null) {
      updatedVehicle.id = id;
      _box.put(updatedVehicle);
      return updatedVehicle;
    } else {
      throw Exception("Vehicle not found");
    }
  }

  Future<Vehicle> delete(int id) async {
    final existingVehicle = await getById(id);
    if (existingVehicle != null) {
      _box.remove(id);
      return existingVehicle;
    } else {
      throw Exception("Vehicle not found");
    }
  }
}

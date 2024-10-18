import 'package:objectbox/objectbox.dart';
import '../models/parking.dart';
import 'dart:async';

class ParkingRepository {
  final Box<Parking> _box; // Box to store Parking objects

  // Constructor
  ParkingRepository(this._box);

  Future<List<Parking>> getAll() async {
    return _box.getAll(); // Get all Parking objects from ObjectBox
  }

  Future<Parking?> getById(int id) async {
    return _box.get(id); // Get a Parking object by ID from ObjectBox
  }

  Future<void> create(Parking parking) async {
    // The put method returns the ID of the newly inserted object,
    // but we don't need to use await here
    parking.id =
        _box.put(parking); // Directly assign the returned ID to parking.id
  }

  Future<bool> update(int id, Parking updatedParking) async {
    final existingParking = await getById(id);
    if (existingParking != null) {
      updatedParking.id =
          id; // Ensure the ID is set for the updated Parking object
      _box.put(updatedParking); // Update the Parking object in ObjectBox
      return true;
    }
    return false;
  }

  Future<bool> delete(int id) async {
    final existingParking = await getById(id);
    if (existingParking != null) {
      _box.remove(id); // Remove the Parking object from ObjectBox
      return true;
    }
    return false;
  }
}

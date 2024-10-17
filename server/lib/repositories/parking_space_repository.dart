import 'package:objectbox/objectbox.dart';
import '../models/parking_space.dart';
import 'dart:async';

class ParkingSpaceRepository {
  final Box<ParkingSpace> _box; // Box to store ParkingSpace objects

  // Constructor
  ParkingSpaceRepository(this._box);

  Future<List<ParkingSpace>> getAll() async {
    return _box.getAll(); // Get all ParkingSpace objects from ObjectBox
  }

  Future<ParkingSpace?> getById(int id) async {
    return _box.get(id); // Get a ParkingSpace object by ID from ObjectBox
  }

  Future<void> create(ParkingSpace space) async {
    space.id = _box.put(space); // Directly assign the returned ID to space.id
  }

  Future<bool> update(int id, ParkingSpace updatedSpace) async {
    final existingSpace = await getById(id);
    if (existingSpace != null) {
      updatedSpace.id =
          id; // Ensure the ID is set for the updated ParkingSpace object
      _box.put(updatedSpace); // Update the ParkingSpace object in ObjectBox
      return true;
    }
    return false;
  }

  Future<bool> delete(int id) async {
    final existingSpace = await getById(id);
    if (existingSpace != null) {
      _box.remove(id); // Remove the ParkingSpace object from ObjectBox
      return true;
    }
    return false;
  }
}

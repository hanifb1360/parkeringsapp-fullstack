import 'package:objectbox/objectbox.dart';
import '../models/parking_space.dart';
import 'dart:async';

class ParkingSpaceRepository {
  final Box<ParkingSpace> _box;

  ParkingSpaceRepository(this._box);

  Future<List<ParkingSpace>> getAll() async {
    return _box.getAll();
  }

  Future<ParkingSpace?> getById(int id) async {
    return _box.get(id);
  }

  Future<ParkingSpace> create(ParkingSpace space) async {
    space.id = _box.put(space);
    return space;
  }

  Future<ParkingSpace> update(int id, ParkingSpace updatedSpace) async {
    final existingSpace = await getById(id);
    if (existingSpace != null) {
      updatedSpace.id = id;
      _box.put(updatedSpace);
      return updatedSpace;
    } else {
      throw Exception("Parking space not found");
    }
  }

  Future<ParkingSpace> delete(int id) async {
    final existingSpace = await getById(id);
    if (existingSpace != null) {
      _box.remove(id);
      return existingSpace;
    } else {
      throw Exception("Parking space not found");
    }
  }
}

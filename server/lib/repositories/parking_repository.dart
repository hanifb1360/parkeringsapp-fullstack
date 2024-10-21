import 'package:objectbox/objectbox.dart';
import '../models/parking.dart';
import 'dart:async';

class ParkingRepository {
  final Box<Parking> _box;

  ParkingRepository(this._box);

  Future<List<Parking>> getAll() async {
    return _box.getAll();
  }

  Future<Parking?> getById(int id) async {
    return _box.get(id);
  }

  Future<Parking> create(Parking parking) async {
    parking.id = _box.put(parking);
    return parking;
  }

  Future<Parking> update(int id, Parking updatedParking) async {
    final existingParking = await getById(id);
    if (existingParking != null) {
      updatedParking.id = id;
      _box.put(updatedParking);
      return updatedParking;
    } else {
      throw Exception("Parking not found");
    }
  }

  Future<Parking> delete(int id) async {
    final existingParking = await getById(id);
    if (existingParking != null) {
      _box.remove(id);
      return existingParking;
    } else {
      throw Exception("Parking not found");
    }
  }
}

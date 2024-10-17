import 'package:objectbox/objectbox.dart';

import '../models/parking.dart';
import 'dart:async';

class ParkingRepository {
  final List<Parking> _parkings = [];

  ParkingRepository(Box<Parking> box);

  Future<List<Parking>> getAll() async {
    return Future.value(_parkings);
  }

  Future<Parking?> getById(int id) async {
    try {
      return Future.value(_parkings.firstWhere((parking) => parking.id == id));
    } catch (e) {
      return Future.value(null);
    }
  }

  Future<void> create(Parking parking) async {
    parking.id = _parkings.isNotEmpty ? _parkings.last.id + 1 : 1;
    _parkings.add(parking);
  }

  Future<bool> update(int id, Parking updatedParking) async {
    final index = _parkings.indexWhere((parking) => parking.id == id);
    if (index != -1) {
      _parkings[index] = updatedParking..id = id;
      return Future.value(true);
    }
    return Future.value(false);
  }

  Future<bool> delete(int id) async {
    final index = _parkings.indexWhere((parking) => parking.id == id);
    if (index != -1) {
      _parkings.removeAt(index);
      return Future.value(true);
    }
    return Future.value(false);
  }
}

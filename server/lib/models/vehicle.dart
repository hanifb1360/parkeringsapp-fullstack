import 'person.dart';

class Vehicle {
  String registrationNumber;
  String type; // "car", "motorcycle", etc.
  Person owner;

  Vehicle({required this.registrationNumber, required this.type, required this.owner});

  @override
  String toString() {
    return 'Vehicle(registrationNumber: $registrationNumber, type: $type, owner: ${owner.name})';
  }
}

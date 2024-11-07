import 'package:objectbox/objectbox.dart';

@Entity()
class Vehicle {
  @Id(assignable: true)
  int id;

  final String regNumber; // Rename to match the client's expectations
  final String ownerPersonalNumber; // Add field to link vehicle to an owner
  final String model;

  Vehicle({
    this.id = 0,
    required this.regNumber,
    required this.ownerPersonalNumber,
    required this.model,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'regNumber': regNumber,
      'ownerPersonalNumber': ownerPersonalNumber,
      'model': model,
    };
  }

  factory Vehicle.fromJson(Map<String, dynamic> json) {
    return Vehicle(
      id: json['id'] ?? 0,
      regNumber: json['regNumber'], // Match frontend naming
      ownerPersonalNumber: json['ownerPersonalNumber'],
      model: json['model'],
    );
  }
}

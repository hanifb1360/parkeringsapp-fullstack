import 'package:objectbox/objectbox.dart';

@Entity()
class Vehicle {
  @Id(assignable: true)
  int id;

  final String licensePlate;
  final String model;
  final String color;

  Vehicle({
    this.id = 0,
    required this.licensePlate,
    required this.model,
    required this.color,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'licensePlate': licensePlate,
      'model': model,
      'color': color,
    };
  }

  factory Vehicle.fromJson(Map<String, dynamic> json) {
    return Vehicle(
      id: json['id'] ?? 0,
      licensePlate: json['licensePlate'],
      model: json['model'],
      color: json['color'],
    );
  }
}

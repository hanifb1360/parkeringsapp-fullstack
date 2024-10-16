import 'package:objectbox/objectbox.dart';

@Entity()
class Parking {
  int id; // ObjectBox ID
  String vehicleRegNumber; // Registration number of the vehicle parked
  String spaceNumber; // Number of the parking space
  DateTime startTime; // Time when the vehicle was parked
  DateTime? endTime; // Time when the vehicle was removed (optional)

  Parking({
    this.id = 0,
    required this.vehicleRegNumber,
    required this.spaceNumber,
    required this.startTime,
    this.endTime,
  });

  // Convert JSON to Parking object
  factory Parking.fromJson(Map<String, dynamic> json) {
    return Parking(
      id: json['id'] ?? 0,
      vehicleRegNumber: json['vehicleRegNumber'],
      spaceNumber: json['spaceNumber'],
      startTime: DateTime.parse(json['startTime']),
      endTime: json['endTime'] != null ? DateTime.parse(json['endTime']) : null,
    );
  }

  // Convert Parking object to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'vehicleRegNumber': vehicleRegNumber,
      'spaceNumber': spaceNumber,
      'startTime': startTime.toIso8601String(),
      'endTime': endTime?.toIso8601String(),
    };
  }
}

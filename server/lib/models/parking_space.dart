import 'package:objectbox/objectbox.dart';

@Entity()
class ParkingSpace {
  int id; // ObjectBox ID
  String spaceNumber; // e.g., "A1"
  bool isOccupied; // true if occupied, false otherwise

  ParkingSpace({
    this.id = 0,
    required this.spaceNumber,
    required this.isOccupied,
  });

  // Convert JSON to ParkingSpace object
  factory ParkingSpace.fromJson(Map<String, dynamic> json) {
    return ParkingSpace(
      id: json['id'] ?? 0,
      spaceNumber: json['spaceNumber'],
      isOccupied: json['isOccupied'],
    );
  }

  // Convert ParkingSpace object to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'spaceNumber': spaceNumber,
      'isOccupied': isOccupied,
    };
  }
}

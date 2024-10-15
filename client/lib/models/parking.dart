class Parking {
  String id;
  String parkingSpaceId;
  String vehicleRegNumber;
  DateTime startTime;
  DateTime? endTime; // Make endTime nullable

  Parking({
    required this.id,
    required this.parkingSpaceId,
    required this.vehicleRegNumber,
    required this.startTime,
    this.endTime, // Use this for the nullable field
  });

  // Convert JSON to Parking object
  factory Parking.fromJson(Map<String, dynamic> json) {
    return Parking(
      id: json['id'],
      parkingSpaceId: json['parkingSpaceId'],
      vehicleRegNumber: json['vehicleRegNumber'],
      startTime: DateTime.parse(json['startTime']),
      endTime: json['endTime'] != null
          ? DateTime.parse(json['endTime'])
          : null, // Handle null endTime
    );
  }

  // Convert Parking object to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'parkingSpaceId': parkingSpaceId,
      'vehicleRegNumber': vehicleRegNumber,
      'startTime': startTime.toIso8601String(),
      'endTime': endTime?.toIso8601String(), // Use optional chaining
    };
  }

  double calculateCost() {
    if (endTime == null) {
      return 0.0; // Cannot calculate cost if parking hasn't ended
    }
    // Example logic: Calculate duration in hours and multiply by a rate
    final duration = endTime!.difference(startTime).inHours;
    const ratePerHour = 10.0; // Example rate
    return duration * ratePerHour;
  }

  @override
  String toString() {
    return 'Parking(id: $id, parkingSpaceId: $parkingSpaceId, vehicleRegNumber: $vehicleRegNumber, startTime: $startTime, endTime: $endTime)';
  }
}

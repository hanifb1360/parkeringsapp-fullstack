class ParkingSpace {
  String id;
  String address;
  double pricePerHour;

  ParkingSpace({
    required this.id,
    required this.address,
    required this.pricePerHour,
  });

  // Convert JSON to ParkingSpace object
  factory ParkingSpace.fromJson(Map<String, dynamic> json) {
    return ParkingSpace(
      id: json['id']?.toString() ??
          '', // Ensuring `id` is a String and handling `null`
      address: json['address'] ?? '', // Defaulting to empty string if `null`
      pricePerHour: json['pricePerHour'] != null
          ? json['pricePerHour'].toDouble()
          : 0.0, // Handling `null` for `pricePerHour`
    );
  }

  // Convert ParkingSpace object to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'address': address,
      'pricePerHour': pricePerHour,
    };
  }

  @override
  String toString() {
    return 'ParkingSpace(id: $id, address: $address, pricePerHour: $pricePerHour)';
  }
}

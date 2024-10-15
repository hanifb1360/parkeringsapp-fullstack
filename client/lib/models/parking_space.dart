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
      id: json['id'],
      address: json['address'],
      pricePerHour: json['pricePerHour'].toDouble(),
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

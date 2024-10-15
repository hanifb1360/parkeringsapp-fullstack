class ParkingSpace {
  String id;
  String address;
  double pricePerHour;

  ParkingSpace({required this.id, required this.address, required this.pricePerHour});

  @override
  String toString() {
    return 'ParkingSpace(id: $id, address: $address, pricePerHour: $pricePerHour)';
  }
}


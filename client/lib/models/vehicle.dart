class Vehicle {
  String regNumber;
  String ownerPersonalNumber;
  String model;

  Vehicle({
    required this.regNumber,
    required this.ownerPersonalNumber,
    required this.model,
  });

  // Convert JSON to Vehicle object
  factory Vehicle.fromJson(Map<String, dynamic> json) {
    return Vehicle(
      regNumber: json['regNumber'],
      ownerPersonalNumber: json['ownerPersonalNumber'],
      model: json['model'],
    );
  }

  // Convert Vehicle object to JSON
  Map<String, dynamic> toJson() {
    return {
      'regNumber': regNumber,
      'ownerPersonalNumber': ownerPersonalNumber,
      'model': model,
    };
  }

  @override
  String toString() {
    return 'Vehicle(regNumber: $regNumber, ownerPersonalNumber: $ownerPersonalNumber, model: $model)';
  }
}

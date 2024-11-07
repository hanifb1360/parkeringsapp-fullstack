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
      regNumber: json['regNumber']?.toString() ??
          '', // Ensuring `regNumber` is a String
      ownerPersonalNumber: json['ownerPersonalNumber']?.toString() ??
          '', // Ensuring `ownerPersonalNumber` is a String
      model: json['model'] ?? '', // Defaulting to empty string if `null`
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

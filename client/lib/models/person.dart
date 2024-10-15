class Person {
  String personalNumber;
  String name;
  String email;

  Person({
    required this.personalNumber,
    required this.name,
    required this.email,
  });

  // Convert JSON to Person object
  factory Person.fromJson(Map<String, dynamic> json) {
    return Person(
      personalNumber: json['personalNumber'],
      name: json['name'],
      email: json['email'],
    );
  }

  // Convert Person object to JSON
  Map<String, dynamic> toJson() {
    return {
      'personalNumber': personalNumber,
      'name': name,
      'email': email,
    };
  }

  @override
  String toString() {
    return 'Person(personalNumber: $personalNumber, name: $name, email: $email)';
  }
}

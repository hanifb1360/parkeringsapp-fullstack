import 'package:objectbox/objectbox.dart';

@Entity()
class Person {
  @Id(assignable: true)
  int id;

  final String name;
  final String email;
  final String personalNumber; // Add this field

  Person({
    this.id = 0, // Default to 0 for ObjectBox to auto-assign
    required this.name,
    required this.email,
    required this.personalNumber, // Make this required in constructor
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'personalNumber': personalNumber, // Include in JSON
    };
  }

  factory Person.fromJson(Map<String, dynamic> json) {
    return Person(
      id: json['id'] ?? 0,
      name: json['name'],
      email: json['email'],
      personalNumber: json['personalNumber'], // Parse from JSON
    );
  }
}

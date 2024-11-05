import 'package:objectbox/objectbox.dart';

@Entity()
class Person {
  @Id(assignable: true) // This allows ObjectBox to manage the ID
  int id;

  final String name;
  final String email;

  Person({
    this.id = 0, // Default to 0 for ObjectBox to auto-assign
    required this.name,
    required this.email,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
    };
  }

  factory Person.fromJson(Map<String, dynamic> json) {
    return Person(
      id: json['id'] ?? 0, // Use 0 if id is not provided in JSON
      name: json['name'],
      email: json['email'],
    );
  }
}

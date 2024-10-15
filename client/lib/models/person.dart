class Person {
  String name;
  String personalNumber;

  Person({required this.name, required this.personalNumber});

  @override
  String toString() {
    return 'Person(name: $name, personalNumber: $personalNumber)';
  }
}

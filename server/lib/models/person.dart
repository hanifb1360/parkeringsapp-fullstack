import 'package:objectbox/objectbox.dart';

@Entity()
class Person {
  int id;
  String personalNumber; // or use String id if you're not using ObjectBox ID
  String name;

  Person({this.id = 0, required this.personalNumber, required this.name});
}

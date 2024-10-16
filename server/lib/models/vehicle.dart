import 'package:objectbox/objectbox.dart';

@Entity()
class Vehicle {
  int id;
  String regNumber;
  String ownerPersonalNumber;
  String model;

  Vehicle(
      {this.id = 0,
      required this.regNumber,
      required this.ownerPersonalNumber,
      required this.model});
}

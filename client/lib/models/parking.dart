import 'vehicle.dart';
import 'parking_space.dart';

class Parking {
  Vehicle vehicle;
  ParkingSpace parkingSpace;
  DateTime startTime;
  DateTime? endTime;

  Parking({
    required this.vehicle,
    required this.parkingSpace,
    required this.startTime,
    this.endTime,
  });

  // Metod för att beräkna parkeringskostnaden
  double calculateCost() {
    if (endTime == null) {
      print('Parkeringen pågår fortfarande, ingen kostnad än.');
      return 0;
    }

    // Beräkna antalet timmar som fordonet har varit parkerat
    final duration = endTime!.difference(startTime).inHours;

    // Om parkeringstiden är mindre än en timme, debitera för en hel timme
    final hours = duration > 0 ? duration : 1;

    /// Beräknar kostnaden baserat på parkeringsplatsens pris per timme
    return hours * parkingSpace.pricePerHour;
  }

  @override
  String toString() {
    String status = endTime == null ? "pågående" : "avslutad";
    return 'Parking(vehicle: ${vehicle.registrationNumber}, parkingSpace: ${parkingSpace.id}, status: $status)';
  }
}

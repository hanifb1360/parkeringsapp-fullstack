import '../models/vehicle.dart';
import '../http_service.dart';

class VehicleRepository {
  // Fetch all vehicles
  Future<List<Vehicle>> fetchAll() async {
    final data = await apiClient.get('/vehicles');
    return (data as List).map((json) => Vehicle.fromJson(json)).toList();
  }

  // Create a new vehicle
  Future<void> createVehicle(Vehicle vehicle) async {
    await apiClient.post('/vehicles', vehicle.toJson());
    print('Vehicle created successfully');
  }

  // Update an existing vehicle
  Future<void> updateVehicle(String regNumber, Vehicle vehicle) async {
    await apiClient.put('/vehicles/$regNumber', vehicle.toJson());
    print('Vehicle updated successfully');
  }

  // Delete a vehicle
  Future<void> deleteVehicle(String regNumber) async {
    await apiClient.delete('/vehicles/$regNumber');
    print('Vehicle deleted successfully');
  }

  // Fetch a vehicle by registration number (ID)
  Future<Vehicle?> getById(String regNumber) async {
    final data = await apiClient.get('/vehicles/$regNumber');
    return data != null ? Vehicle.fromJson(data) : null;
  }

  // Fetch vehicles by owner's personal number
  Future<List<Vehicle>> getByOwner(String ownerPersonalNumber) async {
    final data = await apiClient.get('/vehicles?owner=$ownerPersonalNumber');
    return (data as List).map((json) => Vehicle.fromJson(json)).toList();
  }
}

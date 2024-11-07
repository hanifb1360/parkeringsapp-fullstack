import '../models/parking_space.dart';
import '../http_service.dart';

class ParkingSpaceRepository {
  // Fetch all parking spaces
  Future<List<ParkingSpace>> fetchAll() async {
    final data = await apiClient.get('/parking-spaces');
    return (data as List).map((json) => ParkingSpace.fromJson(json)).toList();
  }

  // Fetch a parking space by ID
  Future<ParkingSpace?> getById(String id) async {
    final data = await apiClient.get('/parking-spaces/$id');
    return data != null ? ParkingSpace.fromJson(data) : null;
  }

  // Create a new parking space
  Future<void> createParkingSpace(ParkingSpace parkingSpace) async {
    await apiClient.post('/parking-spaces', parkingSpace.toJson());
    print('Parking space created successfully');
  }

  // Update an existing parking space
  Future<void> updateParkingSpace(String id, ParkingSpace parkingSpace) async {
    await apiClient.put('/parking-spaces/$id', parkingSpace.toJson());
    print('Parking space updated successfully');
  }

  // Delete a parking space
  Future<void> deleteParkingSpace(String id) async {
    await apiClient.delete('/parking-spaces/$id');
    print('Parking space deleted successfully');
  }
}

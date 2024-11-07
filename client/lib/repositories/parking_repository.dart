import '../models/parking.dart';
import '../http_service.dart';

class ParkingRepository {
  // Fetch all parkings
  Future<List<Parking>> fetchAll() async {
    final data = await apiClient.get('/parkings');
    return (data as List).map((json) => Parking.fromJson(json)).toList();
  }

  // Fetch a parking by ID
  Future<Parking?> getById(String id) async {
    final data = await apiClient.get('/parkings/$id');
    return data != null ? Parking.fromJson(data) : null;
  }

  // Create a new parking
  Future<void> createParking(Parking parking) async {
    await apiClient.post('/parkings', parking.toJson());
    print('Parking created successfully');
  }

  // Update an existing parking
  Future<void> updateParking(String id, Parking parking) async {
    await apiClient.put('/parkings/$id', parking.toJson());
    print('Parking updated successfully');
  }

  // Delete a parking
  Future<void> deleteParking(String id) async {
    await apiClient.delete('/parkings/$id');
    print('Parking deleted successfully');
  }
}

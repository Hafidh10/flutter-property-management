import 'package:property_management/models/propertiesModel.dart';
import 'package:property_management/repository/api_service.dart';

class PropertyRepository {
  final ApiService _apiService =
      ApiService('https://hafidth.newtonwarui.com/public/api/properties');

  PropertyRepository(ApiService apiService);

  Future<List<Property>> getProperties() async {
    // Fetch properties from the database
    final properties = await _apiService.fetchProperties();
    return properties;
  }

  Future<void> addProperty(Property property) async {
    // Add property to the database
    await _apiService.addProperty(property);
  }

  Future<void> updateProperty(Property property) async {
    // update property to the database
    await _apiService.updateProperty(property);
  }

  Future<void> deleteProperty(int propertyId) async {
    // Delete property from the database
    await _apiService.deleteProperty(propertyId);
  }
}

// lib/api_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/propertiesModel.dart';

class ApiService {
  final String baseUrl =
      'http://10.0.2.2:8000/api/properties'; // Update with your API URL

  Future<List<Property>> fetchProperties() async {
    var propertyUrl = Uri.parse(baseUrl);
    final response = await http
        .get(propertyUrl, headers: {"Content-Type": "application/json"});

    if (response.statusCode == 200) {
      var propertyData = json.decode(response.body);

      // Check if 'data' is present and is a list
      if (propertyData['data'] != null && propertyData['data'] is List) {
        final List body = propertyData['data'];
        return body.map((property) => Property.fromJson(property)).toList();
      } else {
        // Handle the case where 'data' is null or not a list
        return [];
      }
    } else {
      throw Exception('Failed to load properties');
    }
  }

  Future<void> addProperty(Property property) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: json.encode(property.toJson()),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to add property');
    }
  }

  Future<void> updateProperty(Property property) async {
    final response = await http.put(
      Uri.parse('$baseUrl/${property.id}'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: json.encode(property.toJson()),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update property');
    }
  }

  Future<void> deleteProperty(int id) async {
    final response = await http.delete(Uri.parse('$baseUrl/$id'));
    if (response.statusCode != 200) {
      throw Exception('Failed to delete property');
    }
  }
}

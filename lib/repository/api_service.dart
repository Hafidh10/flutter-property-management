import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../loaders/loaders.dart';
import '../models/propertiesModel.dart';

class ApiService {
  final String baseUrl;

  ApiService(this.baseUrl);

// Fetch properties
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

//Add a property
  Future<void> addProperty(Property property) async {
    final url = baseUrl;
    final headers = {'Content-Type': 'application/json'};
    final body = jsonEncode(property.toJson());

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: headers,
        body: body,
      );

      if (response.statusCode == 200) {
        // Show success message
        SkiiveLoaders.successSnackBar(
          title: 'Property added Successfully!',
        );
      }

      if (response.statusCode != 200) {
        throw SkiiveLoaders.errorSnackBar(
            title: 'Failed to add property: ${response.statusCode}');
      }
    } catch (e) {
      throw SkiiveLoaders.errorSnackBar(title: 'Failed to add property: $e');
    }
  }

  // Edit property
  Future<void> updateProperty(Property property) async {
    final url = Uri.parse(
        '$baseUrl/${property.id}'); // Assuming property has an 'id' field
    final headers = {'Content-Type': 'application/json'};
    final body = jsonEncode(property.toJson());

    try {
      final response = await http.put(
        url,
        headers: headers,
        body: body,
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to update property: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to update property: $e');
    }
  }

  // Method to delete a property by ID
  Future<void> deleteProperty(int propertyId) async {
    final url =
        Uri.parse('$baseUrl/$propertyId'); // Adjust the endpoint as needed

    final response = await http.delete(url);

    if (response.statusCode != 200) {
      throw Exception('Failed to delete property: ${response.statusCode}');
    }
  }
}

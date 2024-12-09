// lib/bloc/property_state.dart
import '../models/propertiesModel.dart';

abstract class PropertyState {}

class PropertyInitial extends PropertyState {}

class PropertyLoading extends PropertyState {}

class PropertyLoaded extends PropertyState {
  final List<Property> properties;

  PropertyLoaded(this.properties);
}

class PropertyError extends PropertyState {
  final String message;

  PropertyError(this.message);
}

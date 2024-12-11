part of 'property_bloc.dart';

abstract class PropertyState {}

class PropertyInitial extends PropertyState {}

class PropertiesLoaded extends PropertyState {
  final List<Property> properties;

  PropertiesLoaded(this.properties);
}

class PropertyAdded extends PropertyState {}

class PropertyError extends PropertyState {
  final String message;

  PropertyError({required this.message});
}

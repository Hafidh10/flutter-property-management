// lib/bloc/property_event.dart
import '../models/propertiesModel.dart';

abstract class PropertyEvent {}

class FetchProperties extends PropertyEvent {}

class AddProperty extends PropertyEvent {
  final Property property;

  AddProperty(this.property);
}

class UpdateProperty extends PropertyEvent {
  final Property property;

  UpdateProperty(this.property,
      {required int id,
      required String title,
      required String address,
      required int bedrooms,
      required double price});
}

class DeleteProperty extends PropertyEvent {
  final int id;

  DeleteProperty(this.id);
}

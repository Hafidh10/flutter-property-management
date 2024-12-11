part of 'property_bloc.dart';

abstract class PropertyEvent {}

class FetchProperties extends PropertyEvent {}

class AddProperty extends PropertyEvent {
  final Property property;

  AddProperty(this.property);
}

class UpdateProperty extends PropertyEvent {
  final Property property;

  UpdateProperty(this.property);
}

class DeleteProperty extends PropertyEvent {
  final Property property;

  DeleteProperty(this.property);
}

import 'package:bloc/bloc.dart';

import '../../models/propertiesModel.dart';
import '../../repository/property_repository.dart';

part 'property_event.dart';
part 'property_state.dart';

class PropertyBloc extends Bloc<PropertyEvent, PropertyState> {
  final PropertyRepository _propertyRepository;

  PropertyBloc(this._propertyRepository) : super(PropertyInitial()) {
    on<FetchProperties>((event, emit) async {
      try {
        final properties = await _propertyRepository.getProperties();
        emit(PropertiesLoaded(properties));
      } catch (e) {
        emit(PropertyError(message: e.toString()));
      }
    });

    on<AddProperty>((event, emit) async {
      try {
        await _propertyRepository.addProperty(event.property);
        emit(PropertyAdded());

        // Fetch properties again after adding
        final properties = await _propertyRepository.getProperties();
        emit(PropertiesLoaded(properties)); // Emit the updated properties
      } catch (e) {
        emit(PropertyError(message: e.toString()));
      }
    });

    on<UpdateProperty>((event, emit) async {
      try {
        await _propertyRepository.updateProperty(event.property);
        emit(PropertyAdded()); // Emit success state

        // Fetch properties again after updating
        final properties = await _propertyRepository.getProperties();
        emit(PropertiesLoaded(properties)); // Emit the updated properties
      } catch (e) {
        emit(PropertyError(message: e.toString()));
      }
    });
    on<DeleteProperty>((event, emit) async {
      try {
        await _propertyRepository.deleteProperty(event.property.id);
        emit(PropertiesLoaded(await _propertyRepository.getProperties()));
      } catch (e) {
        emit(PropertyError(message: e.toString()));
      }
    });
  }
}

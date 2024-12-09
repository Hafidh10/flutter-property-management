// lib/bloc/property_bloc.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import '../repository/property_repository.dart';
import 'property_event.dart';
import 'property_state.dart';

/// PropertyBloc manages the state of properties using the Flutter Bloc pattern.
/// It handles events such as fetching, adding, updating, and deleting properties.
class PropertyBloc extends Bloc<PropertyEvent, PropertyState> {
  /// The ApiService instance used to interact with the backend.
  final ApiService apiService;

  /// Constructor for PropertyBloc.
  /// Initializes the state to PropertyInitial.
  PropertyBloc(this.apiService) : super(PropertyInitial()) {
    /// Handles the FetchProperties event.
    /// Fetches properties from the API and updates the state.
    on<FetchProperties>((event, emit) async {
      emit(PropertyLoading()); // Emit loading state
      try {
        final properties =
            await apiService.fetchProperties(); // Fetch properties from API
        emit(PropertyLoaded(properties)); // Emit loaded state with properties
      } catch (e) {
        print('Error fetching properties: $e'); // Log the error
        emit(PropertyError(
            'Failed to fetch properties: $e')); // Emit error state
      }
    });

    /// Handles the AddProperty event.
    /// Adds a new property to the API and triggers a fetch of properties.
    on<AddProperty>((event, emit) async {
      try {
        await apiService.addProperty(event.property); // Add property to API
        add(FetchProperties()); // Trigger fetching properties again
      } catch (e) {
        emit(PropertyError('Failed to add property')); // Emit error state
      }
    });

    /// Handles the UpdateProperty event.
    /// Updates an existing property in the API and triggers a fetch of properties.
    on<UpdateProperty>((event, emit) async {
      try {
        await apiService
            .updateProperty(event.property); // Update property in API
        add(FetchProperties()); // Trigger fetching properties again
      } catch (e) {
        emit(PropertyError('Failed to update property')); // Emit error state
      }
    });

    /// Handles the DeleteProperty event.
    /// Deletes a property from the API and triggers a fetch of properties.
    on<DeleteProperty>((event, emit) async {
      try {
        await apiService.deleteProperty(event.id); // Delete property from API
        add(FetchProperties()); // Trigger fetching properties again
      } catch (e) {
        emit(PropertyError('Failed to delete property')); // Emit error state
      }
    });
  }
}

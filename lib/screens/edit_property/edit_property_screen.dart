import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:property_management/bloc/property_bloc.dart';
import 'package:property_management/models/propertiesModel.dart';

class EditPropertyScreen extends StatefulWidget {
  final Property property;

  EditPropertyScreen({required this.property});

  @override
  State<EditPropertyScreen> createState() => _EditPropertyScreenState();
}

class _EditPropertyScreenState extends State<EditPropertyScreen> {
  @override
  Widget build(BuildContext context) {
    final titleController = TextEditingController(text: widget.property.title);
    final addressController =
        TextEditingController(text: widget.property.address);
    final priceController =
        TextEditingController(text: widget.property.price.toString());
    final bedroomsController =
        TextEditingController(text: widget.property.bedrooms.toString());
    final descriptionController =
        TextEditingController(text: widget.property.description);
    // Add other fields as necessary

    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Property'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: InputDecoration(labelText: 'Title'),
            ),
            TextField(
              controller: descriptionController,
              decoration: InputDecoration(labelText: 'Description'),
            ),
            // Add other fields as necessary
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final updatedProperty = Property(
                  id: widget.property.id, // Ensure you have the ID
                  title: titleController.text,
                  description: descriptionController.text,
                  address: addressController.text,
                  price: double.tryParse(priceController.text) ??
                      0.0, // Convert to double
                  bedrooms: int.tryParse(bedroomsController.text) ?? 0,
                  // Add other fields as necessary
                );

                // Dispatch the update event
                context
                    .read<PropertyBloc>()
                    .add(UpdateProperty(updatedProperty));

                // Navigate back or show a success message
                Navigator.pop(context);
              },
              child: Text('Save Changes'),
            ),
          ],
        ),
      ),
    );
  }
}

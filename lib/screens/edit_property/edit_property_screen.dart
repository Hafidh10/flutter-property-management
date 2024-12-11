import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:property_management/bloc/property_bloc.dart';
import 'package:property_management/models/propertiesModel.dart';

class EditPropertyScreen extends StatefulWidget {
  final Property property;

  EditPropertyScreen({required this.property});

  @override
  State<EditPropertyScreen> createState() => _EditPropertyScreenState();
}

class _EditPropertyScreenState extends State<EditPropertyScreen> {
  final titleController = TextEditingController();
  final addressController = TextEditingController();
  final priceController = TextEditingController();
  final bedroomsController = TextEditingController();
  final descriptionController = TextEditingController();
  bool isLoading = false; // Track loading state

  @override
  void initState() {
    super.initState();
    // Initialize controllers with existing property data
    titleController.text = widget.property.title;
    addressController.text = widget.property.address;
    priceController.text =
        NumberFormat.currency(symbol: '\$').format(widget.property.price);
    bedroomsController.text = widget.property.bedrooms.toString();
    descriptionController.text = widget.property.description!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Property'),
      ),
      body: SingleChildScrollView(
        child: BlocListener<PropertyBloc, PropertyState>(
          listener: (context, state) {
            if (state is PropertyAdded) {
              // Show success message for property added
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Property updated successfully!')),
              );
              // Navigate back to HomeScreen and refresh properties
              Future.delayed(Duration(seconds: 2), () {
                Navigator.pushReplacementNamed(context, '/');
              });
              setState(() {
                isLoading = false; // Stop loading
              });
            } else if (state is PropertyError) {
              // Show error message
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                    content:
                        Text('Failed to update property: ${state.message}')),
              );
              setState(() {
                isLoading = false; // Stop loading
              });
            }
          },
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                TextField(
                  controller: titleController,
                  decoration: InputDecoration(
                    labelText: 'Title',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: BorderSide(color: Colors.blue),
                    ),
                  ),
                ),
                SizedBox(height: 15),
                TextField(
                  controller: descriptionController,
                  decoration: InputDecoration(
                    labelText: 'Description',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: BorderSide(color: Colors.blue),
                    ),
                  ),
                ),
                SizedBox(height: 15),
                TextField(
                  controller: addressController,
                  decoration: InputDecoration(
                    labelText: 'Address',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: BorderSide(color: Colors.blue),
                    ),
                  ),
                ),
                SizedBox(height: 15),
                TextField(
                  controller: priceController,
                  decoration: InputDecoration(
                    labelText: 'Price',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: BorderSide(color: Colors.blue),
                    ),
                  ),
                  keyboardType: TextInputType.number,
                ),
                SizedBox(height: 15),
                TextField(
                  controller: bedroomsController,
                  decoration: InputDecoration(
                    labelText: 'Bedrooms',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                  ),
                  keyboardType: TextInputType.number,
                ),
                SizedBox(height: 40),
                SizedBox(
                  height: 60,
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    onPressed: isLoading
                        ? null // Disable button while loading
                        : () {
                            setState(() {
                              isLoading = true; // Start loading
                            });

                            final updatedProperty = Property(
                              id: widget.property.id,
                              title: titleController.text,
                              description: descriptionController.text,
                              address: addressController.text,
                              price: priceController.text.isNotEmpty
                                  ? double.tryParse(priceController.text
                                          .replaceAll('\$', '')
                                          .replaceAll(',', '')) ??
                                      widget.property.price
                                  : widget.property.price,
                              bedrooms:
                                  int.tryParse(bedroomsController.text) ?? 0,
                            );

                            // Dispatch the update event
                            context
                                .read<PropertyBloc>()
                                .add(UpdateProperty(updatedProperty));
                          },
                    child: isLoading
                        ? SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                            ),
                          )
                        : Text('Save Changes',
                            style:
                                TextStyle(color: Colors.white, fontSize: 18)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

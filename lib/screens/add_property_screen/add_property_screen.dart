import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/property_bloc.dart';
import '../../models/propertiesModel.dart';

class AddPropertyScreen extends StatefulWidget {
  @override
  _AddPropertyScreenState createState() => _AddPropertyScreenState();
}

class _AddPropertyScreenState extends State<AddPropertyScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _addressController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _priceController = TextEditingController();
  final _bedroomsController = TextEditingController();
  bool isLoading = false; // Track loading state

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Property'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: BlocListener<PropertyBloc, PropertyState>(
            listener: (context, state) {
              if (state is PropertyAdded) {
                // Show success message
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Property added successfully!'),
                    duration: Duration(seconds: 2),
                  ),
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
                    content: Text('Failed to add property: ${state.message}'),
                  ),
                );
                setState(() {
                  isLoading = false; // Stop loading
                });
              }
            },
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _titleController,
                    decoration: InputDecoration(
                      labelText: 'Title',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a title';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20), // Add spacing between fields
                  TextFormField(
                    controller: _addressController,
                    decoration: InputDecoration(
                      labelText: 'Address',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter an address';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20), // Add spacing between fields
                  TextFormField(
                    controller: _descriptionController,
                    decoration: InputDecoration(
                      labelText: 'Description',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a description';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20), // Add spacing between fields
                  TextFormField(
                    controller: _priceController,
                    decoration: InputDecoration(
                      labelText: 'Price',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a price';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.number,
                  ),
                  SizedBox(height: 20), // Add spacing between fields
                  TextFormField(
                    controller: _bedroomsController,
                    decoration: InputDecoration(
                      labelText: 'Bedrooms',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the number of bedrooms';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.number,
                  ),
                  SizedBox(height: 40),
                  Container(
                    height: 60,
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: isLoading
                          ? null // Disable button while loading
                          : () {
                              if (_formKey.currentState!.validate()) {
                                setState(() {
                                  isLoading = true; // Start loading
                                });

                                final property = Property(
                                  id: 0, // This will be auto-generated by the backend
                                  title: _titleController.text,
                                  address: _addressController.text,
                                  description: _descriptionController.text,
                                  price: double.parse(_priceController.text),
                                  bedrooms: int.parse(_bedroomsController.text),
                                );

                                context
                                    .read<PropertyBloc>()
                                    .add(AddProperty(property));
                              }
                            },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        minimumSize: const Size(
                            double.infinity, 56), // Full width and height of 56
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(12.0), // Rounded corners
                        ),
                      ),
                      child: isLoading
                          ? SizedBox(
                              height:
                                  20, // Set height for the circular indicator
                              width: 20, // Set width for the circular indicator
                              child: CircularProgressIndicator(
                                strokeWidth: 2, // Adjust stroke width for size
                              ),
                            )
                          : const Text(
                              'Add Property',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18),
                            ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

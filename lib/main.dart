// lib/main.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:property_management/repository/property_repository.dart';
import 'bloc/property_bloc.dart';
import 'bloc/property_event.dart';
import 'bloc/property_state.dart';
import 'screens/add_property_screen/add_property_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BlocProvider(
        create: (context) => PropertyBloc(ApiService())..add(FetchProperties()),
        child: const PropertyListScreen(),
      ),
    );
  }
}

class PropertyListScreen extends StatelessWidget {
  const PropertyListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          'assets/logos/logo.webp', // Path to your logo
          fit: BoxFit.contain, // Adjust the fit as needed
          height: 40, // Set the height of the logo
        ),
        centerTitle: true, // Center the logo in the AppBar
        backgroundColor: Colors.blue, // Set the background color if needed
      ),
      body: BlocBuilder<PropertyBloc, PropertyState>(
        builder: (context, state) {
          if (state is PropertyLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is PropertyLoaded) {
            return ListView.builder(
              itemCount: state.properties.length,
              itemBuilder: (context, index) {
                final property = state.properties[index];
                return Card(
                  margin: const EdgeInsets.all(8.0), // Margin around the card
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Display the property image
                      Image.network(
                        property.image.toString(), // URL of the property image
                        fit: BoxFit.cover, // Adjust the fit as needed
                        height: 150, // Set a fixed height for the image
                        width: double.infinity, // Make the image full width
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              property.title,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(property.address),
                            Text('${property.bedrooms} Bedroom'),
                            Text(
                              NumberFormat.currency(symbol: '\$')
                                  .format(property.price),
                              style: const TextStyle(
                                  color: Colors.red,
                                  fontWeight:
                                      FontWeight.bold), // Set the color to red
                            ),
                          ],
                        ),
                      ),
                      // Add a trailing delete button
                      ButtonBar(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.edit), // Edit icon
                            onPressed: () {
                              // Handle edit action here
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const AddPropertyScreen()),
                              );
                              // You can navigate to an edit screen or show a dialog
                            },
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () {
                              context
                                  .read<PropertyBloc>()
                                  .add(DeleteProperty(property.id));
                            },
                          ),
                          // Add more buttons if needed
                        ],
                      ),
                    ],
                  ),
                );
              },
            );
          } else if (state is PropertyError) {
            return Center(child: Text(state.message));
          }
          return Container();
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddPropertyScreen()),
          ); // Navigate to Add Property screen
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

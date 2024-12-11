import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../bloc/property_bloc.dart';
import '../../models/propertiesModel.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Fetch properties when the HomeScreen is built
    context.read<PropertyBloc>().add(FetchProperties());

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
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
          if (state is PropertyInitial) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is PropertiesLoaded) {
            return ListView.builder(
              itemCount: state.properties.length,
              itemBuilder: (context, index) {
                final property = state.properties[index];
                return Container(
                  margin: const EdgeInsets.only(bottom: 8),
                  child: Column(
                    children: [
                      ListTile(
                        title: Text(property.title),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(property.address),
                            Text(
                              NumberFormat.currency(symbol: '\$')
                                  .format(property.price),
                              style: const TextStyle(
                                  color: Colors.red,
                                  fontWeight:
                                      FontWeight.bold), // Set the color to red
                            ), // Display price
                            Text('Bedrooms: ${property.bedrooms.toString()}'),
                          ],
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.edit),
                              onPressed: () {
                                // Navigate to the edit property screen
                                Navigator.pushNamed(context, '/edit_property',
                                    arguments: property);
                              },
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red),
                              onPressed: () {
                                // Show confirmation dialog before deleting
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: Text('Delete Property'),
                                      content: Text(
                                          'Are you sure you want to delete this property?'),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(context)
                                                .pop(); // Close the dialog
                                          },
                                          child: Text('Cancel'),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            // Dispatch the delete event
                                            context
                                                .read<PropertyBloc>()
                                                .add(DeleteProperty(property));
                                            Navigator.of(context)
                                                .pop(); // Close the dialog
                                          },
                                          child: Text('Delete'),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                      const Divider(thickness: 1),
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
          Navigator.pushNamed(context, '/add_property');
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

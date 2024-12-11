import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:property_management/bloc/property_bloc.dart';
import 'package:property_management/models/propertiesModel.dart';
import 'package:property_management/repository/property_repository.dart';
import 'package:property_management/screens/add_property_screen/add_property_screen.dart';
import 'package:property_management/screens/edit_property/edit_property_screen.dart';
import 'package:property_management/screens/homescreen/homescreen.dart';
import 'package:provider/provider.dart';
import 'package:property_management/repository/api_service.dart'; // Ensure this import is correct

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<PropertyRepository>(
          create: (_) => PropertyRepository(ApiService(
              'https://hafidth.newtonwarui.com/public/api/properties')), // Replace with your actual API base URL
        ),
        BlocProvider<PropertyBloc>(
          create: (context) => PropertyBloc(
            Provider.of<PropertyRepository>(context, listen: false),
          ),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Property Management',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => const HomeScreen(),
          '/add_property': (context) => BlocProvider(
                create: (context) => PropertyBloc(
                  Provider.of<PropertyRepository>(context, listen: false),
                ),
                child: AddPropertyScreen(),
              ),
          '/edit_property': (context) {
            final property = ModalRoute.of(context)!.settings.arguments
                as Property; // Get the property from arguments
            return BlocProvider(
              create: (context) => PropertyBloc(
                Provider.of<PropertyRepository>(context, listen: false),
              ),
              child: EditPropertyScreen(property: property),
            );
          },
        },
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import '../../bloc/property_event.dart';
// import '../../models/propertiesModel.dart';

// class AddEditPropertyScreen extends StatefulWidget {
//   final Property? property;

//   const AddEditPropertyScreen({super.key, this.property});

//   @override
//   _AddEditPropertyScreenState createState() => _AddEditPropertyScreenState();
// }

// class _AddEditPropertyScreenState extends State<AddEditPropertyScreen> {
//   final _formKey = GlobalKey<FormState>();
//   late String _name;
//   late String _location;
//   late double _price;
//   String? _description;

//   @override
//   void initState() {
//     super.initState();
//     if (widget.property != null) {
//       _name = widget.property!.name;
//       _location = widget.property!.location;
//       _price = widget.property!.price;
//       _description = widget.property!.description;
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.property == null ? 'Add Property' : 'Edit Property'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Form(
//           key: _formKey,
//           child: Column(
//             children: [
//               TextFormField(
//                 initialValue: _name,
//                 decoration: const InputDecoration(labelText: 'Property Name'),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter a property name';
//                   }
//                   return null;
//                 },
//                 onChanged: (value) {
//                   _name = value;
//                 },
//               ),
//               TextFormField(
//                 initialValue: _location,
//                 decoration: const InputDecoration(labelText: 'Location'),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter a location';
//                   }
//                   return null;
//                 },
//                 onChanged: (value) {
//                   _location = value;
//                 },
//               ),
//               TextFormField(
//                 initialValue: _price.toString(),
//                 decoration: const InputDecoration(labelText: 'Price'),
//                 keyboardType: TextInputType.number,
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter a price';
//                   }
//                   return null;
//                 },
//                 onChanged: (value) {
//                   _price = double.tryParse(value) ?? 0.0;
//                 },
//               ),
//               TextFormField(
//                 initialValue: _description,
//                 decoration: const InputDecoration(labelText: 'Description'),
//                 onChanged: (value) {
//                   _description = value;
//                 },
//               ),
//               const SizedBox(height: 20),
//               ElevatedButton(
//                 onPressed: () {
//                   if (_formKey.currentState!.validate()) {
//                     final property = Property(
//                       id: widget.property?.id ?? 0,
//                       name: _name,
//                       location: _location,
//                       price: _price,
//                       description: _description,
//                     );

//                     if (widget.property == null) {
//                       context.read<PropertyCubit>().addProperty(property);
//                     } else {
//                       context.read<PropertyCubit>().updateProperty(property);
//                     }

//                     Navigator.pop(context);
//                   }
//                 },
//                 child: Text(widget.property == null
//                     ? 'Add Property'
//                     : 'Update Property'),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

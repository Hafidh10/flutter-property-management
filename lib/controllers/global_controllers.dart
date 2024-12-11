import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class GlobalControllers {
  static final TextEditingController propertyTitleController =
      TextEditingController();
  static final TextEditingController propertyDescriptionController =
      TextEditingController();
  static final TextEditingController propertyPriceController =
      TextEditingController();
  static final TextEditingController propertyBedroomsController =
      TextEditingController();
  static final TextEditingController propertyAddressController =
      TextEditingController();
  static XFile? _image;

  // Add more controllers as needed

  // Public getter for _image
  static XFile? get image => _image;

  // Method to set the image
  static void setImage(XFile? newImage) {
    _image = newImage;
  }
}

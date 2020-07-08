import 'dart:io';
import 'package:flutter/material.dart';

class ContactImage {
  static ImageProvider get(String imagePath) {
    final String defaultImageContact = 'images/person.png';
    if (imagePath == null) {
      return AssetImage(defaultImageContact);
    } else {
      final _imageFile = File(imagePath);
      if (_imageFile.existsSync())
        return FileImage(_imageFile);
      else
        return AssetImage(defaultImageContact);
    }
  }
}

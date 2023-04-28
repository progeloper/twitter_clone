import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

void showSnackBar(BuildContext context, String content) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(content)));
}

Future<List<File>> pickImage() async {
  List<File> images = [];
  final imagePicker = ImagePicker();
  final imageFiles = await imagePicker.pickMultiImage();
  if (imageFiles.isNotEmpty) {
    int i = 0;
    for (final file in imageFiles) {
      if(i == 4){
        return images;
      }
      images.add(File(file.path));
      i++;
    }
  }
  return images;
}

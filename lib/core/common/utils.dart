import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

void showSnackBar(BuildContext context, String content) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(content)));
}

Future<FilePickerResult?> pickImage() async{
  final image = FilePicker.platform.pickFiles(type: FileType.image);
  return image;
}

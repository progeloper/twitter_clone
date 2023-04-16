import 'package:flutter/material.dart';
import 'package:twitter_clone/theme/palette.dart';

class OutlinedTextField extends StatelessWidget {
  final String label;
  VoidCallback function;
  String? Function(String?)? validate;
  final TextEditingController controller;
  int? maxChar;
  bool readOnly;
  bool obscured;
  OutlinedTextField({
    Key? key,
    required this.label,
    required this.function,
    required this.controller,
    this.maxChar,
    this.readOnly = false,
    this.obscured = false,
    this.validate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validate,
      controller: controller,
      readOnly: readOnly,
      obscureText: obscured,
      onTap: function,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: const BorderSide(color: Palette.lightGreyColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: const BorderSide(
            color: Palette.blueColor,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: const BorderSide(
            color: Palette.redColor,
          ),
        ),
        labelText: label,
        labelStyle: const TextStyle(
          fontSize: 16,
        ),
      ),
      maxLength: maxChar,
    );
  }
}

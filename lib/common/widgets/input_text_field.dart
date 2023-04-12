import 'package:flutter/material.dart';
import 'package:twitter_clone/theme/palette.dart';

class InputTextField extends StatelessWidget {
  final TextEditingController _controller;
  final String _labelText;
  final bool obscured;
  const InputTextField({Key? key, required TextEditingController controller, required String label, this.obscured = false}) : _controller = controller, _labelText = label,super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: obscured,
      controller: _controller,
      decoration: InputDecoration(
        labelText: _labelText,

        border: const UnderlineInputBorder(
          borderSide: BorderSide(color: Palette.darkGreyColor),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Palette.blueColor),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:twitter_clone/theme/palette.dart';

class RoundedFilledButton extends StatelessWidget {
  final VoidCallback function;
  final String label;
  final Color color;
  const RoundedFilledButton(
      {Key? key,
      this.color = Palette.blueColor,
      required this.function,
      required this.label})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: function,
      style: TextButton.styleFrom(
        backgroundColor: Palette.blueColor,
        minimumSize: const Size(double.infinity, 50),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(32),
        ),
      ),
      child: Text(
        label,
        style: const TextStyle(
          color: Palette.whiteColor,
          fontSize: 16,
        ),
      ),
    );
  }
}

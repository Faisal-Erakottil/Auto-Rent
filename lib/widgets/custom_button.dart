
import 'package:flutter/material.dart';

Widget customButton({
  required VoidCallback onPressed,
  required String label,
  void Function()? buttonPressed,
  Color? backgroundColor,
  Color? labelColor,
  double width = 120,
  double height = 5,
  Icon? icon,
}) {
  return ElevatedButton(
    style: ElevatedButton.styleFrom(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      backgroundColor: backgroundColor,
      fixedSize: Size(width, height),
    ),
    onPressed: onPressed,
    child: Text(
      label,
      style: TextStyle(color: labelColor),
    ),
  );
}
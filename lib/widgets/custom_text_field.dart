// ignore_for_file: use_key_in_widget_constructors

import 'package:autorent/widgets/custom_colors.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomTextField extends StatelessWidget {
  TextEditingController? controller;
  String labelText;
  String? hintText;
  IconData? prefixIcon;
  bool obscureText;
  bool enable;
  VoidCallback? onTap;
  String? Function(String?)? validator;
  TextInputType? keyboardType;

  CustomTextField({
    required this.controller,
    required this.labelText,
    this.hintText,
    this.obscureText = false,
    this.validator,
    this.keyboardType,
    this.enable = true,
    this.onTap,
    textCapitalization = TextCapitalization.characters,
    required String fieldName,
    this.prefixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      enabled: enable,
      obscureText: obscureText,
      style: const TextStyle(color: CustomColor.black, fontSize: 16),
      decoration: InputDecoration(
        prefixIcon: Icon(
          prefixIcon,
          color: Colors.black,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
        ),

        filled: true,
        fillColor: CustomColor.white,
        labelText: labelText,
        labelStyle: const TextStyle(color: CustomColor.black),
        hintText: hintText,
        hintStyle: const TextStyle(color: CustomColor.black),
        // Set keyboardType
      ),
      onTap: onTap,
      validator: validator,
      keyboardType: keyboardType,
    );
  }
}

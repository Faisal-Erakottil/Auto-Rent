import 'package:flutter/material.dart';

Widget customDropdownField({
  required String labelText,
  required String hintText,
  required String? value,
  required List<String> items,
  required Function(String?) onChanged,
  IconData? prefixIcon,
}) {
  return DropdownButtonFormField<String>(
    value: value,
    items: items.map((String item) {
      return DropdownMenuItem<String>(
        value: item,
        child: Text(item),
      );
    }).toList(),
    onChanged: onChanged,
    decoration: InputDecoration(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      prefixIcon: prefixIcon != null ? Icon(prefixIcon) : null,
      hintText: hintText,
      labelText: labelText,
    ),
    autovalidateMode: AutovalidateMode.onUserInteraction,
    validator: (value) {
      if (value == null || value.isEmpty) {
        return 'Value is empty';
      } else {
        return null;
      }
    },
  );
}

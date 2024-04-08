
// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String text;
  final Color color;
  final FontWeight fontWeight;
  final double size;
  final TextOverflow? overflow;


  const CustomText({
    required this.text,
    this.color = Colors.white,
    this.fontWeight = FontWeight.bold,
    this.size = 16,
    this.overflow,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: color,
        fontFamily: 'Ubuntu',
        fontWeight: fontWeight,
        fontSize: size,
        overflow: overflow,
      ),
    );
  }
}
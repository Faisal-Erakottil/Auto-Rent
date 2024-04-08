
import 'package:autorent/widgets/custom_text.dart';
import 'package:flutter/material.dart';

class CustomList extends StatelessWidget {
  final String title;
  final IconData? leadingIcon;
  final VoidCallback? onTap;

  const CustomList({
    required this.title,
    this.leadingIcon,
    this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: leadingIcon != null
          ? Icon(
              leadingIcon,
              color: Colors.blue,
            )
          : null,
      title: CustomText(
        text: title,
        color: Colors.blue,
      ),
      onTap: onTap,
    );
  }
}
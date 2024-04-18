import 'package:autorent/widgets/custom_colors.dart';
import 'package:autorent/widgets/custom_text.dart';
import 'package:flutter/material.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColor.white,
      appBar: AppBar(
        backgroundColor: CustomColor.black,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(20),
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        title: const CustomText(
          size: 20,
          text: "About Us",
          fontWeight: FontWeight.bold,
        ),
      ),
      body: const SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: Padding(
          padding: EdgeInsets.all(20),
          child: CustomText(
            color: CustomColor.black,
            size: 20,
            text: "\n"
                "This is an app that is developed as part of my project and this will be one of my freatestmilstone in my career.This  is an Rent a Car application which will help to  MANAGE YOUR Rent a Car buisness.\n",
          ),
        ),
      ),
    );
  }
}

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
        //backgroundColor: CustomColor.white,
      ),
      body: const SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: Padding(
          padding: EdgeInsets.all(20),
          child: CustomText(
              color: CustomColor.black,
              text:"This is an app that is developed as part of my \n"
                  "project and this will be one of my freatest\n"
                  "milstone in my career.This  is an Rent a Car\n"
                  "application which will help to  MANAGE YOUR \n"
                  "Rent a Car buisness.\n"
                  "\n"
              // "\nWelcome to the Help Center! We're here "
              // "\nto guide you through the features and "
              // "functionalities of our application. Whether "
              // "you're a new user or an experienced pro, we "
              // "have resources to help you get the most out "
              // "of Rent a Car.\n"
              // "\n"
              // "This page provides answers to frequently "
              // "asked questions, detailed instructions for "
              // "using specific features, and troubleshooting "
              // "tips. You can also search our knowledge "
              // "base or contact our support team directly if"
              // "you need further assistance.\n"
              // "\n"
              // "Remember, we're always happy to help! So don't \n"
              // "hesitate to reach out if you have any questions or\n"
              // "need a helping hand.\n",
              ),
        ),
      ),
    );
  }
}

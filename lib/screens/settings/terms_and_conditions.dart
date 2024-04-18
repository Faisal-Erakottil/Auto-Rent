import 'package:autorent/widgets/custom_colors.dart';
import 'package:autorent/widgets/custom_text.dart';
import 'package:flutter/material.dart';

class TermsConditions extends StatelessWidget {
  const TermsConditions({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColor.white,
      appBar: AppBar(
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
          text: "Terms and Conditions",
          size: 20,
          fontWeight: FontWeight.bold,
        ),
        backgroundColor: Colors.black,
      ),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: CustomText(
                text: "Terms and Conditions",
                color: CustomColor.blue,
                fontWeight: FontWeight.bold,
                size: 20,
              ),
            ),
            SizedBox(height: 5),
            CustomText(
              color: CustomColor.black,
              text:
                  "Welcome to Auto Rent Before you start using our application, please read these Terms and Conditions carefully. By accessing or using Auto Rent, you agree to be bound by these Terms and Conditions.",
            ),
            SizedBox(height: 10),
            CustomText(
              text: "Introduction",
              color: CustomColor.blue,
              fontWeight: FontWeight.bold,
              size: 20,
            ),
            SizedBox(height: 5),
            CustomText(
              text:
                  "Auto Rent is an offline Business manager application designed to help users organize their Business efficiently. By using Auto Rent, you acknowledge that you have read, understood, and agree to abide by these Terms and Conditions. If you do not agree with any part of these Terms and Conditions, please do not use Auto Rent.",
              color: Colors.black,
            ),
            SizedBox(height: 10),
            CustomText(
              text: "User Information",
              color: CustomColor.blue,
              size: 20,
            ),
            SizedBox(height: 5),
            CustomText(
              text:
                  "Auto Rent collects user's name,Image,mobile number and Email Id for personalization purposes.",
              color: CustomColor.black,
            ),
            SizedBox(height: 10),
            CustomText(
              text: "Limitation of Liability",
              color: CustomColor.blue,
              size: 20,
              fontWeight: FontWeight.bold,
            ),
            SizedBox(height: 5),
            CustomText(
              text:
                  "Auto Rent and its developers shall not be liable for any indirect, incidental, special, consequential, or punitive damages, or any loss of profits or revenues, whether incurred directly or indirectly, or any loss of data, use, goodwill, or other intangible losses",
              color: CustomColor.black,
            ),
            SizedBox(height: 10),
            CustomText(
              text: "Changes to Terms and Conditions",
              color: CustomColor.blue,
              fontWeight: FontWeight.bold,
              size: 20,
            ),
            SizedBox(height: 5),
            CustomText(
              text:
                  "We reserve the right to modify or replace these Terms and Conditions at any time. Any changes will be effective immediately upon posting the revised Terms and Conditions on Auto Rent. Your continued use of Auto Rent after any such changes constitutes your acceptance of the new Terms and Conditions.",
              color: CustomColor.black,
            ),
            SizedBox(height: 15),
            CustomText(
              text:
                  "By using Auto Rent, you agree to these Terms and Conditions. Thank you for using Auto Rent!",
              color: CustomColor.black,
              fontWeight: FontWeight.bold,
              size: 18,
            ),
          ],
        ),
      ),
    );
  }
}

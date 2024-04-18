import 'package:autorent/screens/settings/aboutus.dart';
import 'package:autorent/screens/settings/privacy_policy.dart';
import 'package:autorent/screens/settings/terms_and_conditions.dart';
import 'package:autorent/widgets/custom_colors.dart';
import 'package:autorent/widgets/custom_text.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
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
          text: "SETTINGS",
          size: 20,
          fontWeight: FontWeight.w600,
        ),
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //const SizedBox(height: 10),
            //===============================Privacy and Policy
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const PrivacyPolicy(),
                  ),
                );
              },
              child: const ListTile(
                leading: Icon(
                  Icons.privacy_tip_outlined,
                  color: CustomColor.blue,
                  size: 28,
                ),
                title: CustomText(
                  text: "Privacy and Policy",
                  size: 20,
                  color: CustomColor.black,
                ),
              ),
            ),
            //========================================About Us
            GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const AboutUs()));
              },
              child: const ListTile(
                leading: Icon(
                  Icons.help_outline,
                  color: CustomColor.blue,
                  size: 28,
                ),
                title: CustomText(
                  text: "About Us",
                  size: 20,
                  color: CustomColor.black,
                ),
              ),
            ),
            //================================Terms and Conditions
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const TermsConditions(),
                  ),
                );
              },
              child: const ListTile(
                leading: Icon(
                  Icons.info_outline,
                  color: CustomColor.blue,
                  size: 28,
                ),
                title: CustomText(
                  text: "Terms and Conditions",
                  color: CustomColor.black,
                  size: 20,
                ),
              ),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}

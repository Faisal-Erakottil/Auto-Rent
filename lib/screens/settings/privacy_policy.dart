import 'package:autorent/widgets/custom_colors.dart';
import 'package:autorent/widgets/custom_text.dart';
import 'package:flutter/material.dart';

class PrivacyPolicy extends StatelessWidget {
  const PrivacyPolicy({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            size: 20,
            text: "Privacy and Policy",
            fontWeight: FontWeight.bold,
          ),
          backgroundColor: CustomColor.black,
        ),
        body: const SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(20.0),
            child: Column(
              children: [
                CustomText(
                  text: 'Introduction',
                  fontWeight: FontWeight.bold,
                  size: 20,
                  color: CustomColor.blue,
                ),
                SizedBox(height: 5),
                CustomText(
                  color: CustomColor.black,
                  text:
                      "Thank you for choosing our Offline Rent a Car App (Manage Your business)."
                      "This Privacy Policy is intended to inform you about the types of information we collect and how we use and protect that information."
                      "Your privacy is important to us, and we are committed to ensuring the confidentiality and security of any personal information you provide.",
                ),
                SizedBox(height: 10),
                CustomText(
                  text: "Information we Collect",
                  size: 20,
                  fontWeight: FontWeight.bold,
                  color: CustomColor.blue,
                ),
                SizedBox(height: 5),
                CustomText(
                  color: CustomColor.black,
                  text:
                      "We Collect Name, Image, mobile number and Email Id of the user, for the purpose of personalizing your experience within the App all this details are colected from the User details page"
                      "This information is stored locally on your device and is not transmitted to any external servers.",
                ),
                SizedBox(height: 10),
                CustomText(
                  text: "How we Use Your Information",
                  color: CustomColor.blue,
                  size: 20,
                  fontWeight: FontWeight.bold,
                ),
                SizedBox(height: 5),
                CustomText(
                  color: CustomColor.black,
                  text:
                      "Personalization: Your name,image,mobile number and Email Id is used within the App to personalize your experience and make it more user-friendly",
                ),
                SizedBox(height: 10),
                CustomText(
                  text: "Data Storage and Security",
                  color: CustomColor.blue,
                  size: 20,
                  fontWeight: FontWeight.bold,
                ),
                SizedBox(height: 5),
                CustomText(
                  color: CustomColor.black,
                  text:
                      "Local Storage: All information collected, is stored locally on your device. We do not store any personal information on external servers.",
                ),
                SizedBox(height: 10),
                CustomText(
                  text: "Information Sharing",
                  size: 20,
                  fontWeight: FontWeight.bold,
                  color: CustomColor.blue,
                ),
                SizedBox(height: 5),
                CustomText(
                  text:
                      "No External Sharing: We do not share your personal information with any external third parties.",
                  color: CustomColor.black,
                ),
                SizedBox(height: 10),
                CustomText(
                  text: "Changes to the Privacy Policy",
                  color: CustomColor.blue,
                  fontWeight: FontWeight.bold,
                  size: 20,
                ),
                SizedBox(height: 5),
                CustomText(
                  text:
                      "Any changes made to this Privacy Policy will be communicated through the App. By continuing to use the App, you acknowledge and agree to the updated Privacy Policy.",
                  color: CustomColor.black,
                ),
                SizedBox(height: 10),
                CustomText(
                  text: "Contact Us",
                  color: CustomColor.blue,
                  fontWeight: FontWeight.bold,
                  size: 20,
                ),
                SizedBox(height: 5),
                CustomText(
                    color: CustomColor.black,
                    text:
                        "If you have any questions or concerns about this Privacy Policy or the App's privacy practices, please contact us at [faisalErakottil@gmail.com].")
              ],
            ),
          ),
        ));
  }
}

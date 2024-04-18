// ignore_for_file: no_leading_underscores_for_local_identifiers, use_build_context_synchronously

import 'dart:io';
import 'package:autorent/dataModels/usermodel.dart';
import 'package:autorent/db_functions/db_functions.dart';
import 'package:autorent/screens/home.dart';
import 'package:autorent/widgets/custom_colors.dart';
import 'package:autorent/widgets/custom_text.dart';
import 'package:autorent/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';

class Userdetails extends StatefulWidget {
  const Userdetails({super.key});

  @override
  State<Userdetails> createState() => _UserdetailsState();
}

class _UserdetailsState extends State<Userdetails> {
  final nameController = TextEditingController();
  final mobController = TextEditingController();
  final emailController = TextEditingController();
  File? imagepath;
  String? selectedImage;

  bool validateName = false;
  bool validateMobileNumber = false;
  bool validateEmail = false;

  //===function for selecting image
  Future pickImageFromGallery() async {
    final returnedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (returnedImage != null) {
      setState(() {
        imagepath = File(returnedImage.path);
        selectedImage = returnedImage.path;
      });
    }
  }

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
          text: "User Details",
          fontWeight: FontWeight.bold,
        ),
      ),
      //=============== image picker
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            GestureDetector(
              onTap: pickImageFromGallery,
              child: Center(
                child: CircleAvatar(
                  backgroundColor: Colors.black,
                  radius: 70,
                  child: imagepath != null
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(70),
                          child: Image.file(
                            imagepath!,
                            width: 140,
                            height: 140,
                            fit: BoxFit.cover,
                          ))
                      : const Icon(
                          Icons.add_a_photo,
                          color: Colors.white,
                          size: 50,
                        ),
                ),
              ),
            ),
            const Gap(10),
            Column(
              children: [
                //================= Name field
                CustomTextField(
                  controller: nameController,
                  labelText: "Name",
                  fieldName: "Name",
                  keyboardType: TextInputType.name,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Name is required";
                    }
                    return null;
                  },
                  prefixIcon: Icons.person_outline,
                ),
                const Gap(20),
                //================== Mobils Number
                CustomTextField(
                  labelText: "Mobile Number",
                  fieldName: 'Mobile Number',
                  controller: mobController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Mobile Number is required";
                    }
                    if (value.length != 10) {
                      return 'Mobile number must be 10 digits';
                    }
                    return null;
                  },
                  prefixIcon: Icons.phone_iphone,
                ),
                const Gap(20),
                //================== Email ID
                CustomTextField(
                  labelText: "Email ID",
                  fieldName: "Email ID",
                  controller: emailController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Email ID is required";
                    }
                    if (!RegExp(
                            r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$')
                        .hasMatch(value)) {
                      return "Invalid Email ID";
                    }
                    return null;
                  },
                  prefixIcon: Icons.email_outlined,
                ),
                const Gap(20),
                //================== save Button
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    backgroundColor: Colors.black,
                  ),
                  onPressed: () {
                    setState(() {
                      nameController.text.isEmpty
                          ? validateName = true
                          : validateName = false;
                      mobController.text.isEmpty
                          ? validateMobileNumber = true
                          : validateMobileNumber = false;
                      emailController.text.isEmpty
                          ? validateEmail = true
                          : validateEmail = false;
                      imagepath = null;
                    });
                    if (validateName == false &&
                        validateMobileNumber == false &&
                        validateEmail == false &&
                        selectedImage != null) {
                      UserModel(
                        name: nameController.text,
                        mobile: mobController.text,
                        email: emailController.text,
                        image: imagepath?.path ?? "",
                      );
                    }
                    saveDetails();

                    // onAddSaveButtonClicked();
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const HomePage(),
                      ),
                    );
                  },
                  icon: const Icon(
                    Icons.save,
                    color: CustomColor.white,
                  ),
                  label: const CustomText(
                    text: "Save",
                    color: CustomColor.white,
                    size: 20,
                  ),
                ),
                //==================
              ],
            )
          ],
        ),
      ),
    );
  }

  Future<void> onAddSaveButtonClicked() async {
    final _name = nameController.text.trim();
    final _mobile = mobController.text.trim();
    final _email = emailController.text.trim();
    if (imagepath == null ||
        _name.isEmpty ||
        _mobile.isEmpty ||
        _email.isEmpty) {
      return;
    }
    final userDetails = UserModel(
      name: _name,
      mobile: _mobile,
      email: _email,
      image: imagepath?.path ?? "",
    );
    // Pass the user details back to the previous screen (HomeScreen)
    Navigator.pop(context, userDetails);
  }

  Future<void> saveDetails() async {
    // onAddSaveButtonClicked();
    final name = nameController.text.trim();
    final mobile = mobController.text.trim();
    final email = emailController.text.trim();
    if (imagepath == null || name.isEmpty || mobile.isEmpty || email.isEmpty) {
      return;
    }
    // Save the input data to HiveBox
    final userDetails = UserModel(
      name: name,
      mobile: mobile,
      email: email,
      image: imagepath?.path ?? "",
    );

    await addUser(userDetails);
    getAllData();
  }
}

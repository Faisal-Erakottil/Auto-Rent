// ignore_for_file: prefer_const_constructors, use_super_parameters

import 'dart:io';

import 'package:autorent/dataModels/car_model.dart';
import 'package:autorent/db_functions/db_functions.dart';
import 'package:autorent/widgets/custom_button.dart';
import 'package:autorent/widgets/custom_colors.dart';
import 'package:autorent/widgets/custom_drawer.dart';
import 'package:autorent/widgets/custom_text.dart';
import 'package:autorent/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';

class AddCar extends StatefulWidget {
  const AddCar({Key? key}) : super(key: key);

  @override
  State<AddCar> createState() => _AddCarState();
}

final vehiclenameController = TextEditingController();
final vehicleRegController = TextEditingController();
final carrentcontroller = TextEditingController();
final monthlyrentController = TextEditingController();
File? imagepath;
String? selectedImage;
String? selectedFuel;
String? selectedSeat;
final formKey = GlobalKey<FormState>();

class _AddCarState extends State<AddCar> {
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
        title: CustomText(
          text: "ADD NEW CAR",
          fontWeight: FontWeight.w600,
        ),
        backgroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    left: 20,
                    right: 20,
                    top: 10,
                    bottom: 10,
                  ),
                  child: GestureDetector(
                    onTap: () {
                      pickImageFromGallery();
                    },
                    child: Container(
                      height: 180,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        //border: Border.all(width: .5, color: Colors.black),
                      ),
                      child: Stack(
                        children: [
                          if (imagepath != null) ...[
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.file(
                                imagepath!,
                                width: double.infinity,
                                height: double.infinity,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ] else ...[
                            const Center(
                              child: CustomText(
                                text: "Add Image +",
                                fontWeight: FontWeight.bold,
                                color: CustomColor.black,
                              ),
                            ),
                          ],
                          Positioned(child: Icon(Icons.edit)),
                        ],
                      ),
                    ),
                  ),
                ),
                Gap(15),
                CustomTextField(
                  labelText: 'Car Name',
                  fieldName: 'Car Name',
                  keyboardType: TextInputType.text,
                  controller: vehiclenameController,
                  prefixIcon: Icons.directions_car_outlined,
                ),
                const Gap(15),
                CustomTextField(
                  labelText: 'Registration Number',
                  fieldName: 'Registration Number',
                  keyboardType: TextInputType.text,
                  controller: vehicleRegController,
                  prefixIcon: Icons.pin_outlined,
                ),
                const Gap(15),
                customDropdownField(
                  labelText: 'Fuel',
                  hintText: 'Fuel',
                  prefixIcon: Icons.local_gas_station_outlined,
                  value: selectedFuel,
                  items: ['Petrol', 'Diesel', 'EV', 'CNG'],
                  onChanged: (String? value) {
                    setState(() {
                      selectedFuel = value;
                    });
                  },
                ),
                const Gap(15),
                customDropdownField(
                  labelText: 'Seater',
                  hintText: 'Seater',
                  value: selectedSeat,
                  prefixIcon: Icons.chair_outlined,
                  items: ['2', '4', '5', '7', '8'],
                  onChanged: (String? value) {
                    setState(() {
                      selectedSeat = value;
                    });
                  },
                ),
                const Gap(15),
                CustomTextField(
                  labelText: 'Daily Rent',
                  fieldName: 'Daily Rent',
                  controller: carrentcontroller,
                  keyboardType: TextInputType.number,
                  prefixIcon: Icons.currency_rupee,
                ),
                const Gap(15),
                CustomTextField(
                  labelText: 'Monthly Rent',
                  fieldName: 'Monthly Rent',
                  controller: monthlyrentController,
                  keyboardType: TextInputType.number,
                  prefixIcon: Icons.paid_outlined,
                ),
                const Gap(15),
                customButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      saveDetails();
                    } else {
                      return;
                    }
                  },
                  label: 'SAVE DETAILS',
                  backgroundColor: CustomColor.black,
                  labelColor: CustomColor.white,
                  width: 300,
                  height: 30,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> pickImageFromGallery() async {
    final returnedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (returnedImage != null) {
      setState(() {
        imagepath = File(returnedImage.path);
        selectedImage = returnedImage.path;
      });
    }
  }

  Future<void> saveDetails() async {
    final vehiclename = vehiclenameController.text.trim();
    final vehicleReg = vehicleRegController.text.trim();
    final dailyrent = carrentcontroller.text.trim();
    final monthlyrent = monthlyrentController.text.trim();
    if (imagepath == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select an image.'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }
    if (vehiclename.isEmpty ||
        vehicleReg.isEmpty ||
        selectedFuel == null ||
        selectedSeat == null ||
        dailyrent.isEmpty ||
        monthlyrent.isEmpty) {
      return;
    }
    final carsA = CarModel(
      vehiclename: vehiclename,
      vehicleReg: vehicleReg,
      fuel: selectedFuel!,
      seater: selectedSeat!,
      dailyrent: dailyrent,
      monthlyrent: monthlyrent,
      selectedImage: imagepath?.path ?? "",
    );

    addCar(carsA);
    Navigator.pop(context);

    monthlyrentController.clear();
    vehiclenameController.clear();
    vehicleRegController.clear();
    carrentcontroller.clear();
    setState(() {
      imagepath = null;
      selectedFuel = null;
      selectedSeat = null;
    });
  }
}

// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

import 'dart:io';

import 'package:autorent/dataModels/car_model.dart';
import 'package:autorent/screens/add_car.dart';
import 'package:autorent/widgets/custom_colors.dart';
import 'package:autorent/widgets/custom_drawer.dart';
import 'package:autorent/widgets/custom_text.dart';
import 'package:autorent/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';

class Updatecar extends StatefulWidget {
  final CarModel modelcar;

  const Updatecar({super.key, required this.modelcar});
  @override
  State<Updatecar> createState() => UpdatecarState();
}

class UpdatecarState extends State<Updatecar> {
  var vehiclenameController = TextEditingController();
  var vehicleRegController = TextEditingController();
  var dailyrentController = TextEditingController();
  var monthlyrentController = TextEditingController();
  File? imagepath;
  String? selectedImage;
  String? selectedFuel;
  String? selectedSeat;
  @override
  void initState() {
    vehiclenameController = TextEditingController();
    vehicleRegController = TextEditingController();
    dailyrentController = TextEditingController();
    monthlyrentController = TextEditingController();
    imagepath = null;
    selectedImage = null;
    selectedFuel = null;
    selectedSeat = null;

    vehiclenameController.text = widget.modelcar.vehiclename;
    vehicleRegController.text = widget.modelcar.vehicleReg;
    dailyrentController.text = widget.modelcar.dailyrent;
    monthlyrentController.text = widget.modelcar.monthlyrent;
    selectedSeat = widget.modelcar.seater;
    selectedFuel = widget.modelcar.fuel;
    selectedImage = widget.modelcar.selectedImage;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //=================== AppBar
      appBar: AppBar(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(10),
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
          text: "UPDATE CAR",
          fontWeight: FontWeight.w600,
        ),
        backgroundColor: CustomColor.black,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      left: 20, right: 20, top: 10, bottom: 10),
                  child: GestureDetector(
                    onTap: () {
                      pickImageFromGallery();
                    },
                    child: Container(
                      height: 180,
                      decoration: BoxDecoration(
                        color: CustomColor.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      //=================== image 
                      child: Stack(
                        children: [
                          if (selectedImage != null)
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.file(
                                File(selectedImage!),
                                width: double.infinity,
                                height: double.infinity,
                                fit: BoxFit.cover,
                              ),
                            ),
                          if (selectedImage == null)
                            Center(
                              child: CustomText(
                                text: "Add Image +",
                                fontWeight: FontWeight.bold,
                                color: CustomColor.black,
                              ),
                            ),
                          //========================Edit Icon
                          Positioned(
                            bottom: 10,
                            right: 10,
                            child: Icon(Icons.edit),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                //==============================================vehicle Name
                CustomTextField(
                  labelText: 'Vehicle Name',
                  fieldName: 'Vehicle Name',
                  keyboardType: TextInputType.text,
                  controller: vehiclenameController,
                  prefixIcon: Icons.directions_car,
                ),
                const Gap(15),
                //========================================Registration Number
                CustomTextField(
                  labelText: 'Registration number',
                  fieldName: 'registration number',
                  keyboardType: TextInputType.text,
                  controller: vehicleRegController,
                  prefixIcon: Icons.pin_outlined,
                ),
                const Gap(15),
                //=============================================Fuel Type
                customDropdownField(
                  prefixIcon: Icons.local_gas_station_outlined,
                  labelText: 'Fuel',
                  hintText: 'Fuel',
                  value: selectedFuel,
                  items: ['Petrol', 'Diesel', 'EV', "CNG", 'Hybrid'],
                  onChanged: (String? value) {
                    setState(() {
                      selectedFuel = value;
                    });
                  },
                ),
                const Gap(15),
                //================================================No of Seates
                customDropdownField(
                  prefixIcon: Icons.chair_outlined,
                  labelText: 'Seater',
                  hintText: 'Seater',
                  value: selectedSeat,
                  items: ['2', '4', '5', '7', '8'],
                  onChanged: (String? value) {
                    setState(() {
                      selectedSeat = value;
                    });
                  },
                ),
                const Gap(15),
                //===============================================Daily Rent
                CustomTextField(
                  prefixIcon: Icons.currency_rupee,
                  labelText: 'Daily Rent',
                  fieldName: 'Daily Rent',
                  controller: dailyrentController,
                  keyboardType: TextInputType.number,
                ),
                const Gap(15),
                //===============================================Monthly Rent
                CustomTextField(
                  prefixIcon: Icons.paid_outlined,
                  labelText: 'Monthly Rent',
                  fieldName: 'Monthly Rent',
                  controller: monthlyrentController,
                  keyboardType: TextInputType.number,
                ),
                const Gap(15),
                //==============================================Update Button
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        backgroundColor: CustomColor.black,
                        fixedSize: const Size(300, 30),
                      ),
                      onPressed: () async {
                        widget.modelcar.vehiclename =
                            vehiclenameController.text;
                        widget.modelcar.vehicleReg = vehicleRegController.text;
                        widget.modelcar.dailyrent = dailyrentController.text;
                        widget.modelcar.monthlyrent =
                            monthlyrentController.text;
                        widget.modelcar.seater = selectedSeat ?? "";
                        widget.modelcar.fuel = selectedFuel ?? "";
                        widget.modelcar.selectedImage = selectedImage ?? "";
                        await widget.modelcar.save();

                        Navigator.pop(context);
                      },
                      child: CustomText(
                        text: 'UPDATE',
                        size: 18,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

//=================================================Image Picker Function
  Future<void> pickImageFromGallery() async {
    final returnedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (returnedImage != null) {
      setState(() {
        selectedImage = returnedImage.path;
      });
    }
  }
}

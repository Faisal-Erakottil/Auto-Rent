

// ignore_for_file: prefer_const_constructors, camel_case_types, use_super_parameters

import 'dart:io';

import 'package:autorent/dataModels/box.dart';
import 'package:autorent/dataModels/car_model.dart';
import 'package:autorent/db_functions/db_functions.dart';
import 'package:autorent/screens/update_car.dart';
import 'package:autorent/widgets/custom_colors.dart';
import 'package:autorent/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class cardetails extends StatefulWidget {
  final CarModel cars;

  const cardetails({Key? key, required this.cars}) : super(key: key);

  @override
  State<cardetails> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<cardetails> {
  var vehiclenameController = TextEditingController();
  var vehicleRegController = TextEditingController();
  var dailyrentController = TextEditingController();
  var monthlyrentController = TextEditingController();
  File? imagepath;
  String? selectedImage;
  String? selectedFuel;
  String? selectedSeat;
//================================= Selected Image
  Widget _buildSelectedImage() {
    return SizedBox(
      height: 220,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: 520,
            height: 220,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: widget.cars.selectedImage.isNotEmpty
                ? Image.file(
                    File(widget.cars.selectedImage),
                    fit: BoxFit.cover,
                    width: 420,
                    height: 220,
                  )
                : Container(),
          ),
        ],
      ),
    );
  }

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
              )),
          centerTitle: true,
          title: CustomText(
            text: "CAR DETAILS",
            fontWeight: FontWeight.w600,
            size: 18,
          ),
          backgroundColor: CustomColor.black),
      body: ValueListenableBuilder<Box<CarModel>>(
          valueListenable: Boxes.getData().listenable(),
          builder: (context, box, _) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: _buildSelectedImage(),
                  ),
                  const SizedBox(height: 40),
                  Container(
                    width: 300,
                    height: 250,
                    decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 250, 250, 250),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 15),
                        Padding(
                          padding: const EdgeInsets.only(left: 30, right: 30),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CustomText(
                                text: "Name",
                                fontWeight: FontWeight.w600,
                                color: CustomColor.blue,
                              ),
                              CustomText(
                                text: widget.cars.vehiclename,
                                fontWeight: FontWeight.w600,
                                color: CustomColor.black,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 15),
                        Padding(
                          padding: const EdgeInsets.only(left: 30, right: 30),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const CustomText(
                                text: "REG number",
                                fontWeight: FontWeight.w600,
                                color: CustomColor.blue,
                              ),
                              CustomText(
                                text: widget.cars.vehicleReg,
                                color: Colors.black,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 15),
                        Padding(
                          padding: const EdgeInsets.only(left: 30, right: 30),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CustomText(
                                text: "Fuel",
                                color: CustomColor.blue,
                                fontWeight: FontWeight.w600,
                              ),
                              CustomText(
                                text: widget.cars.fuel,
                                color: CustomColor.black,
                                fontWeight: FontWeight.w600,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 15),
                        Padding(
                          padding: const EdgeInsets.only(left: 30, right: 30),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CustomText(
                                text: "Seater",
                                color: CustomColor.blue,
                                fontWeight: FontWeight.w600,
                              ),
                              CustomText(
                                text: widget.cars.seater,
                                fontWeight: FontWeight.w600,
                                color: CustomColor.black,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 15),
                        Padding(
                          padding: const EdgeInsets.only(left: 30, right: 30),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CustomText(
                                text: "Daily Rent",
                                color: CustomColor.blue,
                                fontWeight: FontWeight.w600,
                              ),
                              CustomText(
                                text: widget.cars.dailyrent,
                                color: CustomColor.black,
                                fontWeight: FontWeight.w600,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 15),
                        Padding(
                          padding: const EdgeInsets.only(left: 30, right: 30),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const CustomText(
                                text: "Monthly Rent",
                                color: CustomColor.blue,
                                fontWeight: FontWeight.w600,
                              ),
                              CustomText(
                                text: widget.cars.monthlyrent,
                                color: CustomColor.black,
                                fontWeight: FontWeight.w600,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              // Return an alert dialog
                              return AlertDialog(
                                backgroundColor: CustomColor.primary,
                                title: CustomText(
                                  text: "Confirm Deletion",
                                  size: 20,
                                ),
                                content: CustomText(
                                  text:
                                      "Are you sure you want to delete this car?",
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: CustomText(
                                      text: "CANCEL",
                                      color: CustomColor.green,
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      deletecar(widget.cars);
                                      Navigator.popUntil(
                                          context, (route) => route.isFirst);
                                    },
                                    child: CustomText(text:"DELETE",color: CustomColor.red,),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: CustomColor.red,
                          foregroundColor: CustomColor.black,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(22),
                          ),
                          elevation: 3,
                        ),
                        child: CustomText(
                          text: 'DELETE',
                          fontWeight: FontWeight.w600,
                          color: CustomColor.black,
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          editCar(
                              widget.cars,
                              widget.cars.vehiclename.toString(),
                              widget.cars.vehicleReg.toString(),
                              widget.cars.fuel.toString(),
                              widget.cars.seater.toString(),
                              widget.cars.dailyrent.toString(),
                              widget.cars.monthlyrent.toString(),
                              widget.cars.selectedImage.toString());
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: CustomColor.green,
                          foregroundColor: CustomColor.black,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(22),
                          ),
                          elevation: 3,
                        ),
                        child: CustomText(
                          text: 'UPDATE',
                          color: CustomColor.black,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            );
          }),
    );
  }

  Future<void> editCar(
    CarModel modelcar,
    String carName,
    String carReg,
    String fuel,
    String seater,
    String rentDaily,
    String rentMonthly,
    String carImage,
  ) async {
    vehiclenameController.text = carName;
    vehicleRegController.text = carReg;
    dailyrentController.text = rentDaily;
    monthlyrentController.text = rentMonthly;
    selectedSeat = seater;
    selectedFuel = fuel;
    selectedImage = carImage;
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => Updatecar(modelcar: modelcar),
    ));
  }
}
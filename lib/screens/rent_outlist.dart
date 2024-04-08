// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:autorent/dataModels/box.dart';
import 'package:autorent/dataModels/car_model.dart';
import 'package:autorent/dataModels/customer_model.dart';
import 'package:autorent/screens/dropoffdetails.dart';
import 'package:autorent/widgets/custom_colors.dart';
import 'package:autorent/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hive_flutter/hive_flutter.dart';

class RentOutCars extends StatefulWidget {
  final CarModel? selectedCar;
  const RentOutCars({super.key, this.selectedCar});

  @override
  State<RentOutCars> createState() => _RentOutCarsState();
}

class _RentOutCarsState extends State<RentOutCars> {
  final carnameController = TextEditingController();
  final carRegController = TextEditingController();
  final customerNameController = TextEditingController();
  final mobileNumberController = TextEditingController();
  final licenseNumberController = TextEditingController();
  final pickupdate = TextEditingController();
  final pickupTime = TextEditingController();
  final dropOffDate = TextEditingController();
  final securityDepositController = TextEditingController();
  String? selectedImage;
  File? imagepath;

  TimeOfDay timeOfDay = TimeOfDay.now();
  @override
  void initState() {
    super.initState();
    if (widget.selectedCar != null) {
      selectedImage = widget.selectedCar!.selectedImage;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColor.black,
      body: ValueListenableBuilder<Box<CustomerModel>>(
          valueListenable: Boxes.getCustomerData().listenable(),
          builder: (context, box, _) {
            var data = box.values.toList().cast<CustomerModel>();
            if (data.isEmpty) {
              return const Center(
                child: CustomText(
                  text: 'NO RENTOUT CARS',
                  fontWeight: FontWeight.bold,
                  size: 18,
                ),
              );
            } else {
              return ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, int index) {
                  bool isLastItem = index == data.length - 1;
                  return Padding(
                    padding: EdgeInsets.only(
                      bottom: isLastItem ? 75 : 0,
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Card(
                        color: Colors.white,
                        elevation: 5,
                        child: SizedBox(
                          height: 230,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 10.0, right: 20),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                        left: 15,
                                        top: 10,
                                      ),
                                      child: CustomText(
                                        text: data[index].carReg,
                                        color: CustomColor.black,
                                        size: 16,
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        CustomText(
                                          text: data[index].customerName,
                                          color: CustomColor.black,
                                          size: 18,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    height: 140,
                                    width: 200,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      image: DecorationImage(
                                        image: FileImage(
                                          File(data[index].selectedImage),
                                        ),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              Row(
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 15),
                                        child: CustomText(
                                          text: data[index].carname,
                                          fontWeight: FontWeight.bold,
                                          color: CustomColor.black,
                                          size: 18,
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          SizedBox(width: 15),
                                          CustomText(
                                            text: data[index].pickupdate,
                                            size: 16,
                                            color: CustomColor.red,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Gap(10),
                                  Column(
                                    children: [
                                      Padding(
                                          padding: EdgeInsets.only(left: 140),
                                          child: ElevatedButton(
                                            onPressed: () {
                                              Navigator.of(context).push(
                                                MaterialPageRoute(
                                                  builder: (ctx) =>
                                                      Dropoffdetails(
                                                    customer: data[index],
                                                  ),
                                                ),
                                              );
                                            },
                                            style: ElevatedButton.styleFrom(
                                              elevation: 5,
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 15),
                                              minimumSize: const Size(90, 40),
                                              backgroundColor:
                                                  CustomColor.green,
                                              foregroundColor:
                                                  CustomColor.black,
                                            ),
                                            child: CustomText(
                                              text: "Drop Off",
                                              color: CustomColor.black,
                                            ),
                                          ))
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              );
            }
          }),
    );
  }
}

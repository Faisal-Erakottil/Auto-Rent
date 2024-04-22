// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:autorent/dataModels/box.dart';
import 'package:autorent/dataModels/car_model.dart';
import 'package:autorent/dataModels/history_model.dart';
import 'package:autorent/screens/history_details.dart';
import 'package:autorent/widgets/custom_colors.dart';
import 'package:autorent/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HistoryScreen extends StatefulWidget {
  final CarModel? selectedCar;
  const HistoryScreen({super.key, this.selectedCar});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
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
          text: "HISTORY",
          size: 18,
          fontWeight: FontWeight.bold,
        ),
        backgroundColor: CustomColor.black,
      ),
      body: ValueListenableBuilder<Box<HistoryModel>>(
          valueListenable: Boxes.getHistory().listenable(),
          builder: (context, box, _) {
            var data = box.values.toList().cast<HistoryModel>();
            if (data.isEmpty) {
              return const Center(
                child: CustomText(
                  text: 'NO History Found',
                  fontWeight: FontWeight.bold,
                  size: 18,
                ),
              );
            } else {
              return ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, int index) {
                  return Padding(
                    padding: EdgeInsets.all(5),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (ctx) => HistoryDetails(
                              history: data[index],
                            ),
                          ),
                        );
                      },
                      child: Card(
                        color: Colors.white,
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
                                        text: data[index].vehicleReg,
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
                                          text: data[index].vehiclename,
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
                                            color: CustomColor.black,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Gap(10),
                                  Row(
                                    children: [
                                      Padding(
                                        padding:
                                            EdgeInsets.only(left: 40, top: 22),
                                        child: CustomText(
                                          text: data[index].dropOffDate,
                                          color: CustomColor.black,
                                          fontWeight: FontWeight.bold,
                                          size: 16,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 35, top: 22),
                                        child: CustomText(
                                          text: data[index].vehicleDailyRent,
                                          color: CustomColor.green,
                                          fontWeight: FontWeight.bold,
                                          size: 20,
                                        ),
                                      ),
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

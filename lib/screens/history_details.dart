// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:autorent/dataModels/box.dart';
import 'package:autorent/dataModels/history_model.dart';
import 'package:autorent/widgets/custom_colors.dart';
import 'package:autorent/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HistoryDetails extends StatefulWidget {
  final HistoryModel history;

  const HistoryDetails({super.key, required this.history});

  @override
  State<HistoryDetails> createState() => _HistoryDetailsState();
}

class _HistoryDetailsState extends State<HistoryDetails> {
  final carnameController = TextEditingController();
  final carRegController = TextEditingController();
  final customerNameController = TextEditingController();
  final mobileNumberController = TextEditingController();
  final licenseNumberController = TextEditingController();
  final dailyRentController = TextEditingController();
  final pickupdate = TextEditingController();
  final pickupTime = TextEditingController();
  final dropOffDate = TextEditingController();
  final securityDepositController = TextEditingController();
  double totalRent = 0.0;
  String? selectedImage;
  File? imagepath;
  //=================================image
  Widget _buildSelectedImage() {
    return SizedBox(
      height: 220,
      child: Stack(
        alignment: Alignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: widget.history.selectedImage.isNotEmpty
                ? Image.file(
                    File(widget.history.selectedImage),
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
      //======================= AppBar
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
          text: "DETAILS",
          size: 18,
          fontWeight: FontWeight.bold,
        ),
        backgroundColor: CustomColor.black,
      ),
      body: ValueListenableBuilder<Box<HistoryModel>>(
        valueListenable: Boxes.getHistory().listenable(),
        builder:
            (BuildContext context, Box<HistoryModel> value, Widget? child) {
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
                  height: 380,
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 250, 250, 250),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 15),
                      //===================== Customer name
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Customer name",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: CustomColor.blue,
                            ),
                          ),
                          CustomText(
                              text: widget.history.customerName,
                              color: CustomColor.black),
                        ],
                      ),
                      const SizedBox(height: 15),
                      //======================= Rent out car
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const CustomText(
                            text: "Rent out car",
                            fontWeight: FontWeight.bold,
                            color: CustomColor.blue,
                          ),
                          CustomText(
                              text: widget.history.vehiclename,
                              color: CustomColor.black),
                        ],
                      ),
                      const SizedBox(height: 15),
                      //=============================Daily rent
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const CustomText(
                            text: "Daily Rent",
                            color: CustomColor.blue,
                            fontWeight: FontWeight.bold,
                          ),
                          CustomText(
                            text: widget.history.vehicleDailyRent,
                            color: CustomColor.black,
                          ),
                        ],
                      ),
                      const SizedBox(height: 15),
                      //===========================Mobile number
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const CustomText(
                            text: "Mobile number",
                            color: CustomColor.blue,
                          ),
                          CustomText(
                              text: widget.history.mobileNumber,
                              color: CustomColor.black),
                        ],
                      ),
                      const SizedBox(height: 15),
                      //======================= License number
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const CustomText(
                            text: "License number",
                            color: CustomColor.blue,
                          ),
                          CustomText(
                              text: widget.history.licenseNumber,
                              color: CustomColor.black),
                        ],
                      ),
                      const SizedBox(height: 15),
                      //========================= Pickup date
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const CustomText(
                            text: "Pickup date",
                            fontWeight: FontWeight.bold,
                            color: CustomColor.blue,
                          ),
                          CustomText(
                              text: widget.history.pickupdate,
                              color: CustomColor.black),
                        ],
                      ),
                      const SizedBox(height: 15),
                      //======================== pickup time
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const CustomText(
                            text: "Pickup time",
                            fontWeight: FontWeight.bold,
                            color: CustomColor.blue,
                          ),
                          CustomText(
                              text: widget.history.pickupTime,
                              color: CustomColor.black),
                        ],
                      ),
                      const SizedBox(height: 15),
                      //======================== Drop off date
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const CustomText(
                            text: "Drop off date",
                            fontWeight: FontWeight.bold,
                            color: CustomColor.blue,
                          ),
                          CustomText(
                              text: widget.history.dropOffDate,
                              color: CustomColor.black),
                        ],
                      ),
                      const SizedBox(height: 15),
                      //========================== Security deposit
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const CustomText(
                            text: "Security deposit",
                            color: CustomColor.blue,
                            fontWeight: FontWeight.bold,
                          ),
                          CustomText(
                            text: widget.history.securityDeposit,
                            color: CustomColor.black,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

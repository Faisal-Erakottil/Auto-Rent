// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:autorent/dataModels/box.dart';
import 'package:autorent/dataModels/customer_model.dart';
import 'package:autorent/screens/update_customer.dart';
import 'package:autorent/widgets/custom_colors.dart';
import 'package:autorent/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class CustomerDetails extends StatefulWidget {
  final CustomerModel customer;

  const CustomerDetails({super.key, required this.customer});

  @override
  State<CustomerDetails> createState() => _CustomerDetailsState();
}

class _CustomerDetailsState extends State<CustomerDetails> {
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

  Widget _buildSelectedImage() {
    return SizedBox(
      height: 220,
      child: Stack(
        alignment: Alignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: widget.customer.selectedImage.isNotEmpty
                ? Image.file(
                    File(widget.customer.selectedImage),
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
            text: "CUSTOMER DETAILS",
            size: 18,
            fontWeight: FontWeight.bold,
          ),
          backgroundColor: CustomColor.black),
      body: ValueListenableBuilder<Box<CustomerModel>>(
        valueListenable: Boxes.getCustomerData().listenable(),
        builder:
            (BuildContext context, Box<CustomerModel> value, Widget? child) {
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
                  height: 340,
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 250, 250, 250),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 15),
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
                              text: widget.customer.customerName,
                              color: CustomColor.black),
                        ],
                      ),
                      const SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const CustomText(
                            text: "Rent out car",
                            fontWeight: FontWeight.bold,
                            color: CustomColor.blue,
                          ),
                          CustomText(
                              text: widget.customer.carname,
                              color: CustomColor.black),
                        ],
                      ),
                      const SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const CustomText(
                            text: "Mobile number",
                            color: CustomColor.blue,
                          ),
                          CustomText(
                              text: widget.customer.mobileNumber,
                              color: CustomColor.black),
                        ],
                      ),
                      const SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const CustomText(
                            text: "License number",
                            color: CustomColor.blue,
                          ),
                          CustomText(
                              text: widget.customer.licenseNumber,
                              color: CustomColor.black),
                        ],
                      ),
                      const SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const CustomText(
                            text: "Pickup date",
                            fontWeight: FontWeight.bold,
                            color: CustomColor.blue,
                          ),
                          CustomText(
                              text: widget.customer.pickupdate,
                              color: CustomColor.black),
                        ],
                      ),
                      const SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const CustomText(
                            text: "Pickup time",
                            fontWeight: FontWeight.bold,
                            color: CustomColor.blue,
                          ),
                          CustomText(
                              text: widget.customer.pickupTime,
                              color: CustomColor.black),
                        ],
                      ),
                      const SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const CustomText(
                            text: "Drop off date",
                            fontWeight: FontWeight.bold,
                            color: CustomColor.blue,
                          ),
                          CustomText(
                              text: widget.customer.dropOffDate,
                              color: CustomColor.black),
                        ],
                      ),
                      const SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const CustomText(
                            text: "Security deposit received",
                            color: CustomColor.blue,
                            fontWeight: FontWeight.bold,
                          ),
                          CustomText(
                              text: widget.customer.securityDeposit,
                              color: CustomColor.black),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        editCus(
                          widget.customer,
                          widget.customer.selectedImage.toString(),
                          widget.customer.carname.toString(),
                          widget.customer.carReg.toString(),
                          widget.customer.customerName.toString(),
                          widget.customer.mobileNumber.toString(),
                          widget.customer.licenseNumber.toString(),
                          widget.customer.pickupdate.toString(),
                          widget.customer.pickupTime.toString(),
                          widget.customer.dropOffDate.toString(),
                          widget.customer.securityDeposit.toString(),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: CustomColor.black,
                        foregroundColor: CustomColor.white,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 90, vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        elevation: 3,
                      ),
                      child: const Text('UPDATE'),
                    ),
                  ],
                ),
                const SizedBox(height: 40),
              ],
            ),
          );
        },
      ),
    );
  }

  Future<void> editCus(
    CustomerModel customer,
    String carname,
    String carReg,
    String customerName,
    String mobileNumber,
    String licenseNumber,
    String pickupdate,
    String pickupTime,
    String dropOffDate,
    String security,
    String cuscarImage,
  ) async {
    carnameController.text = carname;
    carRegController.text = carReg;
    customerNameController.text = customerName;
    mobileNumberController.text = mobileNumber;
    licenseNumberController.text = licenseNumber;
    pickupdate = pickupdate;
    pickupTime = pickupTime;
    dropOffDate = dropOffDate;
    securityDepositController.text = security;
    selectedImage = cuscarImage;
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => Updatecustomer(customer: customer),
    ));
  }
}

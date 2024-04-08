

// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

import 'dart:io';

import 'package:autorent/dataModels/box.dart';
import 'package:autorent/dataModels/car_model.dart';
import 'package:autorent/dataModels/customer_model.dart';
import 'package:autorent/db_functions/db_functions.dart';
import 'package:autorent/screens/add_car.dart';
import 'package:autorent/widgets/custom_colors.dart';
import 'package:autorent/widgets/custom_text.dart';
import 'package:autorent/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';

class Dropoffdetails extends StatefulWidget {
  final CustomerModel customer;
  final CarModel? carModel;
  const Dropoffdetails({
    super.key,
    required this.customer,
    this.carModel,
  });

  @override
  State<Dropoffdetails> createState() => _DropfofdetailsState();
}

class _DropfofdetailsState extends State<Dropoffdetails> {
  var carnameController = TextEditingController();
  var carRegController = TextEditingController();
  var carRentController = TextEditingController();
  var customerNameController = TextEditingController();
  var mobileNumberController = TextEditingController();
  var licenseNumberController = TextEditingController();
  var pickupdate = TextEditingController();
  var pickupTime = TextEditingController();
  var dropOffDate = TextEditingController();
  var droppOfftime = TextEditingController();
  var monthlyrentController = TextEditingController();
  var carseater = TextEditingController();
  var carfuel = TextEditingController();
  double totalRent = 0.0;
  var securityDepositController = TextEditingController();
  String? selectedImage;
  File? imagepath;

  @override
  void initState() {
    carnameController = TextEditingController();
    carRegController = TextEditingController();
    carRentController = TextEditingController();
    customerNameController = TextEditingController();
    mobileNumberController = TextEditingController();
    licenseNumberController = TextEditingController();
    pickupdate = TextEditingController();
    pickupTime = TextEditingController();
    dropOffDate = TextEditingController();
    securityDepositController = TextEditingController();
    monthlyrentController = TextEditingController();
    carseater = TextEditingController();
    carfuel = TextEditingController();
    selectedImage = selectedImage;
    carnameController.text = widget.customer.carname;
    carRegController.text = widget.customer.carReg;
    carRentController.text = widget.customer.carDailyRent;
    customerNameController.text = widget.customer.customerName;
    mobileNumberController.text = widget.customer.mobileNumber;
    licenseNumberController.text = widget.customer.licenseNumber;
    selectedImage = widget.customer.selectedImage;
    dropOffDate.text = widget.customer.dropOffDate;
    pickupdate.text = widget.customer.pickupdate;
    pickupTime.text = widget.customer.pickupTime;
    securityDepositController.text = widget.customer.securityDeposit;
    monthlyrentController.text = widget.customer.carMonthlyRent!;
    carfuel.text = widget.customer.carfuel!;
    carseater.text = widget.customer.carseater!;
    updateTotalRent();
    super.initState();
  }

  Widget _buildSelectedImage() {
    return SizedBox(
      height: 150,
      child: Stack(
        alignment: Alignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: selectedImage != null && selectedImage!.isNotEmpty
                ? Image.file(
                    File(selectedImage!),
                    width: double.infinity,
                    height: double.infinity,
                    fit: BoxFit.cover,
                  )
                : Container(),
          ),
        ],
      ),
    );
  }

  void updateTotalRent() {
    if (dropOffDate.text.isNotEmpty && droppOfftime.text.isNotEmpty) {
      DateTime pickupDateTime = DateFormat('yyyy-MM-dd HH:mm')
          .parse('${widget.customer.pickupdate} ${widget.customer.pickupTime}');

      String combinedDateTimeString =
          '${dropOffDate.text} ${droppOfftime.text}';

      DateTime dropOffDateTime =
          DateFormat('yyyy-MM-dd HH:mm').parse(combinedDateTimeString);

      totalRent = calculateTotalRent(
        pickupDateTime,
        dropOffDateTime,
        double.parse(carRentController.text),
      );
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Box<CustomerModel>>(
        valueListenable: Boxes.getCustomerData().listenable(),
        builder: (context, box, _) {
          return ValueListenableBuilder<Box<CarModel>>(
              valueListenable: Boxes.getData().listenable(),
              builder: (context, carBox, _) {
                return Scaffold(
                  backgroundColor: const Color.fromARGB(255, 240, 251, 252),
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
                      text: "DROP OF DETAILS",
                      fontWeight: FontWeight.w600,
                    ),
                    backgroundColor: CustomColor.black,
                  ),
                  body: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Form(
                        child: Column(
                          children: [
                            _buildSelectedImage(),
                            const Gap(15),
                            CustomTextField(
                              labelText: 'car name',
                              fieldName: 'carname',
                              controller: carnameController,
                              enable: false,
                            ),
                            const Gap(15),
                            CustomTextField(
                              labelText: 'Daily Rent',
                              fieldName: 'Daily Rent',
                              controller: carRentController,
                              enable: false,
                            ),
                            const Gap(15),
                            CustomTextField(
                              labelText: 'Car reg number',
                              fieldName: 'Car reg number',
                              controller: carRegController,
                              enable: false,
                            ),
                            const Gap(15),
                            CustomTextField(
                              labelText: 'Customer Name',
                              fieldName: 'Customer Name',
                              controller: customerNameController,
                              enable: false,
                            ),
                            const Gap(15),
                            CustomTextField(
                              labelText: 'Mobile Number',
                              fieldName: 'Mobile Number',
                              controller: mobileNumberController,
                              enable: false,
                            ),
                            const Gap(15),
                            CustomTextField(
                              labelText: 'License Number',
                              fieldName: 'License Number',
                              controller: licenseNumberController,
                              enable: false,
                            ),
                            const Gap(15),
                            CustomTextField(
                              labelText: 'Pickup Date',
                              fieldName: 'Pickup Date',
                              controller: pickupdate,
                              enable: false,
                            ),
                            const Gap(15),
                            CustomTextField(
                              labelText: 'Pickup Time',
                              fieldName: 'Pickup Time',
                              controller: pickupTime,
                              enable: false,
                            ),
                            const Gap(15),
                            CustomTextField(
                              labelText: 'Drop Off Date',
                              fieldName: 'Drop Off Date',
                              controller: dropOffDate,
                              enable: false,
                            ),
                            const Gap(15),
                            CustomTextField(
                              labelText: 'Security Deposit',
                              fieldName: 'Security Deposit',
                              controller: securityDepositController,
                              enable: false,
                            ),
                            const Gap(15),
                            TextFormField(
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              decoration: const InputDecoration(
                                icon: Icon(Icons.access_time),
                                labelText: 'DropOff Time',
                                hintText: 'DropOff Time',
                              ),
                              controller: droppOfftime,
                              onTap: () async {
                                TimeOfDay currentTime = TimeOfDay.now();
                                TimeOfDay? selectedTime = await showTimePicker(
                                  context: context,
                                  initialTime: currentTime,
                                );

                                if (selectedTime != null) {
                                  droppOfftime.text =
                                      selectedTime.format(context);
                                  formKey.currentState?.validate();
                                  updateTotalRent();
                                }
                              },
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please pick a time';
                                }
                                return null;
                              },
                            ),
                            const Gap(15),
                            Container(
                              alignment: Alignment.center,
                              padding: const EdgeInsets.all(10),
                              color: CustomColor.primary,
                              child: CustomText(
                                text: 'Total Rent: $totalRent',
                                color: CustomColor.blue,
                                size: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const Gap(20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    backgroundColor: CustomColor.black,
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 16,
                                      horizontal: 52,
                                    ),
                                  ),
                                  onPressed: () {
                                    if (droppOfftime.text.isEmpty) {
                                      // Show a dialog or a snackbar to inform the user to pick a drop-off time
                                      showDialog(
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                            backgroundColor: CustomColor.black,
                                            title: CustomText(
                                              text: 'Value is empty',
                                              size: 18,
                                              fontWeight: FontWeight.w600,
                                            ),
                                            content: CustomText(
                                                text: 'Please pick a drop-off time.',
                                                size: 18,
                                                ),
                                            actions: <Widget>[
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                                child: CustomText(text:'OK',size: 18,color: CustomColor.blue,),
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    } else {
                                      // Proceed with dropping off the details
                                      Navigator.pop(context);
                                      removeCustomerFromScreen(widget.customer);
                                      saveDetails();
                                    }
                                  },
                                  child: CustomText(
                                    text: 'DROP OFF',
                                    fontWeight: FontWeight.w600,
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
              });
        });
  }

  double calculateTotalRent(
    DateTime pickupDateTime,
    DateTime dropOffDateTime,
    double dailyRent,
  ) {
    Duration timeDifference = dropOffDateTime.difference(pickupDateTime);

    double totalDays = timeDifference.inDays.toDouble();
    double totalHours = timeDifference.inHours.toDouble() % 24;

    double totalRent =
        (totalDays * dailyRent) + ((totalHours / 24) * dailyRent);

    totalRent = double.parse(totalRent.toStringAsFixed(2));

    return totalRent;
  }

  Future<void> saveDetails() async {
    final vehiclename = widget.customer.carname;
    final vehicleReg = widget.customer.carReg;
    final dailyrent = widget.customer.carDailyRent;
    final monthlyrent = widget.customer.carMonthlyRent;
    final carfuel = widget.customer.carfuel;
    final carseater = widget.customer.carseater;
    final imagepath = widget.customer.selectedImage;

    final carsA = CarModel(
        vehiclename: vehiclename,
        vehicleReg: vehicleReg,
        fuel: carfuel!,
        seater: carseater!,
        dailyrent: dailyrent,
        monthlyrent: monthlyrent!,
        selectedImage: imagepath);

    addCar(carsA);
  }
}
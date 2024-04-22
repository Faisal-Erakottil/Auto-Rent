// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

import 'dart:io';

import 'package:autorent/dataModels/box.dart';
import 'package:autorent/dataModels/car_model.dart';
import 'package:autorent/dataModels/customer_model.dart';
import 'package:autorent/dataModels/history_model.dart';
import 'package:autorent/db_functions/db_functions.dart';
import 'package:autorent/widgets/custom_colors.dart';
import 'package:autorent/widgets/custom_text.dart';
import 'package:autorent/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';

class AddCustomer extends StatefulWidget {
  final CarModel? selectedCar;
  const AddCustomer({super.key, this.selectedCar});

  @override
  State<AddCustomer> createState() => _AddCustomerState();
}

final carnameController = TextEditingController();
final carRegController = TextEditingController();
final carrentcontroller = TextEditingController();
final customerNameController = TextEditingController();
final mobileNumberController = TextEditingController();
final licenseNumberController = TextEditingController();
final pickupdate = TextEditingController();
final pickupTime = TextEditingController();
final dropOffDate = TextEditingController();
final securityDepositController = TextEditingController();
String? selectedImage;
File? imagepath;

final GlobalKey<FormState> formKey = GlobalKey<FormState>();

class _AddCustomerState extends State<AddCustomer> {
  @override
  void initState() {
    super.initState();
    if (widget.selectedCar != null) {
      carnameController.text = widget.selectedCar!.vehiclename;
      carRegController.text = widget.selectedCar!.vehicleReg;
      selectedImage = widget.selectedCar!.selectedImage;
      carrentcontroller.text = widget.selectedCar!.dailyrent;
      // monthlyrentController.text = widget.selectedCar!.monthlyrent;
    }
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

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Box<CarModel>>(
        valueListenable: Boxes.getData().listenable(),
        builder: (context, box, _) {
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.black,
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
                text: "ADD CUSTOMER",
                size: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      _buildSelectedImage(),
                      const Gap(15),
                      CustomTextField(
                        labelText: 'Car Name',
                        fieldName: 'Car Name',
                        controller: carnameController,
                        keyboardType: TextInputType.text,
                        prefixIcon: Icons.directions_car,
                        enable: false,
                      ),
                      const Gap(15),
                      CustomTextField(
                        enable: false,
                        labelText: 'Daily Rent',
                        fieldName: 'Daily Rent',
                        controller: carrentcontroller,
                        prefixIcon: Icons.currency_rupee,
                      ),
                      const Gap(15),
                      CustomTextField(
                        labelText: 'Car reg Number',
                        fieldName: 'Car Reg Number',
                        keyboardType: TextInputType.text,
                        controller: carRegController,
                        prefixIcon: Icons.pin_outlined,
                        enable: false,
                      ),
                      const Gap(15),
                      CustomTextField(
                        labelText: 'customer Name',
                        fieldName: 'customer Name',
                        controller: customerNameController,
                        keyboardType: TextInputType.text,
                        prefixIcon: Icons.person_outline,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Value is empty';
                          } else {
                            return null;
                          }
                        },
                      ),
                      const Gap(15),
                      CustomTextField(
                          labelText: 'Mobile Number',
                          fieldName: 'Mobile Number',
                          controller: mobileNumberController,
                          keyboardType: TextInputType.number,
                          prefixIcon: Icons.phone_iphone,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a mobile number';
                            }
                            if (value.length != 10) {
                              return 'Mobile number must be 10 digits';
                            }
                            return null;
                          }),
                      const Gap(15),
                      CustomTextField(
                        controller: licenseNumberController,
                        labelText: 'License Number',
                        fieldName: 'License Number',
                        prefixIcon: Icons.badge_outlined,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a license number';
                          }
                          if (!RegExp(r'^[A-Z]{2}\d{2}\d{4}\d{7}$')
                              .hasMatch(value)) {
                            return 'Invalid license number';
                          }
                          return null;
                        },
                      ),
                      const Gap(15),
                      //==================================Pickup Date
                      TextFormField(
                        style: TextStyle(color: CustomColor.black),
                        decoration: InputDecoration(
                          //icon: Icon(Icons.calendar_today_rounded),
                          labelText: 'Pickup Date',
                          hintText: 'Pickup Date',
                          filled: true,
                          fillColor: CustomColor.white,
                          prefixIcon: Icon(Icons.today),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(
                              color: Colors.black,
                              width: 1.0,
                            ),
                          ),
                        ),
                        controller: pickupdate,
                        onTap: () async {
                          DateTime currentDate = DateTime.now();
                          DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: currentDate,
                            firstDate: currentDate,
                            lastDate: DateTime(2030),
                          );

                          if (pickedDate != null) {
                            pickupdate.text =
                                DateFormat('dd-MM-yyyy').format(pickedDate);

                            formKey.currentState?.validate();
                          }
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please pick a date';
                          }
                          return null;
                        },
                      ),
                      const Gap(15),
                      TextFormField(
                        style: TextStyle(color: CustomColor.black),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        decoration: const InputDecoration(
                          labelText: 'Pickup Time',
                          hintText: 'Pickup Time',
                          filled: true,
                          fillColor: CustomColor.white,
                          prefixIcon: Icon(Icons.access_time),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                            borderSide: BorderSide(
                              color: CustomColor.black,
                              width: 1.0,
                            ),
                          ),
                        ),
                        controller: pickupTime,
                        onTap: () async {
                          TimeOfDay currentTime = TimeOfDay.now();
                          TimeOfDay? pickedTime = await showTimePicker(
                            context: context,
                            initialTime: currentTime,
                          );

                          if (pickedTime != null) {
                            pickupTime.text = pickedTime.format(context);

                            formKey.currentState?.validate();
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
                      TextFormField(
                        style: TextStyle(color: CustomColor.black),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        decoration: const InputDecoration(
                          labelText: 'Drop Off Date',
                          hintText: 'Drop Off Date',
                          prefixIcon: Icon(Icons.calendar_today_outlined),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                            borderSide: BorderSide(
                              color: Colors.black,
                              width: 1.0,
                            ),
                          ),
                        ),
                        controller: dropOffDate,
                        onTap: () async {
                          DateTime currentDate = DateTime.now();
                          DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: currentDate,
                            firstDate: currentDate,
                            lastDate: DateTime(2100),
                          );

                          if (pickedDate != null) {
                            dropOffDate.text =
                                DateFormat('dd-MM-yyyy').format(pickedDate);
                            formKey.currentState?.validate();
                          }
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please pick a drop-off date';
                          }
                          return null;
                        },
                      ),
                      const Gap(15),
                      CustomTextField(
                        labelText: 'Security Deposit',
                        fieldName: 'Security Deposit',
                        controller: securityDepositController,
                        keyboardType: TextInputType.number,
                        prefixIcon: Icons.currency_rupee,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Value is empty';
                          } else {
                            return null;
                          }
                        },
                      ),
                      const Gap(15),
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
                              if (formKey.currentState?.validate() ?? false) {
                                removeCarFromScreen(widget.selectedCar!);
                                await saveHistory();
                                await saveCus();
                              }
                            },
                            child: CustomText(
                              text: 'SAVE DETAILS',
                              fontWeight: FontWeight.bold,
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
  }

// =========================saving collected datas to History Model
  Future<void> saveHistory() async {
    final carname = carnameController.text.trim();
    final carReg = carRegController.text.trim();
    final carDailyrent = carrentcontroller.text.trim();
    final customerName = customerNameController.text.trim();
    final mobileNumber = mobileNumberController.text.trim();
    final licenseNumber = licenseNumberController.text.trim();
    final securityDeposit = securityDepositController.text.trim();
    final pickupdaten = pickupdate.text.trim();
    final pickupTimen = pickupTime.text.trim();
    final dropOffDaten = dropOffDate.text.trim();
    final imagepath = widget.selectedCar!.selectedImage;
    final carMonthlyRent = widget.selectedCar?.monthlyrent;
    final carfuel = widget.selectedCar?.fuel;
    final carseater = widget.selectedCar?.seater;

    if (carname.isEmpty ||
        carReg.isEmpty ||
        carDailyrent.isEmpty ||
        customerName.isEmpty ||
        mobileNumber.isEmpty ||
        licenseNumber.isEmpty ||
        securityDeposit.isEmpty ||
        pickupdaten.isEmpty ||
        pickupTimen.isEmpty ||
        dropOffDaten.isEmpty ||
        imagepath.isEmpty) {
      return;
    }
    final historyA = HistoryModel(
      vehiclename: carname,
      vehicleReg: carReg,
      vehicleDailyRent: carDailyrent,
      customerName: customerName,
      mobileNumber: mobileNumber,
      licenseNumber: licenseNumber,
      pickupdate: pickupdaten,
      pickupTime: pickupTimen,
      dropOffDate: dropOffDaten,
      securityDeposit: securityDeposit,
      selectedImage: imagepath,
      vehicleMonthlyRent: carMonthlyRent,
      vehiclefuel: carfuel,
      vehicleseater: carseater,
    );
    await addHistory(historyA);
  }

// ================================saving datas to Customer Model
  Future<void> saveCus() async {
    final carname = carnameController.text.trim();
    final carReg = carRegController.text.trim();
    final carDailyrent = carrentcontroller.text.trim();
    final customerName = customerNameController.text.trim();
    final mobileNumber = mobileNumberController.text.trim();
    final licenseNumber = licenseNumberController.text.trim();
    final securityDeposit = securityDepositController.text.trim();
    final pickupdaten = pickupdate.text.trim();
    final pickupTimen = pickupTime.text.trim();
    final dropOffDaten = dropOffDate.text.trim();
    final imagepath = widget.selectedCar!.selectedImage;
    final carMonthlyRent = widget.selectedCar?.monthlyrent;
    final carfuel = widget.selectedCar?.fuel;
    final carseater = widget.selectedCar?.seater;

    if (carname.isEmpty ||
        carReg.isEmpty ||
        carDailyrent.isEmpty ||
        customerName.isEmpty ||
        mobileNumber.isEmpty ||
        licenseNumber.isEmpty ||
        securityDeposit.isEmpty ||
        pickupdaten.isEmpty ||
        pickupTimen.isEmpty ||
        dropOffDaten.isEmpty ||
        imagepath.isEmpty) {
      return;
    }

    final customerA = CustomerModel(
      carname: carname,
      carReg: carReg,
      carDailyRent: carDailyrent,
      customerName: customerName,
      mobileNumber: mobileNumber,
      licenseNumber: licenseNumber,
      pickupdate: pickupdaten,
      pickupTime: pickupTimen,
      dropOffDate: dropOffDaten,
      securityDeposit: securityDeposit,
      selectedImage: imagepath,
      carMonthlyRent: carMonthlyRent,
      carfuel: carfuel,
      carseater: carseater,
    );

    await addCustomer(customerA);

    Navigator.pop(context);

    customerNameController.clear();
    carRegController.clear();
    carnameController.clear();
    mobileNumberController.clear();
    licenseNumberController.clear();
    pickupdate.clear();
    pickupTime.clear();
    dropOffDate.clear();
    securityDepositController.clear();
    carrentcontroller.clear();
  }
}

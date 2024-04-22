import 'dart:io';

import 'package:autorent/dataModels/box.dart';
import 'package:autorent/dataModels/car_model.dart';
import 'package:autorent/screens/add_customer.dart';
import 'package:autorent/screens/car_details.dart';
import 'package:autorent/widgets/custom_button.dart';
import 'package:autorent/widgets/custom_colors.dart';
import 'package:autorent/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hive_flutter/hive_flutter.dart';

class AvailableCars extends StatefulWidget {
  const AvailableCars({super.key});

  @override
  State<AvailableCars> createState() => _AvailableCarsState();
}

class _AvailableCarsState extends State<AvailableCars> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColor.black,
      body: ValueListenableBuilder<Box<CarModel>>(
        valueListenable: Boxes.getData().listenable(),
        builder: (context, box, _) {
          var data = box.values.toList().cast<CarModel>();
          //==================Empty screen Messages
          if (data.isEmpty) {
            return const Center(
              child: CustomText(
                text: 'NO AVAILABLE CARS',
                fontWeight: FontWeight.bold,
                size: 18,
              ),
            );
          } else {
            return ListView.builder(
              itemCount: data.length,
              itemBuilder: ((context, int index) {
                return Padding(
                  padding: EdgeInsets.all(5),
                  //==============================onTap Activity
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (ctx) => cardetails(
                            cars: data[index],
                          ),
                        ),
                      );
                    },
                    //========================card in Available screens
                    child: Card(
                      color: Colors.white,
                      child: SizedBox(
                        height: 230,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            //===========================vehicle Registration
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: 300,
                                    height: 30,
                                    child: Padding(
                                      padding: EdgeInsets.only(left: 10),
                                      child: CustomText(
                                        text: data[index].vehicleReg,
                                        size: 18,
                                        color: CustomColor.black,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            //==============================vehicle Image
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  height: 120,
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
                            //===================================vehicle Name
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: SizedBox(
                                    width: 200,
                                    height: 30,
                                    child: Text(
                                      data[index].vehiclename,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 26,
                                      ),
                                    ),
                                  ),
                                ),
                                //===========================Rent Now Button
                                Padding(
                                  padding: EdgeInsets.only(left: 45.0, top: 5),
                                  child: SizedBox(
                                    width: 120,
                                    height: 35,
                                    child: customButton(
                                      onPressed: () {
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (ctx) => AddCustomer(
                                              selectedCar: data[index],
                                            ),
                                          ),
                                        );
                                      },
                                      label: "Rent Now",
                                      labelColor: CustomColor.black,
                                      backgroundColor: CustomColor.green,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            //============================ UI bottum part
                            Padding(
                              padding: EdgeInsets.only(left: 10),
                              child: SizedBox(
                                width: 390,
                                height: 25,
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.local_gas_station_outlined,
                                      color: CustomColor.blue,
                                    ),
                                    const Gap(2),
                                    CustomText(
                                      text: data[index].fuel,
                                      color: CustomColor.black,
                                    ),
                                    const SizedBox(width: 2),
                                    const Icon(
                                      Icons.currency_rupee,
                                      color: CustomColor.blue,
                                    ),
                                    CustomText(
                                      text: data[index].dailyrent,
                                      fontWeight: FontWeight.bold,
                                      color: CustomColor.black,
                                      size: 20,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              }),
            );
          }
        },
      ),
    );
  }
}

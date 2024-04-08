import 'dart:io';

import 'package:autorent/dataModels/car_model.dart';
import 'package:autorent/dataModels/customer_model.dart';
import 'package:autorent/db_functions/db_functions.dart';
import 'package:autorent/screens/customer_details.dart';
import 'package:autorent/screens/dropoffdetails.dart';
import 'package:autorent/widgets/custom_colors.dart';
import 'package:autorent/widgets/custom_text.dart';
import 'package:flutter/material.dart';

class History extends StatefulWidget {
  const History({super.key});

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  int indexNum = 0;
  List<CarModel> searchCarResults = [];
  List<CustomerModel> searchCustomerResults = [];
  @override
  void initState() {
    super.initState();
    performSearch('');
  }

  void performSearch(String query) {
    setState(() {
      searchCarResults = searchCars(query);
      searchCustomerResults = searchCustomers(query);
    });
  }

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
        title: const CustomText(
          text: "History",
          fontWeight: FontWeight.w600,
        ),
        backgroundColor: Colors.black,
      ),
      body: Column(
        children: [
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceAround,
          //   children: [
          //     Padding(
          //       padding: const EdgeInsets.all(10.0),
          //       child: Row(
          //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //         children: [
          //           ElevatedButton(
          //             onPressed: () {},
          //             style: ElevatedButton.styleFrom(
          //               backgroundColor: CustomColor.white,
          //             ),
          //             child: const CustomText(
          //               text: "All days",
          //               color: CustomColor.black,
          //             ),
          //           ),
          //           ElevatedButton(
          //             style: ElevatedButton.styleFrom(
          //               backgroundColor: CustomColor.white,
          //             ),
          //             onPressed: () {},
          //             child: const CustomText(
          //               text: "This Week",
          //               color: CustomColor.black,
          //             ),
          //           ),
          //           ElevatedButton(
          //             style: ElevatedButton.styleFrom(
          //               backgroundColor: CustomColor.white,
          //             ),
          //             onPressed: () {},
          //             child: const CustomText(
          //               text: "This Month",
          //               color: CustomColor.black,
          //             ),
          //           ),
          //         ],
          //       ),
          //     ),
          //   ],
          // ),
          for (var customer in searchCustomerResults)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundImage: FileImage(File(customer.selectedImage)),
                  radius: 30,
                ),
                title: Text(customer.customerName),
                subtitle: Text(customer.carname),
                trailing: Container(
                  width: 28,
                  height: 65,
                  decoration: BoxDecoration(
                    color: CustomColor.black,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (ctx) => Dropoffdetails(
                                customer: customer,
                              ),
                            ),
                          );
                        },
                        icon: const Icon(
                          Icons.arrow_forward_ios,
                          color: CustomColor.white,
                          size: 15,
                        ),
                      ),
                    ],
                  ),
                ),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (ctx) => CustomerDetails(customer: customer),
                    ),
                  );
                },
              ),
            ),
        ],
      ),
    );
  }
}

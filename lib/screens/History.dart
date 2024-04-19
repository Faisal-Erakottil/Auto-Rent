import 'dart:io';

import 'package:autorent/dataModels/car_model.dart';
import 'package:autorent/dataModels/customer_model.dart';
import 'package:autorent/db_functions/db_functions.dart';
import 'package:autorent/screens/customer_details.dart';
import 'package:autorent/screens/dropoffdetails.dart';
import 'package:autorent/widgets/custom_colors.dart';
import 'package:autorent/widgets/custom_text.dart';
import 'package:flutter/material.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  int indexNum = 1;
  List<CarModel> searchCarResults = [];
  List<CustomerModel> searchCustomerResults = [];
  @override
  void initState() {
    super.initState();
    getHistory();
   // performSearch('');
  }
  // void performSearch(String query) {
  //   setState(() {
  //     // searchCarResults = searchCars(query);
  //     // searchCustomerResults = customerHistory(query);
  //   });
  // }

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
          size: 18,
          fontWeight: FontWeight.bold,
        ),
        backgroundColor: Colors.black,
      ),
      body: Column(
        children: [
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

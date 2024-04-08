// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:autorent/dataModels/car_model.dart';
import 'package:autorent/dataModels/customer_model.dart';
import 'package:autorent/db_functions/db_functions.dart';
import 'package:autorent/screens/add_customer.dart';
import 'package:autorent/screens/car_details.dart';
import 'package:autorent/screens/customer_details.dart';
import 'package:autorent/screens/dropoffdetails.dart';
import 'package:autorent/widgets/custom_colors.dart';
import 'package:autorent/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController searchController = TextEditingController();
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
            )),
        centerTitle: true,
        title: const CustomText(
          text: "SEARCH",
          size: 18,
          fontWeight: FontWeight.w600,
        ),
        backgroundColor: CustomColor.black,
      ),
      body: Column(
        children: [
          Gap(10),
          Padding(
            padding: EdgeInsets.all(8),
            child: TextField(
              controller: searchController,
              onChanged: (query) => performSearch(query),
              decoration: InputDecoration(
                labelText: 'Search',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                filled: true,
                fillColor: const Color.fromARGB(255, 240, 251, 252),
              ),
            ),
          ),
          Expanded(
              child: ListView(
            children: [
              for (var car in searchCarResults)
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: ListTile(
                    selectedTileColor: Colors.white,
                    leading: CircleAvatar(
                      backgroundImage: FileImage(File(car.selectedImage)),
                      radius: 30,
                    ),
                    title: Text(car.vehiclename),
                    subtitle: Text(
                      ' ₹ ${car.dailyrent}/DAY AVAILABLE FOR RENT',
                    ),
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
                                  builder: (ctx) =>
                                      AddCustomer(selectedCar: car),
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
                            builder: (ctx) => cardetails(cars: car)),
                      );
                    },
                  ),
                ),
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
          ))
        ],
      ),
    );
  }
}

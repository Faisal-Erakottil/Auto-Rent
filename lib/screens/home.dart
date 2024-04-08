// ignore_for_file: prefer_const_constructors

import 'package:autorent/dataModels/usermodel.dart';
import 'package:autorent/db_functions/db_functions.dart';
import 'package:autorent/screens/add_car.dart';
import 'package:autorent/screens/availablecarlist.dart';
import 'package:autorent/screens/drawer_widget.dart';
import 'package:autorent/screens/notification_screen.dart';
import 'package:autorent/screens/rent_outlist.dart';
import 'package:autorent/screens/search_screen.dart';
import 'package:autorent/widgets/custom_colors.dart';
import 'package:autorent/widgets/custom_text.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  UserModel? _userDetails;
  int indexNum = 0;
  @override
  Widget build(BuildContext context) {
    getAllCars();
       return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: CustomColor.primary,
        appBar: AppBar(
          centerTitle: true,
          title: CustomText(
            text: 'HOME',
            size: 20,
          ),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const NotificationScreen(),
                  ),
                );
              },
              icon: Icon(
                Icons.notifications,
                color: CustomColor.white,
              ),
            ),
            SizedBox(width: 5),
            IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SearchScreen()));
              },
              icon: Icon(Icons.search),
            ),
          ],
          bottom: const TabBar(
            tabs: [
              Tab(
                  child: Text(
                "Available cars",
                style: TextStyle(fontSize: 18),
              )),
              Tab(
                child: Text(
                  "Rent out cars",
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
              ),
            ],
            labelColor: Colors.white,
            indicatorColor: Colors.blue,
            unselectedLabelColor: Color.fromARGB(107, 253, 253, 252),
          ),
          backgroundColor: Colors.black,
          iconTheme: const IconThemeData(color: CustomColor.white),
        ),
        drawer: CustomDrawer(userDetails: _userDetails),
        body: const TabBarView(
          children: [AvailableCars(), RentOutCars()],
        ),
        bottomNavigationBar: BottomAppBar(
          color: CustomColor.black,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 50),
                  child: ElevatedButton.icon(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.black),
                    ),
                    onPressed: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (ctx) => AddCar()));
                    },
                    icon: Icon(
                      Icons.add,
                      color: CustomColor.blue,
                    ),
                    label: CustomText(
                      text: 'ADD CAR',
                      color: CustomColor.blue,
                      size: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

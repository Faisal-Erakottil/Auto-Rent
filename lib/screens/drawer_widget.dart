// ignore_for_file: unnecessary_string_interpolations, use_super_parameters

import 'dart:io';
import 'package:autorent/screens/History.dart';
import 'package:autorent/screens/settings/settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:autorent/dataModels/usermodel.dart';
import 'package:autorent/db_functions/db_functions.dart';
import 'package:autorent/screens/user.dart';
import 'package:autorent/widgets/custom_colors.dart';
import 'package:autorent/widgets/custom_list.dart';
import 'package:autorent/widgets/custom_text.dart';

class CustomDrawer extends StatefulWidget {
  final UserModel? userDetails;

  const CustomDrawer({Key? key, this.userDetails}) : super(key: key);

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    await getAllData();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: CustomColor.white,
        child: ValueListenableBuilder<List<UserModel?>>(
          valueListenable: userNotifier,
          builder: (context, value, _) {
            if (value.isNotEmpty) {
              final userDetails = widget.userDetails ?? value.first;
              return ListView(
                children: <Widget>[
                  DrawerHeader(
                    decoration: const BoxDecoration(
                      color: CustomColor.white,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          radius: 36,
                          backgroundImage: userDetails!.image.isNotEmpty
                              ? FileImage(File(userDetails.image))
                              : null,
                        ),
                        const SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 20),
                            CustomText(
                              text: ' ${userDetails.name}',
                              size: 20,
                              color: CustomColor.blue,
                              fontWeight: FontWeight.bold,
                            ),
                            CustomText(
                              text: ' ${userDetails.mobile}',
                              size: 20,
                              color: CustomColor.blue,
                              fontWeight: FontWeight.w600,
                            ),
                            CustomText(
                              text: ' ${userDetails.email}',
                              size: 20,
                              color: CustomColor.blue,
                              fontWeight: FontWeight.w600,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  //=========================================User Details
                  CustomList(
                    leadingIcon: Icons.person,
                    title: "User Details",
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Userdetails(),
                        ),
                      );
                    },
                  ),
                  //==========================================History
                  CustomList(
                    title: "History",
                    leadingIcon: Icons.currency_rupee,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const History(),
                        ),
                      );
                    },
                  ),
                  //===========================================Settings
                  CustomList(
                    title: "Settings",
                    leadingIcon: Icons.settings,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SettingsScreen(),
                        ),
                      );
                    },
                  ),
                  //====================================app varsion
                  const SizedBox(height: 500),
                  const Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      CustomText(
                        text: "version 1.01",
                        color: Colors.grey,
                      ),
                    ],
                  )
                ],
              );
            } else {
              CustomList(
                leadingIcon: Icons.person,
                title: "User Details",
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Userdetails(),
                    ),
                  );
                },
              );
              return Column(
                children: [
                  const CustomText(
                    text: "fill up and enjoy",
                    color: CustomColor.black,
                  ),
                  CustomList(
                    leadingIcon: Icons.person,
                    title: "User Details",
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Userdetails(),
                        ),
                      );
                    },
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}

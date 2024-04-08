// ignore_for_file: prefer_const_constructors

import 'package:autorent/dataModels/car_model.dart';
import 'package:autorent/dataModels/customer_model.dart';
import 'package:autorent/dataModels/usermodel.dart';
import 'package:autorent/screens/splash.dart';
import 'package:autorent/widgets/custom_colors.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  if (!Hive.isAdapterRegistered(CarModelAdapter().typeId)) {
    Hive.registerAdapter(CarModelAdapter());
  }
  if (!Hive.isAdapterRegistered(CustomerModelAdapter().typeId)) {
    Hive.registerAdapter(CustomerModelAdapter());
  }
  if (!Hive.isAdapterRegistered(UserModelAdapter().typeId)) {
    Hive.registerAdapter(UserModelAdapter());
  }
  await Hive.openBox<CarModel>('car_db');
  await Hive.openBox<CustomerModel>('customer_db');
  await Hive.openBox<UserModel>('user_db');
  runApp(const MyApp());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Auto Rent',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: CustomColor.blue),
        useMaterial3: true,
      ),
      home: Splash(),
    );
  }
}

import 'package:autorent/dataModels/car_model.dart';
import 'package:autorent/dataModels/customer_model.dart';
import 'package:autorent/dataModels/usermodel.dart';
import 'package:hive_flutter/hive_flutter.dart';

class Boxes {
  static Box<CarModel> getData() => Hive.box<CarModel>('car_db');

  static Box<CustomerModel> getCustomerData() =>
      Hive.box<CustomerModel>('customer_db');

  static Box<UserModel> getUser() => Hive.box<UserModel>('user_db');

  
}

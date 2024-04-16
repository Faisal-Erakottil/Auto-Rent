// ignore_for_file: non_constant_identifier_names

import 'package:autorent/dataModels/box.dart';
import 'package:autorent/dataModels/car_model.dart';
import 'package:autorent/dataModels/customer_model.dart';
import 'package:autorent/dataModels/usermodel.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

ValueNotifier<List<UserModel>> userNotifier = ValueNotifier([]);
ValueNotifier<List<CarModel>> carListNotifier = ValueNotifier([]);
ValueNotifier<List<CustomerModel>> customerListNotifier = ValueNotifier([]);
//ValueNotifier<List<History>> HistoryNotifier = ValueNotifier([]);
//==================================================================User

Future<void> addUser(UserModel value) async {
  final userDB = await Hive.openBox<UserModel>('user_db');
  final id = await userDB.add(value);
  value.id = id;
  userNotifier.value.add(value);
  userNotifier.notifyListeners();
}

Future<void> getAllData() async {
  final userDB = await Hive.openBox<UserModel>('user_db');
  userNotifier.value.clear();
  userNotifier.value.addAll(userDB.values);
  for (var element in userDB.values) {
    //print(element.name);
  }
  print(userDB.values);
  userNotifier.notifyListeners();
}

//================================================================Car
Future<void> addCar(CarModel value) async {
  final carDB = await Hive.openBox<CarModel>('car_db');
  final id = await carDB.add(value);
  value.id = id;
  carListNotifier.value.add(value);

  carListNotifier.notifyListeners();
}

Future<void> addCustomer(CustomerModel value) async {
  final customerDB = await Hive.openBox<CustomerModel>('customer_db');
  final id = await customerDB.add(value);
  value.id = id;
  customerListNotifier.value.add(value);
  customerListNotifier.notifyListeners();
  // print(value);
}

//===================================adding datas to HISTORY
// Future<void> addHistory(History value) async {
//   final HistoryDB = await Hive.openBox<History>('history_db');
//   final id = await HistoryDB.add(value);
//   value.id = id;
//   HistoryNotifier.value.add(value);
//   HistoryNotifier.notifyListeners();
// }

Future<void> getAllCars() async {
  final carDB = await Hive.openBox<CarModel>('car_db');
  carListNotifier.value.clear();
  carListNotifier.value.addAll(carDB.values);
  carListNotifier.notifyListeners();
}
//============================================================customer

Future<void> getAllCustomers() async {
  final customerDB = await Hive.openBox<CustomerModel>('customer_db');
  customerListNotifier.value.clear();
  customerListNotifier.value.addAll(customerDB.values);
  customerListNotifier.notifyListeners();
}

Future<void> deletecar(CarModel modelcar) async {
  await modelcar.delete();
  getAllCars();
}

//===============================================search car
List<CarModel> searchCars(String query) {
  final carDB = Hive.box<CarModel>('car_db');
  final List<CarModel> allCars = carDB.values.toList();

  if (query.isEmpty) {
    return allCars;
  }

  final List<CarModel> searchResults = allCars
      .where(
          (car) => car.vehiclename.toLowerCase().contains(query.toLowerCase()))
      .toList();

  return searchResults;
}

//=====================================================Car history
// List<History> carHistory(String query) {
//   final historyDB = Hive.box<History>('history_db');
//   final List<History> allCars = historyDB.values.toList();

//   if (query.isEmpty) {
//     return allCars;
//   }

//   final List<History> searchResults = allCars
//       .where((car) => car.carname.toLowerCase().contains(query.toLowerCase()))
//       .cast<History>()
//       .toList();

//   return searchResults;
// }

//=====================================================Customer History
List<CustomerModel> customerHistory(String query) {
  final customerDB = Hive.box<CustomerModel>('customer_db');
  final List<CustomerModel> allCustomers = customerDB.values.toList();

  if (query.isEmpty) {
    return allCustomers;
  }

  final List<CustomerModel> searchResults = allCustomers
      .where((customer) =>
          customer.customerName.toLowerCase().contains(query.toLowerCase()) ||
          customer.carname.toLowerCase().contains(query.toLowerCase()))
      .toList();

  return searchResults;
}

//=====================================================search Customer
List<CustomerModel> searchCustomers(String query) {
  final customerDB = Hive.box<CustomerModel>('customer_db');
  final List<CustomerModel> allCustomers = customerDB.values.toList();

  if (query.isEmpty) {
    return allCustomers;
  }

  final List<CustomerModel> searchResults = allCustomers
      .where((customer) =>
          customer.customerName.toLowerCase().contains(query.toLowerCase()) ||
          customer.carname.toLowerCase().contains(query.toLowerCase()))
      .toList();

  return searchResults;
}

//===================================================remove car
List<CarModel> removedCarsList = [];
void removeCarFromScreen(CarModel car) {
  removedCarsList.add(car);
  carListNotifier.value.remove(car);
  Boxes.getData().delete(car.key);
  carListNotifier.notifyListeners();
}

List<CarModel> getRemovedCars() {
  return removedCarsList;
}

void clearRemovedCars() {
  removedCarsList.clear();
}

//=========================================================remove customer
List<CustomerModel> removedCustomersList = [];
void removeCustomerFromScreen(CustomerModel customer) {
  removedCustomersList.add(customer);
  customerListNotifier.value.remove(customer);
  Boxes.getCustomerData().delete(customer.key);
}

List<CustomerModel> getRemovedCustomers() {
  return removedCustomersList;
}

void clearRemovedCustomers() {
  removedCustomersList.clear();
}
//=================================================================

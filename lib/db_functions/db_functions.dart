// ignore_for_file: non_constant_identifier_names

import 'package:autorent/dataModels/box.dart';
import 'package:autorent/dataModels/car_model.dart';
import 'package:autorent/dataModels/customer_model.dart';
import 'package:autorent/dataModels/history_model.dart';
import 'package:autorent/dataModels/usermodel.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

ValueNotifier<List<UserModel>> userNotifier = ValueNotifier([]);
ValueNotifier<List<CarModel>> carListNotifier = ValueNotifier([]);
ValueNotifier<List<CustomerModel>> customerListNotifier = ValueNotifier([]);
ValueNotifier<List<HistoryModel>> HistoryNitifier = ValueNotifier([]);
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

//============================================================History
Future<void> addHistory(HistoryModel values) async {
  final historyDB = await Hive.openBox<HistoryModel>('history_db');
  final id = await historyDB.add(values);
  values.id = id;
  HistoryNitifier.value.add(values);
  HistoryNitifier.notifyListeners();
}

//=========================================== all values from history
Future<void> getHistory() async {
  final historyDB = await Hive.openBox<HistoryModel>('history_db');
  HistoryNitifier.value.clear();
  HistoryNitifier.value.addAll(historyDB.values);
  HistoryNitifier.notifyListeners();
}

//==================================================================Car
Future<void> addCar(CarModel value) async {
  final carDB = await Hive.openBox<CarModel>('car_db');
  final id = await carDB.add(value);
  value.id = id;
  carListNotifier.value.add(value);

  carListNotifier.notifyListeners();
}

//=============================================== add customers to Box
Future<void> addCustomer(CustomerModel value) async {
  final customerDB = await Hive.openBox<CustomerModel>('customer_db');
  final id = await customerDB.add(value);
  value.id = id;
  customerListNotifier.value.add(value);
  customerListNotifier.notifyListeners();
  // print(value);
}

//================================================== values of all cars
Future<void> getAllCars() async {
  final carDB = await Hive.openBox<CarModel>('car_db');
  carListNotifier.value.clear();
  carListNotifier.value.addAll(carDB.values);
  carListNotifier.notifyListeners();
}
//============================================================ customer

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

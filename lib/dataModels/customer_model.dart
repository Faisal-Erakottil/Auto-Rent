import 'package:autorent/dataModels/history_model.dart';
import 'package:hive_flutter/hive_flutter.dart';
part 'customer_model.g.dart';

@HiveType(typeId: 2)
class CustomerModel extends HiveObject {
  @HiveField(0)
  int? id;

  @HiveField(1)
  String carname;

  @HiveField(2)
  String carReg;

  @HiveField(3)
  String customerName;

  @HiveField(4)
  String mobileNumber;

  @HiveField(5)
  String licenseNumber;

  @HiveField(6)
  String pickupdate;

  @HiveField(7)
  String pickupTime;

  @HiveField(8)
  String dropOffDate;

  @HiveField(9)
  String securityDeposit;

  @HiveField(10)
  String selectedImage;

  @HiveField(11)
  String carDailyRent;

  @HiveField(12)
  String? carMonthlyRent;

  @HiveField(13)
  String? carfuel;

  @HiveField(14)
  String? carseater;

  CustomerModel({
    this.id,
    required this.carname,
    required this.carReg,
    required this.carDailyRent,
    required this.customerName,
    required this.mobileNumber,
    required this.licenseNumber,
    required this.pickupdate,
    required this.pickupTime,
    required this.dropOffDate,
    required this.securityDeposit,
    required this.selectedImage,
    this.carMonthlyRent,
    this.carfuel,
    this.carseater,
  });

  static fromHistory(HistoryModel data) {}
}

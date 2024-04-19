import 'package:hive_flutter/hive_flutter.dart';
part 'history_model.g.dart';

@HiveType(typeId: 4)
class HistoryModel extends HiveObject {
  @HiveField(0)
  int? id;

  @HiveField(1)
  String vehiclename;

  @HiveField(2)
  String vehicleReg;

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
  String vehicleDailyRent;

  @HiveField(12)
  String? vehicleMonthlyRent;

  @HiveField(13)
  String? vehiclefuel;

  @HiveField(14)
  String? vehicleseater;

  @HiveField(15)
  num? totalRent;

  @HiveField(16)
  String? dropofftime;

  HistoryModel({
    this.id,
    required this.vehiclename,
    required this.vehicleReg,
    required this.vehicleDailyRent,
    required this.customerName,
    required this.mobileNumber,
    required this.licenseNumber,
    required this.pickupdate,
    required this.pickupTime,
    required this.dropOffDate,
    required this.securityDeposit,
    required this.selectedImage,
    this.totalRent,
    this.vehicleMonthlyRent,
    this.vehiclefuel,
    this.vehicleseater,
    this.dropofftime,
  });
}

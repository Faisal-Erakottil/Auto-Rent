import 'package:hive_flutter/hive_flutter.dart';
part 'car_model.g.dart';

@HiveType(typeId: 1)
class CarModel extends HiveObject {
  @HiveField(0)
  int? id;

  @HiveField(1)
  String vehiclename;

  @HiveField(2)
  String vehicleReg;

  @HiveField(3)
  String fuel;

  @HiveField(4)
  String seater;

  @HiveField(5)
  String dailyrent;

  @HiveField(6)
  String monthlyrent;

  @HiveField(7)
  String selectedImage;

  CarModel({
    this.id,
    required this.vehiclename,
    required this.vehicleReg,
    required this.fuel,
    required this.seater,
    required this.dailyrent,
    required this.monthlyrent,
    required this.selectedImage,
  });
}

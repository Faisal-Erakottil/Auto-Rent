import 'package:hive_flutter/hive_flutter.dart';
part 'usermodel.g.dart';

@HiveType(typeId: 3)
class UserModel extends HiveObject {
  @HiveField(0)
  int? id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String mobile;

  @HiveField(3)
  final String email;

  @HiveField(4)
  final String image;

  UserModel({
    this.id,
    required this.name,
    required this.mobile,
    required this.email,
    required this.image,
  });
}

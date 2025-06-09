import 'package:hive/hive.dart';

part 'user_model.g.dart';

@HiveType(typeId: 3)
class UserModel {
  @HiveField(0)
  final String name;

  @HiveField(1)
  final int age;

  @HiveField(2)
  final String gender;

  @HiveField(3)
  final double bmi;

  UserModel({
    required this.name,
    required this.age,
    required this.gender,
    required this.bmi,
  });
}

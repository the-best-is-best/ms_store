import 'package:hive_flutter/hive_flutter.dart';

part 'users_model.g.dart';

@HiveType(typeId: 0)
class UserModel extends HiveObject {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final int loginBySocial;
  @HiveField(2)
  final String tokenSocial;
  @HiveField(3)
  String userName;
  @HiveField(4)
  final String email;
  @HiveField(5)
  String phone;
  @HiveField(6)
  String password;
  @HiveField(7)
  String code;

  UserModel({
    required this.id,
    required this.loginBySocial,
    required this.tokenSocial,
    required this.userName,
    required this.email,
    required this.password,
    required this.phone,
    required this.code,
  });
}

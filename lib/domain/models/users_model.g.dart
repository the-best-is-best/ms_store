// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'users_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserModelAdapter extends TypeAdapter<UserModel> {
  @override
  final int typeId = 0;

  @override
  UserModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserModel(
      id: fields[0] as int,
      loginBySocial: fields[1] as int,
      tokenSocial: fields[2] as String,
      userName: fields[3] as String,
      email: fields[4] as String,
      password: fields[6] as String,
      phone: fields[5] as String,
      code: fields[7] as String,
      phoneVerify: fields[8] as int,
    );
  }

  @override
  void write(BinaryWriter writer, UserModel obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.loginBySocial)
      ..writeByte(2)
      ..write(obj.tokenSocial)
      ..writeByte(3)
      ..write(obj.userName)
      ..writeByte(4)
      ..write(obj.email)
      ..writeByte(5)
      ..write(obj.phone)
      ..writeByte(6)
      ..write(obj.password)
      ..writeByte(7)
      ..write(obj.code)
      ..writeByte(8)
      ..write(obj.phoneVerify);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

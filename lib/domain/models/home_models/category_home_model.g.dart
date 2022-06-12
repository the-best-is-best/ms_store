// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_home_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CategoryHomeModelAdapter extends TypeAdapter<CategoryHomeModel> {
  @override
  final int typeId = 8;

  @override
  CategoryHomeModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CategoryHomeModel(
      parent: fields[3] as int,
      displayInHome: fields[4] as int,
      id: fields[0] as int,
      nameEN: fields[1] as String,
      nameAR: fields[2] as String,
      image: fields[5] as String,
    );
  }

  @override
  void write(BinaryWriter writer, CategoryHomeModel obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.nameEN)
      ..writeByte(2)
      ..write(obj.nameAR)
      ..writeByte(3)
      ..write(obj.parent)
      ..writeByte(4)
      ..write(obj.displayInHome)
      ..writeByte(5)
      ..write(obj.image);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CategoryHomeModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

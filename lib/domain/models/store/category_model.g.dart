// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CategoryDataWithChildModelAdapter
    extends TypeAdapter<CategoryDataWithChildModel> {
  @override
  final int typeId = 9;

  @override
  CategoryDataWithChildModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CategoryDataWithChildModel(
      parent: fields[3] as int,
      displayInHome: fields[4] as int,
      id: fields[0] as int,
      nameEN: fields[1] as String,
      nameAR: fields[2] as String,
      image: fields[5] as String,
      childCat: (fields[6] as List).cast<CategoryDataModel>(),
    );
  }

  @override
  void write(BinaryWriter writer, CategoryDataWithChildModel obj) {
    writer
      ..writeByte(7)
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
      ..write(obj.image)
      ..writeByte(6)
      ..write(obj.childCat);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CategoryDataWithChildModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class CategoryDataModelAdapter extends TypeAdapter<CategoryDataModel> {
  @override
  final int typeId = 10;

  @override
  CategoryDataModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CategoryDataModel(
      parent: fields[3] as int,
      displayInHome: fields[4] as int,
      id: fields[0] as int,
      nameEN: fields[1] as String,
      nameAR: fields[2] as String,
      image: fields[5] as String,
    );
  }

  @override
  void write(BinaryWriter writer, CategoryDataModel obj) {
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
      other is CategoryDataModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class CategoryModelAdapter extends TypeAdapter<CategoryModel> {
  @override
  final int typeId = 11;

  @override
  CategoryModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CategoryModel(
      data: (fields[0] as List?)?.cast<CategoryDataWithChildModel>(),
    );
  }

  @override
  void write(BinaryWriter writer, CategoryModel obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.data);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CategoryModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

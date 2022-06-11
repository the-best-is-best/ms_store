// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data_home_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DataHomeModelAdapter extends TypeAdapter<DataHomeModel> {
  @override
  final int typeId = 4;

  @override
  DataHomeModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DataHomeModel(
      fields[0] as CategoryModel,
      (fields[1] as List).cast<ProductModel>(),
    );
  }

  @override
  void write(BinaryWriter writer, DataHomeModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.categoryModel)
      ..writeByte(1)
      ..write(obj.productModel);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DataHomeModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

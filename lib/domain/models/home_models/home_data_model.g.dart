// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_data_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HomeDataModelAdapter extends TypeAdapter<HomeDataModel> {
  @override
  final int typeId = 2;

  @override
  HomeDataModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HomeDataModel(
      slider: (fields[0] as List).cast<SliderModel>(),
      dataHome: (fields[1] as List).cast<DataHomeModel>(),
    );
  }

  @override
  void write(BinaryWriter writer, HomeDataModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.slider)
      ..writeByte(1)
      ..write(obj.dataHome);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HomeDataModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class HomeModelAdapter extends TypeAdapter<HomeModel> {
  @override
  final int typeId = 1;

  @override
  HomeModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HomeModel(
      fields[0] as HomeDataModel,
    );
  }

  @override
  void write(BinaryWriter writer, HomeModel obj) {
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
      other is HomeModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

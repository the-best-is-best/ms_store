// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'slider_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SliderModelAdapter extends TypeAdapter<SliderModel> {
  @override
  final int typeId = 3;

  @override
  SliderModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SliderModel(
      id: fields[0] as int,
      imageEN: fields[1] as String,
      imageAR: fields[2] as String,
      openProductId: fields[3] as int?,
      openCategoryId: fields[4] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, SliderModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.imageEN)
      ..writeByte(2)
      ..write(obj.imageAR)
      ..writeByte(3)
      ..write(obj.openProductId)
      ..writeByte(4)
      ..write(obj.openCategoryId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SliderModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

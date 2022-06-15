// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favorite_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FavoriteDataModelAdapter extends TypeAdapter<FavoriteDataModel> {
  @override
  final int typeId = 12;

  @override
  FavoriteDataModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FavoriteDataModel(
      fields[0] as int,
      fields[1] as int,
      fields[2] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, FavoriteDataModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.productId)
      ..writeByte(2)
      ..write(obj.status);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FavoriteDataModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class FavoriteModelAdapter extends TypeAdapter<FavoriteModel> {
  @override
  final int typeId = 13;

  @override
  FavoriteModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FavoriteModel(
      (fields[0] as List).cast<FavoriteDataModel>(),
    );
  }

  @override
  void write(BinaryWriter writer, FavoriteModel obj) {
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
      other is FavoriteModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

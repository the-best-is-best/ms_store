// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_home_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ProductHomeModelAdapter extends TypeAdapter<ProductHomeModel> {
  @override
  final int typeId = 6;

  @override
  ProductHomeModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ProductHomeModel(
      id: fields[0] as int,
      nameEN: fields[1] as String,
      nameAR: fields[2] as String,
      image: fields[3] as String,
      price: fields[4] as num,
      priceAfterDis: fields[5] as num,
      descriptionEN: fields[6] as String,
      descriptionAR: fields[7] as String,
      categoryId: fields[8] as int,
      offers: fields[9] as int,
    );
  }

  @override
  void write(BinaryWriter writer, ProductHomeModel obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.nameEN)
      ..writeByte(2)
      ..write(obj.nameAR)
      ..writeByte(3)
      ..write(obj.image)
      ..writeByte(4)
      ..write(obj.price)
      ..writeByte(5)
      ..write(obj.priceAfterDis)
      ..writeByte(6)
      ..write(obj.descriptionEN)
      ..writeByte(7)
      ..write(obj.descriptionAR)
      ..writeByte(8)
      ..write(obj.categoryId)
      ..writeByte(9)
      ..write(obj.offers);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProductHomeModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

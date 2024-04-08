// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'car_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CarModelAdapter extends TypeAdapter<CarModel> {
  @override
  final int typeId = 1;

  @override
  CarModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CarModel(
      id: fields[0] as int?,
      vehiclename: fields[1] as String,
      vehicleReg: fields[2] as String,
      fuel: fields[3] as String,
      seater: fields[4] as String,
      dailyrent: fields[5] as String,
      monthlyrent: fields[6] as String,
      selectedImage: fields[7] as String,
    );
  }

  @override
  void write(BinaryWriter writer, CarModel obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.vehiclename)
      ..writeByte(2)
      ..write(obj.vehicleReg)
      ..writeByte(3)
      ..write(obj.fuel)
      ..writeByte(4)
      ..write(obj.seater)
      ..writeByte(5)
      ..write(obj.dailyrent)
      ..writeByte(6)
      ..write(obj.monthlyrent)
      ..writeByte(7)
      ..write(obj.selectedImage);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CarModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

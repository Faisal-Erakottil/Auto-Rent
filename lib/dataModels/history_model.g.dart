// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'history_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HistoryModelAdapter extends TypeAdapter<HistoryModel> {
  @override
  final int typeId = 4;

  @override
  HistoryModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HistoryModel(
      id: fields[0] as int?,
      vehiclename: fields[1] as String,
      vehicleReg: fields[2] as String,
      vehicleDailyRent: fields[11] as String,
      customerName: fields[3] as String,
      mobileNumber: fields[4] as String,
      licenseNumber: fields[5] as String,
      pickupdate: fields[6] as String,
      pickupTime: fields[7] as String,
      dropOffDate: fields[8] as String,
      securityDeposit: fields[9] as String,
      selectedImage: fields[10] as String,
      totalRent: fields[15] as num?,
      vehicleMonthlyRent: fields[12] as String?,
      vehiclefuel: fields[13] as String?,
      vehicleseater: fields[14] as String?,
      dropofftime: fields[16] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, HistoryModel obj) {
    writer
      ..writeByte(17)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.vehiclename)
      ..writeByte(2)
      ..write(obj.vehicleReg)
      ..writeByte(3)
      ..write(obj.customerName)
      ..writeByte(4)
      ..write(obj.mobileNumber)
      ..writeByte(5)
      ..write(obj.licenseNumber)
      ..writeByte(6)
      ..write(obj.pickupdate)
      ..writeByte(7)
      ..write(obj.pickupTime)
      ..writeByte(8)
      ..write(obj.dropOffDate)
      ..writeByte(9)
      ..write(obj.securityDeposit)
      ..writeByte(10)
      ..write(obj.selectedImage)
      ..writeByte(11)
      ..write(obj.vehicleDailyRent)
      ..writeByte(12)
      ..write(obj.vehicleMonthlyRent)
      ..writeByte(13)
      ..write(obj.vehiclefuel)
      ..writeByte(14)
      ..write(obj.vehicleseater)
      ..writeByte(15)
      ..write(obj.totalRent)
      ..writeByte(16)
      ..write(obj.dropofftime);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HistoryModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

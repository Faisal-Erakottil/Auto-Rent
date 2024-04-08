// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'customer_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CustomerModelAdapter extends TypeAdapter<CustomerModel> {
  @override
  final int typeId = 2;

  @override
  CustomerModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CustomerModel(
      id: fields[0] as int?,
      carname: fields[1] as String,
      carReg: fields[2] as String,
      carDailyRent: fields[11] as String,
      customerName: fields[3] as String,
      mobileNumber: fields[4] as String,
      licenseNumber: fields[5] as String,
      pickupdate: fields[6] as String,
      pickupTime: fields[7] as String,
      dropOffDate: fields[8] as String,
      securityDeposit: fields[9] as String,
      selectedImage: fields[10] as String,
      carMonthlyRent: fields[12] as String?,
      carfuel: fields[13] as String?,
      carseater: fields[14] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, CustomerModel obj) {
    writer
      ..writeByte(15)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.carname)
      ..writeByte(2)
      ..write(obj.carReg)
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
      ..write(obj.carDailyRent)
      ..writeByte(12)
      ..write(obj.carMonthlyRent)
      ..writeByte(13)
      ..write(obj.carfuel)
      ..writeByte(14)
      ..write(obj.carseater);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CustomerModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

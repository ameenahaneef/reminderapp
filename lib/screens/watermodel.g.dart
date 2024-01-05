// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'watermodel.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ConsumptionDataAdapter extends TypeAdapter<ConsumptionData> {
  @override
  final int typeId = 4;

  @override
  ConsumptionData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ConsumptionData(
      consumedDay: fields[0] as DateTime,
      consumedAmount: fields[1] as int,
      reminderInterval: fields[2] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, ConsumptionData obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.consumedDay)
      ..writeByte(1)
      ..write(obj.consumedAmount)
      ..writeByte(2)
      ..write(obj.reminderInterval);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ConsumptionDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

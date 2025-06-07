// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'date_log_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DateLogAdapter extends TypeAdapter<DateLog> {
  @override
  final int typeId = 1;

  @override
  DateLog read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DateLog(
      date: fields[0] as DateTime,
      breakfast: (fields[1] as List).cast<FoodEntry>(),
      lunch: (fields[2] as List).cast<FoodEntry>(),
      dinner: (fields[3] as List).cast<FoodEntry>(),
      morningSnack: (fields[4] as List).cast<FoodEntry>(),
      afternoonSnack: (fields[5] as List).cast<FoodEntry>(),
      eveningSnack: (fields[6] as List).cast<FoodEntry>(),
    );
  }

  @override
  void write(BinaryWriter writer, DateLog obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.date)
      ..writeByte(1)
      ..write(obj.breakfast)
      ..writeByte(2)
      ..write(obj.lunch)
      ..writeByte(3)
      ..write(obj.dinner)
      ..writeByte(4)
      ..write(obj.morningSnack)
      ..writeByte(5)
      ..write(obj.afternoonSnack)
      ..writeByte(6)
      ..write(obj.eveningSnack);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DateLogAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

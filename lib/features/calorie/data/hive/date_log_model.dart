import 'package:hive/hive.dart';
import 'food_entry_model.dart';

part 'date_log_model.g.dart';

@HiveType(typeId: 1)
class DateLog extends HiveObject {
  @HiveField(0)
  DateTime date;

  @HiveField(1)
  List<FoodEntry> breakfast;

  @HiveField(2)
  List<FoodEntry> lunch;

  @HiveField(3)
  List<FoodEntry> dinner;

  @HiveField(4)
  List<FoodEntry> morningSnack;

  @HiveField(5)
  List<FoodEntry> afternoonSnack;

  @HiveField(6)
  List<FoodEntry> eveningSnack;

  DateLog({
    required this.date,
    this.breakfast = const [],
    this.lunch = const [],
    this.dinner = const [],
    this.morningSnack = const [],
    this.afternoonSnack = const [],
    this.eveningSnack = const [],
  });
}

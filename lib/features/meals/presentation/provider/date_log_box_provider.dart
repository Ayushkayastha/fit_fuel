

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import '../../../calorie/data/hive/date_log_model.dart';

final dateLogBoxProvider = Provider<Box<DateLog>>((ref) {
  return Hive.box<DateLog>('calorieLogs');
});
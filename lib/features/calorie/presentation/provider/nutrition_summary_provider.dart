import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';

import '../../../meals/presentation/provider/date_log_box_provider.dart';
import 'date_provider.dart';

final nutritionSummaryProvider = StreamProvider.autoDispose<FoodSummary>((ref) {
  final box = ref.watch(dateLogBoxProvider);
  final date = ref.watch(dateProvider);

  final controller = StreamController<FoodSummary>();

  // Watch for Hive changes
  final boxListener = box.watch().listen((event) {
    final key = _dateKey(date);
    if (event.key == key) {
      controller.add(_calculateSummary(box, key));
    }
  });

  // Add initial summary
  final key = _dateKey(date);
  controller.add(_calculateSummary(box, key));

  // Cancel listener when provider is disposed
  ref.onDispose(() {
    boxListener.cancel();
    controller.close();
  });

  return controller.stream;
});

String _dateKey(DateTime date) =>
    '${date.year.toString().padLeft(4, '0')}-'
        '${date.month.toString().padLeft(2, '0')}-'
        '${date.day.toString().padLeft(2, '0')}';

FoodSummary _calculateSummary(Box box, String key) {
  final log = box.get(key);

  final allFoods = [
    ...log?.breakfast ?? [],
    ...log?.lunch ?? [],
    ...log?.dinner ?? [],
    ...log?.morningSnack ?? [],
    ...log?.afternoonSnack ?? [],
    ...log?.eveningSnack ?? [],
  ];

  double totalCalories = 0;
  double totalProtein = 0;
  double totalCarbs = 0;
  double totalFats = 0;
  double totalFiber = 0;

  for (var food in allFoods) {
    totalCalories += food.calories;
    totalProtein += food.protein;
    totalCarbs += food.carbs;
    totalFats += food.fats;
    totalFiber += food.fiber;
  }

  return FoodSummary(
    calories: totalCalories,
    protein: totalProtein,
    carbs: totalCarbs,
    fats: totalFats,
    fiber: totalFiber,
  );
}

class FoodSummary {
  final double calories;
  final double protein;
  final double carbs;
  final double fats;
  final double fiber;

  FoodSummary({
    required this.calories,
    required this.protein,
    required this.carbs,
    required this.fats,
    required this.fiber,
  });
}

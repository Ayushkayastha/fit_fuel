import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../calorie/data/hive/date_log_model.dart';
import '../../../calorie/data/hive/food_entry_model.dart';
import '../../../calorie/domain/food.dart';
import '../../../calorie/presentation/provider/date_provider.dart';
import '../provider/date_log_box_provider.dart';

class FoodDetailPage extends ConsumerStatefulWidget {
  final Food food;
  final String mealType;

  const FoodDetailPage({
    super.key,
    required this.food,
    required this.mealType,
  });

  @override
  ConsumerState<FoodDetailPage> createState() => _FoodDetailPageState();
}

class _FoodDetailPageState extends ConsumerState<FoodDetailPage> {
  final TextEditingController _weightController = TextEditingController();
  double weight = 100;

  @override
  void initState() {
    super.initState();
    _weightController.text = weight.toString();
  }

  String getDateKey(DateTime date) {
    return '${date.year.toString().padLeft(4, '0')}-'
        '${date.month.toString().padLeft(2, '0')}-'
        '${date.day.toString().padLeft(2, '0')}';
  }

  Future<void> addToMeal({
    required Food food,
    required double weight,
    required String mealType,
  }) async {
    final date = ref.read(dateProvider);
    final box = ref.read(dateLogBoxProvider);
    final key = getDateKey(date);

    final foodEntry = FoodEntry(
      name: food.name,
      weight: weight,
      calories: food.calories * weight,
      protein: food.protien * weight,
      carbs: food.carbs * weight,
      fats: food.fats * weight,
      fiber: food.fiber * weight,
    );

    DateLog? log = box.get(key);
    log ??= DateLog(date: date);

    // Make mutable copies of the meal lists before adding new entry
    switch (mealType) {
      case 'breakfast':
        log.breakfast = List.from(log.breakfast)..add(foodEntry);
        break;
      case 'lunch':
        log.lunch = List.from(log.lunch)..add(foodEntry);
        break;
      case 'dinner':
        log.dinner = List.from(log.dinner)..add(foodEntry);
        break;
      case 'morningSnack':
        log.morningSnack = List.from(log.morningSnack)..add(foodEntry);
        break;
      case 'afternoonSnack':
        log.afternoonSnack = List.from(log.afternoonSnack)..add(foodEntry);
        break;
      case 'eveningSnack':
        log.eveningSnack = List.from(log.eveningSnack)..add(foodEntry);
        break;
      default:
        throw Exception('Unknown meal type: $mealType');
    }

    await box.put(key, log);
  }

  @override
  Widget build(BuildContext context) {
    final factor = weight;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.food.name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _weightController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Enter weight in grams',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {
                  weight = double.tryParse(value) ?? 100;
                });
              },
            ),
            const SizedBox(height: 20),
            _buildNutrient("Calories", widget.food.calories * factor),
            _buildNutrient("Protein", widget.food.protien * factor),
            _buildNutrient("Carbs", widget.food.carbs * factor),
            _buildNutrient("Fats", widget.food.fats * factor),
            _buildNutrient("Fiber", widget.food.fiber * factor),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                await addToMeal(
                  food: widget.food,
                  weight: weight,
                  mealType: widget.mealType,
                );
                context.pop();
              },
              child: Text("Add to ${widget.mealType[0].toUpperCase()}${widget.mealType.substring(1)}"),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNutrient(String name, double value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(name),
          Text(value.toStringAsFixed(2)),
        ],
      ),
    );
  }
}

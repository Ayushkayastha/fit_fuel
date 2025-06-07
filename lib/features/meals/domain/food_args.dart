import '../../calorie/domain/food.dart';

class FoodDetailArgs {
  final Food food;
  final String mealType;

  FoodDetailArgs({required this.food, required this.mealType});

  factory FoodDetailArgs.fromJson(Map<String, dynamic> json) {
    return FoodDetailArgs(
      food: Food.fromJson(json['food']),
      mealType: json['mealType'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'food': food.toJson(),
      'mealType': mealType,
    };
  }
}

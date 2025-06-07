class Food {
  final String name;
  final double calories;
  final double protien;
  final double carbs;
  final double fats;
  final double fiber;

  Food({
    required this.name,
    required this.calories,
    required this.protien,
    required this.carbs,
    required this.fats,
    required this.fiber,
  });

  factory Food.fromJson(Map<String, dynamic> json) {
    return Food(
      name: json['name'] ?? '', // default empty string if missing
      calories: (json['calories'] as num?)?.toDouble() ?? 0.0,
      protien: (json['protien'] as num?)?.toDouble() ?? 0.0,
      carbs: (json['carbs'] as num?)?.toDouble() ?? 0.0,
      fats: (json['fats'] as num?)?.toDouble() ?? 0.0,
      fiber: (json['fiber'] as num?)?.toDouble() ?? 0.0,
    );
  }

Map<String, dynamic> toJson() {
    return {
      'name': name,
      'calories': calories,
      'protien': protien,
      'carbs': carbs,
      'fats': fats,
      'fiber': fiber,
    };
  }
}

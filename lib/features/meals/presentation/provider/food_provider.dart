import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../calorie/domain/food.dart';
import '../../data/json_loader.dart';

final showFoodListProvider = StateProvider<bool>((ref) => false);


// Load all food from JSON
final allFoodsProvider = FutureProvider<List<Food>>((ref) async {
  final data = await loadJsonData();
  return data.map((e) => Food.fromJson(e)).toList();
});

// Current search query
final searchQueryProvider = StateProvider<String>((ref) => '');

// Filtered foods based on query
final filteredFoodsProvider = Provider<List<Food>>((ref) {
  final query = ref.watch(searchQueryProvider).toLowerCase();
  final allFoodsAsync = ref.watch(allFoodsProvider);

  return allFoodsAsync.when(
    data: (foods) {
      final filtered = foods.where((f) => f.name.toLowerCase().contains(query)).toList();
      filtered.sort((a, b) => a.name.toLowerCase().startsWith(query) ? -1 : 1);
      return filtered;
    },
    loading: () => [],
    error: (_, __) => [],
  );
});

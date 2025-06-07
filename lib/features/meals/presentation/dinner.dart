import 'package:fit_fuel/config/route/paths.dart';
import 'package:fit_fuel/features/meals/presentation/provider/date_log_box_provider.dart';
import 'package:fit_fuel/features/meals/presentation/provider/food_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../calorie/presentation/provider/date_provider.dart';
import '../domain/food_args.dart';

class Dinner extends ConsumerStatefulWidget {
  const Dinner({super.key});

  @override
  ConsumerState<Dinner> createState() => _DinnerState();
}

class _DinnerState extends ConsumerState<Dinner> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }
  String getDateKey(DateTime date) {
    return '${date.year.toString().padLeft(4, '0')}-'
        '${date.month.toString().padLeft(2, '0')}-'
        '${date.day.toString().padLeft(2, '0')}';
  }


  @override
  Widget build(BuildContext context) {
    final foodList = ref.watch(filteredFoodsProvider);
    final showList = ref.watch(showFoodListProvider);
    final dateLogBox = ref.watch(dateLogBoxProvider);
    final selectedDate = ref.watch(dateProvider);

    final dateKey = getDateKey(selectedDate);
    final dateLog = dateLogBox.get(dateKey);
    final DinnerItems = dateLog?.dinner ?? [];

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: (){context.pop();},
            icon: Icon(Icons.arrow_back_ios_new)),
        title: const Text('Dinner'),
        centerTitle: true,

      ),
      body: Column(
        children: [
          const SizedBox(height: 8),

          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextField(
              controller: _controller,
              focusNode: _focusNode,
              onTap: () => ref.read(showFoodListProvider.notifier).state = true,
              onChanged: (value) {
                ref.read(searchQueryProvider.notifier).state = value;
              },
              decoration: InputDecoration(
                labelText: 'Search food',
                border: const OutlineInputBorder(),
                prefixIcon: const Icon(Icons.search),
                suffixIcon: showList
                    ? IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    ref.read(showFoodListProvider.notifier).state = false;
                    _controller.clear();
                    _focusNode.unfocus();
                  },
                )
                    : null,
              ),
            ),
          ),
          if (showList)
            Expanded(
              child: foodList.isEmpty
                  ? const Center(child: Text("No food found"))
                  : ListView.builder(
                itemCount: foodList.length,
                itemBuilder: (context, index) {
                  final food = foodList[index];
                  return ListTile(
                      title: Text(food.name),
                      onTap: () {
                        context.pushNamed(
                            Paths.fooddetailpageRoute.routeName,
                          extra: FoodDetailArgs(food: food, mealType: 'dinner'),

                        ).then((_) {
                          ref.read(showFoodListProvider.notifier).state = false;
                          _focusNode.unfocus();
                        });
                        ;}
                  );
                },
              ),
            ),
          if (!showList)
            Expanded(
              child: DinnerItems.isEmpty
                  ? const Center(child: Text("No Dinner logged for this date."))
                  : ListView.builder(
                itemCount: DinnerItems.length,
                itemBuilder: (context, index) {
                  final item = DinnerItems[index];
                  return ListTile(
                    title: Text(item.name),
                    subtitle: Text('${item.weight}g'),
                    trailing: Text('${item.calories.toStringAsFixed(1)} kcal'),
                  );
                },
              ),
            ),
        ],
      ),
    );
  }
}

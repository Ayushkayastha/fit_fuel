
import 'package:fit_fuel/config/route/route.dart';
import 'package:fit_fuel/features/calorie/presentation/provider/date_provider.dart';
import 'package:fit_fuel/features/calorie/presentation/provider/nutrition_summary_provider.dart';
import 'package:fit_fuel/features/calorie/presentation/widget/dashboard_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../config/route/paths.dart';

class CaloriePage extends ConsumerWidget {
  const CaloriePage({super.key});

  Future<void> _selectDate(BuildContext context, WidgetRef ref, DateTime initialDate) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(2024),
      lastDate: DateTime(2034),
    );

    if (picked != null) {
      ref.read(dateProvider.notifier).setDate(picked);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedDate = ref.watch(dateProvider);
    final formattedDate = DateFormat.yMMMMd().format(selectedDate);
    final nutritionSummaryAsync = ref.watch(nutritionSummaryProvider);
    final dateNotifier = ref.read(dateProvider.notifier);


    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              onPressed: dateNotifier.previousDay,
              icon: const Icon(Icons.arrow_back_ios_new),
            ),
            GestureDetector(
              onTap: () => _selectDate(context, ref, selectedDate),
              child: Container(
                width: 200,
                height: 42,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(color: Colors.black),
                ),
                child: Text(
                  formattedDate,
                  style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500),
                ),
              ),
            ),
            IconButton(
              onPressed: dateNotifier.nextDay,
              icon: const Icon(Icons.arrow_forward_ios),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [

            nutritionSummaryAsync.when(
              data: (nutritionSummary) => DashboardWidget(
                totalKcalSupplied: nutritionSummary.calories,
                totalKcalBurned: 0,
                totalKcalDaily: 2900,
                totalKcalLeft: 2900 - nutritionSummary.calories,
                totalCarbsIntake: nutritionSummary.carbs,
                totalFatsIntake: nutritionSummary.fats,
                totalProteinsIntake: nutritionSummary.protein,
                totalCarbsGoal: 200,
                totalFatsGoal: 50,
                totalProteinsGoal: 140,
              ),
              loading: () => const DashboardWidget(
                totalKcalSupplied: 0,
                totalKcalBurned: 0,
                totalKcalDaily: 2900,
                totalKcalLeft: 2900 ,
                totalCarbsIntake: 0,
                totalFatsIntake: 0,
                totalProteinsIntake: 0,
                totalCarbsGoal: 200,
                totalFatsGoal: 50,
                totalProteinsGoal: 140,
              ),
              error: (e, stack) => Text('Error: $e'),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: (){
                    context.push(Paths.breakfastpageRoute.path);
                  },
                  child: Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: Colors.black12
                    ),
                    child: Center(child: Text('breakfast')),
                  ),
                ),
                InkWell(
                  onTap: (){
                    context.push(Paths.lunchpageRoute.path);
                  },
                  child: Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: Colors.black12
                    ),
                    child: Center(child: Text('Lunch')),
                  ),
                ),
                InkWell(
                  onTap: (){
                    context.push(Paths.dinnerpageRoute.path);
                  },
                  child: Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: Colors.black12
                    ),
                    child: Center(child: Text('Dinner')),
                  ),
                ),
              ],
            ),
            SizedBox(height: 30,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: (){
                    context.push(Paths.moriningsnackpageRoute.path);
                  },
                  child: Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: Colors.black12
                    ),
                    child: Center(child: Text('Morning snack')),
                  ),
                ),
                InkWell(
                  onTap: (){
                    context.push(Paths.afternoonpageRoute.path);
                  },
                  child: Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: Colors.black12
                    ),
                    child: Center(child: Text('afternoon snack')),
                  ),
                ),
                InkWell(
                  onTap: (){
                    context.push(Paths.eveningsnackpageRoute.path);
                  },
                  child: Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: Colors.black12
                    ),
                    child: Center(child: Text('evening snack')),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

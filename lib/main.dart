import 'package:fit_fuel/config/route/route.dart';
import 'package:fit_fuel/features/landing/presentation/landing_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';

import 'features/calorie/data/hive/date_log_model.dart';
import 'features/calorie/data/hive/food_entry_model.dart';

Future<void> main() async {

  await Hive.initFlutter();

  Hive.registerAdapter(FoodEntryAdapter());
  Hive.registerAdapter(DateLogAdapter());

  await Hive.openBox<DateLog>('calorieLogs');

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Fitness App',
      theme: ThemeData(primarySwatch: Colors.blue),
      routerConfig: AppRouter.router,
    );
  }
}

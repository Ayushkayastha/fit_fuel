import 'package:fit_fuel/config/route/route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'features/calorie/data/hive/date_log_model.dart';
import 'features/calorie/data/hive/food_entry_model.dart';
import 'features/onboarding/data/models/user_model.dart';
import 'features/onboarding/presentation/provider/user_provider.dart'; // if needed

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();

  Hive.registerAdapter(FoodEntryAdapter());
  Hive.registerAdapter(DateLogAdapter());
  Hive.registerAdapter(UserModelAdapter());

  await Hive.openBox<DateLog>('calorieLogs');
  final userBox = await Hive.openBox<UserModel>('userBox');

  runApp(
    ProviderScope(
      overrides: [
        userBoxProvider.overrideWithValue(userBox),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Fitness App',
      debugShowCheckedModeBanner: true,
      theme: ThemeData(primarySwatch: Colors.blue),
      routerConfig: AppRouter.router,
    );
  }
}

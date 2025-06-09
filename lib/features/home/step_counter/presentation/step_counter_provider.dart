import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/step_counter_repository_impl.dart';
import '../domain/step_counter_repository.dart';


final stepCounterRepositoryProvider = Provider<StepCounterRepository>(
      (ref) => StepCounterRepositoryImpl(),
);

final stepPermissionProvider = FutureProvider<bool>((ref) async {
  // For iOS: Just return true (permission dialog triggered automatically)
  // For Android: you can add permission request if you want here
  return true;
});

final stepCountProvider = StreamProvider<int>((ref) {
  return ref.watch(stepCounterRepositoryProvider).getStepCountStream();
});

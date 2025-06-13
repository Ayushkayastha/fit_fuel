import 'package:fit_fuel/features/home/speed_counter/data/speed_repository_impl.dart';
import 'package:fit_fuel/features/home/speed_counter/domain/speed_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final locationRepositoryProvider = Provider<SpeedRepository>((ref) {
  return SpeedRepositoryImpl();
});

final speedStreamProvider = StreamProvider<double>((ref) {
  final repo = ref.watch(locationRepositoryProvider);
  return repo.getSpeedStream();
});

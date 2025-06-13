import 'package:fit_fuel/features/home/speed_counter/presentation/speed_stream_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SpeedWidget extends ConsumerWidget {
  const SpeedWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final speedAsync = ref.watch(speedStreamProvider);

    return speedAsync.when(
      data: (speedInMs) {
        final speedKmh = speedInMs * 3.6;
        return Text(
          'Speed: ${speedKmh.toStringAsFixed(2)} km/h',
          style: const TextStyle(fontSize: 24),
        );
      },
      loading: () => const CircularProgressIndicator(),
      error: (e, _) => Text('Error: $e'),
    );
  }
}

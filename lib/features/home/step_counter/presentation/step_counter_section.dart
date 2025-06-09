import 'package:fit_fuel/features/home/step_counter/presentation/step_counter_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class StepCounterSection extends ConsumerWidget {
  const StepCounterSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final permissionAsync = ref.watch(stepPermissionProvider);

    return permissionAsync.when(
      loading: () => _buildContainer("Checking permission..."),
      error: (e, _) => _buildContainer("Permission error"),
      data: (granted) {
        if (!granted) {
          return _buildContainer("Permission denied");
        }

        final stepAsync = ref.watch(stepCountProvider);
        return stepAsync.when(
          data: (steps) => _buildContainer("Steps Today: $steps"),
          loading: () => _buildContainer("Loading steps..."),
          error: (e, _) => _buildContainer("Step count error"),
        );
      },
    );
  }

  Widget _buildContainer(String text) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.blueAccent),
      ),
      child: Center(
        child: Text(
          text,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}

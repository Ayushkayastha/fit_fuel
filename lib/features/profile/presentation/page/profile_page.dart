import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../onboarding/presentation/provider/user_provider.dart';

class ProfilePage extends ConsumerWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider);

    if (user == null) {
      return const Scaffold(
        body: Center(child: Text('No user data found.')),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('👤 Name: ${user.name}', style: const TextStyle(fontSize: 18)),
              const SizedBox(height: 8),
              Text('🎂 Age: ${user.age}', style: const TextStyle(fontSize: 18)),
              const SizedBox(height: 8),
              Text('⚧ Gender: ${user.gender}', style: const TextStyle(fontSize: 18)),
              const SizedBox(height: 8),
              Text('📊 BMI: ${user.bmi.toStringAsFixed(1)}', style: const TextStyle(fontSize: 18)),
            ],
          ),
        ),
      ),
    );
  }
}

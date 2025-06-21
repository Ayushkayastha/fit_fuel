import 'package:fit_fuel/config/extensions/context_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../onboarding/presentation/provider/user_provider.dart';
import '../provider/auth_info_provider.dart';

class ProfilePage extends ConsumerWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider);
    final tokenAsync = ref.watch(authTokenProvider);
    final userIdAsync = ref.watch(userIdProvider);

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
          child: ListView(
            children: [
              Center(
                child: CircleAvatar(
                  radius: 50,
                  backgroundColor: context.colorScheme.primaryFixedDim, // 🔄 Changed from Colors.blue.shade100
                  child: const Icon(Icons.person, size: 50, color: Colors.white),
                ),
              ),
              SizedBox(height: 62.h,),
              ProfileInfoTile(icon: Icons.person_outline_outlined, label: 'Name', value:user.name ),
              ProfileInfoTile(icon: Icons.cake, label: 'age', value:user.age.toString()),
              ProfileInfoTile(icon: Icons.wc, label: 'gender', value:user.gender ),
              ProfileInfoTile(icon: Icons.height, label: 'height', value:user.height.toString() ),
              ProfileInfoTile(icon: Icons.monitor_weight_outlined, label: 'weight', value:user.weight.toString() ),
             userIdAsync.when(
                data: (id) => Text('🆔 User ID: ${id ?? "Not found"}', style: const TextStyle(fontSize: 18)),
                loading: () => const Text('Loading user ID...'),
                error: (e, _) => Text('User ID error: $e'),
              ),
              const SizedBox(height: 8),
              tokenAsync.when(
                data: (token) => Text('🔑 Token: ${token ?? "Not found"}', style: const TextStyle(fontSize: 18)),
                loading: () => const Text('Loading token...'),
                error: (e, _) => Text('Token error: $e'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}



class ProfileInfoTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const ProfileInfoTile({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: Icon(icon, color: context.colorScheme.primaryFixedDim),
        title: Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(value, style: const TextStyle(fontSize: 16)),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hive/hive.dart';
import '../../../../config/route/paths.dart';
import '../../../core/storage/secure_storage_service.dart';
import '../../onboarding/data/models/user_model.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    _checkUser();
  }

  Future<void> _checkUser() async {
    await Future.delayed(const Duration(seconds: 3)); // show splash briefly

    final box = Hive.box<UserModel>('userBox');
    final user = box.get('user');

    if (user != null) {
      final storage = SecureStorageService();
      final token = await storage.getAuthToken();

      if (token != null && mounted) {
        context.go(Paths.landingPageRoute.path); // Already logged in
      } else {
        context.go(Paths.loginPageRoute.path); // Not logged in
      }
    } else {
      context.go(Paths.onboardingaPageRoute.path);
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }
}

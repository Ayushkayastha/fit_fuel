import 'package:fit_fuel/config/extensions/context_extension.dart';
import 'package:fit_fuel/config/route/paths.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../domain/entity/user_entity.dart';
import '../provider/user_provider.dart';


class OnboardingPage extends ConsumerStatefulWidget {
  const OnboardingPage({super.key});

  @override
  ConsumerState<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends ConsumerState<OnboardingPage> {
  final nameController = TextEditingController();
  final ageController = TextEditingController();
  final heightController = TextEditingController();
  final weightController = TextEditingController();
  String gender = 'Male';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Onboarding')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Name'),
            ),
            SizedBox(height: 10.h,),
            TextField(
              controller: ageController,
              decoration: const InputDecoration(labelText: 'Age'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 10.h,),
            TextField(
              controller: heightController,
              decoration: const InputDecoration(labelText: 'height'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 10.h,),

            TextField(
              controller: weightController,
              decoration: const InputDecoration(labelText: 'weight'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 10.h,),

            DropdownButton<String>(
              value: gender,
              items: ['Male', 'Female', 'Other']
                  .map((g) => DropdownMenuItem(value: g, child: Text(g)))
                  .toList(),
              onChanged: (val) => setState(() => gender = val!),
            ),
            SizedBox(height: 20.h,),

            ElevatedButton(
              onPressed: () async {
                final user = UserEntity(
                  name: nameController.text,
                  age: int.parse(ageController.text),
                  gender: gender,
                  height: double.parse(heightController.text),
                  weight: double.parse(weightController.text),
                );
                await ref.read(saveUserProvider)(user);
               context.go(Paths.loginPageRoute.path);
              },
              child: const Text('Continue'),
            ),
          ],
        ),
      ),
    );
  }
}

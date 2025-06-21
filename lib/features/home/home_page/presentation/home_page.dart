import 'package:fit_fuel/features/home/running/presentation/ui/run_page.dart';
import 'package:fit_fuel/features/home/step_counter/presentation/step_counter_section.dart';
import 'package:flutter/material.dart';


class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            const Center(
              child: Text('Home Page', style: TextStyle(fontSize: 24)),
            ),
            StepCounterSection(),

            RunPage(),

          ],
        ),
      ),
    );
  }
}

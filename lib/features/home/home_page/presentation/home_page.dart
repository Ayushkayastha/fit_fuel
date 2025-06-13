import 'package:fit_fuel/features/home/speed_counter/presentation/speed_widget.dart';
import 'package:fit_fuel/features/home/step_counter/presentation/step_counter_section.dart';
import 'package:flutter/material.dart';


class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            StepCounterSection(),
            const Center(
              child: Text('Home Page', style: TextStyle(fontSize: 24)),
            ),
            SpeedWidget(),
          ],
        ),
      ),
    );
  }
}

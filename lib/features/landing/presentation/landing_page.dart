import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';

import '../../../core/navigation_state.dart';
import '../../calorie/presentation/calorie_page.dart';
import '../../home/presentation/home_page.dart';
import '../../workout/presentation/workout_page.dart';

class LandingPage extends ConsumerStatefulWidget {
  const LandingPage({super.key});

  @override
  ConsumerState<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends ConsumerState<LandingPage> {
  final _pages = [
    const HomePage(),
    const CaloriePage(),
    const WorkoutPage(),
  ];

  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    final currentIndex=ref.watch(currentIndexProvider);
    return Scaffold(
      body: _pages[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index){
          ref.watch(currentIndexProvider.notifier).state=index;
        },
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.local_fire_department), label: 'Calorie'),
            BottomNavigationBarItem(icon: Icon(Icons.fitness_center), label: 'Workout'),
          ],
      ),
    );
  }
}

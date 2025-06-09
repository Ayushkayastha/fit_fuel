// lib/features/landing/presentation/landing_page.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

import '../../../core/navigation_state.dart';
import '../../home/home_page/presentation/home_page.dart';
import '../../calorie/presentation/calorie_page.dart';
import '../../workout/presentation/workout_page.dart';
import '../../profile/presentation/page/profile_page.dart';

class LandingPage extends ConsumerStatefulWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  ConsumerState<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends ConsumerState<LandingPage> {
  late final PersistentTabController _controller;

  @override
  void initState() {
    super.initState();
    // Read the saved index once, and initialize the controller with it.
    final savedIndex = ref.read(currentIndexProvider);
    _controller = PersistentTabController(initialIndex: savedIndex);
  }

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      controller: _controller,
      screens: const [
        HomePage(),     // full‐screen Scaffold
        CaloriePage(),  // full‐screen Scaffold
        WorkoutPage(),  // full‐screen Scaffold
        ProfilePage(),  // full‐screen Scaffold
      ],
      items: _navBarItems(),
      confineToSafeArea: true,
      backgroundColor: Colors.white,
      handleAndroidBackButtonPress: true,
      resizeToAvoidBottomInset: true,
      stateManagement: true,
      navBarStyle: NavBarStyle.style3,
      onItemSelected: (index) {
        // Keep Riverpod’s state in sync whenever a tab is tapped.
        ref.read(currentIndexProvider.notifier).state = index;
      },
    );
  }

  List<PersistentBottomNavBarItem> _navBarItems() {
    return [
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.home),
        title: 'Home',
        activeColorPrimary: Colors.blue,
        inactiveColorPrimary: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.local_fire_department),
        title: 'Calorie',
        activeColorPrimary: Colors.red,
        inactiveColorPrimary: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.fitness_center),
        title: 'Workout',
        activeColorPrimary: Colors.green,
        inactiveColorPrimary: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.person),
        title: 'Profile',
        activeColorPrimary: Colors.purple,
        inactiveColorPrimary: Colors.grey,
      ),
    ];
  }
}

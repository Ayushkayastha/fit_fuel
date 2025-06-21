import 'package:fit_fuel/config/route/paths.dart';
import 'package:fit_fuel/config/route/route_model.dart';
import 'package:fit_fuel/features/landing/presentation/landing_page.dart';
import 'package:fit_fuel/features/onboarding/presentation/pages/onboarding_page.dart';
import 'package:fit_fuel/features/splash/presentation/splash_page.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';

import '../../features/auth/presentation/login_page.dart';
import '../../features/auth/presentation/signup_page.dart';
import '../../features/meals/domain/food_args.dart';
import '../../features/meals/presentation/afternoon_snack.dart';
import '../../features/meals/presentation/breakfast.dart';
import '../../features/meals/presentation/dinner.dart';
import '../../features/meals/presentation/evening_snack.dart';
import '../../features/meals/presentation/food_detail/food_detail.dart';
import '../../features/meals/presentation/lunch.dart';
import '../../features/meals/presentation/morning_snack.dart';
import '../error_screen.dart';

class AppRouter {
  static final key = GlobalKey<NavigatorState>();
  static final router = GoRouter(
    initialLocation: Paths.splashPageRoute.path,
    navigatorKey: key,
    routes: [
      GoRoute(
        path: Paths.splashPageRoute.path,
        name: Paths.splashPageRoute.routeName,
        pageBuilder: (context, state) => FadeTransitionPage(
            key: state.pageKey,
            child: SplashPage()),
      ),
      GoRoute(
        path: Paths.landingPageRoute.path,
        name: Paths.landingPageRoute.routeName,
        pageBuilder: (context, state) => FadeTransitionPage(
            key: state.pageKey,
            child: LandingPage()),
      ),
      GoRoute(
        path: Paths.onboardingaPageRoute.path,
        name: Paths.onboardingaPageRoute.routeName,
        pageBuilder: (context, state) => FadeTransitionPage(
            key: state.pageKey,
            child: OnboardingPage()),
      ),
      GoRoute(
          path:Paths.breakfastpageRoute.path,
          name: Paths.breakfastpageRoute.routeName,
          pageBuilder: (context, state)=>FadeTransitionPage(
            key: state.pageKey,
            child:  Breakfast(),
          )
      ),
      GoRoute(
          path:Paths.lunchpageRoute.path,
          name: Paths.lunchpageRoute.routeName,
          pageBuilder: (context, state)=>FadeTransitionPage(
            key: state.pageKey,
            child:  Lunch(),
          )
      ),
      GoRoute(
          path:Paths.dinnerpageRoute.path,
          name: Paths.dinnerpageRoute.routeName,
          pageBuilder: (context, state)=>FadeTransitionPage(
            key: state.pageKey,
            child:  Dinner(),
          )
      ),
      GoRoute(
          path:Paths.moriningsnackpageRoute.path,
          name: Paths.moriningsnackpageRoute.routeName,
          pageBuilder: (context, state)=>FadeTransitionPage(
            key: state.pageKey,
            child:  MoriningSnack(),
          )
      ),
      GoRoute(
          path:Paths.afternoonpageRoute.path,
          name: Paths.afternoonpageRoute.routeName,
          pageBuilder: (context, state)=>FadeTransitionPage(
            key: state.pageKey,
            child:  AfternoonSnack(),
          )
      ),
      GoRoute(
          path:Paths.eveningsnackpageRoute.path,
          name: Paths.eveningsnackpageRoute.routeName,
          pageBuilder: (context, state)=>FadeTransitionPage(
            key: state.pageKey,
            child:  EveningSnack(),
          )
      ),
      GoRoute(
        path: Paths.fooddetailpageRoute.path,
        name: Paths.fooddetailpageRoute.routeName,
        pageBuilder: (context, state) {
          final args = state.extra as FoodDetailArgs;
          return FadeTransitionPage(
            key: state.pageKey,
            child: FoodDetailPage(
              food: args.food,
              mealType: args.mealType,
            ),
          );
        },
      ),
      GoRoute(
        path: Paths.loginPageRoute.path,
        name: Paths.loginPageRoute.routeName,
        pageBuilder: (context,state)=>FadeTransitionPage(
          key: state.pageKey,
          child: LoginPage(),
        ),
      ),
      GoRoute(
        path: Paths.signupPageRoute.path,
        name: Paths.signupPageRoute.routeName,
        pageBuilder: (context,state)=>FadeTransitionPage(
          key: state.pageKey,
          child: SignupPage(),
        ),
      ),

    ],
    errorBuilder: (context, state) => const ErrorScreen(),
    redirect: (BuildContext context, GoRouterState state) async {
      return null;
    },
    debugLogDiagnostics: kDebugMode,
  );
}

/// The `FadeTransitionPage` class is a custom transition page that applies a fade animation to its
/// child widget.
class FadeTransitionPage extends CustomTransitionPage<void> {
  FadeTransitionPage({
    required LocalKey super.key,
    required super.child,
  }) : super(
    transitionsBuilder: (c, animation, a2, child) => FadeTransition(
      opacity: animation.drive(CurveTween(curve: Curves.easeIn)),
      child: child,
    ),
  );
}
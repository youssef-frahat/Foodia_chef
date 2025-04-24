import 'package:flutter/material.dart';
import 'package:foodia_chef/core/routes/routes.dart';
import 'package:foodia_chef/core/routes/routing_observer.dart';
import 'package:foodia_chef/core/routes/screen_withfade_transition.dart';
import 'package:foodia_chef/feature/auth/login/presentation/screens/otp_screen.dart';
import 'package:go_router/go_router.dart';

import '../../feature/auth/login/presentation/screens/login_screen.dart';
import '../../feature/auth/login/presentation/screens/register_screen.dart';
import '../../feature/auth/login/presentation/widget/second_register_body.dart';
import '../../feature/bottom_navigation_bar/custom_button_nav_bar.dart';
import '../../feature/splash_onbordig/onbording.dart';

class AppRouter {
  static final GlobalKey<NavigatorState> appNavigatorKey =
      GlobalKey<NavigatorState>();

  final GoRouter router;

  AppRouter()
      : router = GoRouter(
          observers: [GoRouterObserver()],
          navigatorKey: appNavigatorKey,
          initialLocation: Routes.onboardingScreen,
          routes: <RouteBase>[
            GoRoute(
              parentNavigatorKey: appNavigatorKey,
              path: Routes.login,
              name: Routes.login,
              pageBuilder: (context, GoRouterState state) =>
                  screenWithFadeTransition(
                context: context,
                state: state,
                child: const LoginScreen(),
              ),
            ),
            GoRoute(
              parentNavigatorKey: appNavigatorKey,
              path: Routes.onboardingScreen,
              name: Routes.onboardingScreen,
              pageBuilder: (context, GoRouterState state) =>
                  screenWithFadeTransition(
                context: context,
                state: state,
                child: const OnboardingScreen(),
              ),
            ),
            GoRoute(
              parentNavigatorKey: appNavigatorKey,
              path: Routes.registerScreen,
              name: Routes.registerScreen,
              pageBuilder: (context, GoRouterState state) =>
                  screenWithFadeTransition(
                context: context,
                state: state,
                child: const RegisterScreen(),
              ),
            ),
            GoRoute(
              path: Routes.register2Screen,
              name: Routes.register2Screen,
              builder: (BuildContext context, GoRouterState state) {
                final Map<String, String> registrationData =
                    state.extra as Map<String, String>;
                return SecondPage(
                  name: registrationData['name']!,
                  email: registrationData['email']!,
                  phone: registrationData['phone']!,
                  password: registrationData['password']!,
                );
              },
            ),
            GoRoute(
              parentNavigatorKey: appNavigatorKey,
              path: Routes.otpScreen,
              name: Routes.otpScreen,
              pageBuilder: (context, GoRouterState state) =>
                  screenWithFadeTransition(
                context: context,
                state: state,
                child: const OtpScreen(),
              ),
            ),
            GoRoute(
              path: Routes.bottomNavBar,
              builder: (context, state) {
                return BottomNavBar();
              },
            ),

            // GoRoute(
            //   parentNavigatorKey: appNavigatorKey,
            //   path: Routes.home,
            //   name: Routes.home,
            //   pageBuilder: (context, GoRouterState state) =>
            //       screenWithFadeTransition(
            //     context: context,
            //     state: state,
            //     child: const HomeScreen(),
            //   ),
            // ),
          ],
        );
}

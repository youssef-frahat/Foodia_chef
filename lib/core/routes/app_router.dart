import 'package:flutter/material.dart';
import 'package:foodia_chef/core/routes/routes.dart';
import 'package:foodia_chef/core/routes/routing_observer.dart';
import 'package:foodia_chef/core/routes/screen_withfade_transition.dart';
import 'package:go_router/go_router.dart';

import '../../feature/auth/forgotPassword/presentation/screen/otp_reset_password_screen.dart';
import '../../feature/auth/forgotPassword/presentation/widget/forgot_passowrd_chenge.dart';
import '../../feature/auth/login/presentation/screens/login_screen.dart';
import '../../feature/auth/login/presentation/screens/register_screen.dart';
import '../../feature/auth/otp/presentation/screen/otp_screen.dart';
import '../../feature/bottom_navigation_bar/custom_button_nav_bar.dart';
import '../../feature/profile/presentation/screen/edit_profile_screen.dart';
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
              pageBuilder: (context, state) => screenWithFadeTransition(
                context: context,
                state: state,
                child: const LoginScreen(),
              ),
            ),
            GoRoute(
              parentNavigatorKey: appNavigatorKey,
              path: Routes.onboardingScreen,
              name: Routes.onboardingScreen,
              pageBuilder: (context, state) => screenWithFadeTransition(
                context: context,
                state: state,
                child: const OnboardingScreen(),
              ),
            ),
            GoRoute(
              parentNavigatorKey: appNavigatorKey,
              path: Routes.registerScreen,
              name: Routes.registerScreen,
              pageBuilder: (context, state) => screenWithFadeTransition(
                context: context,
                state: state,
                child: const RegisterScreen(),
              ),
            ),
            GoRoute(
              parentNavigatorKey: appNavigatorKey,
              path: Routes.otpScreen,
              name: Routes.otpScreen,
              pageBuilder: (context, state) {
                final phoneNumber = state.extra;
                if (phoneNumber is! String || phoneNumber.isEmpty) {
                  return screenWithFadeTransition(
                    context: context,
                    state: state,
                    child: const Text("Invalid phone number"),
                  );
                }
                return screenWithFadeTransition(
                  context: context,
                  state: state,
                  child: OtpScreen(phoneNumber: phoneNumber),
                );
              },
            ),
            GoRoute(
              parentNavigatorKey: appNavigatorKey,
              path: Routes.forgotPasswordOtp,
              name: Routes.forgotPasswordOtp,
              pageBuilder: (context, state) {
                final phoneNumber = state.extra;
                if (phoneNumber is! String || phoneNumber.isEmpty) {
                  return screenWithFadeTransition(
                    context: context,
                    state: state,
                    child: const Text("Phone number is missing"),
                  );
                }
                return screenWithFadeTransition(
                  context: context,
                  state: state,
                  child: OtpResetPasswordScreen(phoneNumber: phoneNumber),
                );
              },
            ),
            GoRoute(
              parentNavigatorKey: appNavigatorKey,
              path: Routes.changePasswordScreen,
              name: Routes.changePasswordScreen,
              pageBuilder: (context, state) {
                final phoneNumber = state.extra;
                if (phoneNumber is! String || phoneNumber.isEmpty) {
                  return screenWithFadeTransition(
                    context: context,
                    state: state,
                    child: const Text("Phone number is missing"),
                  );
                }
                return screenWithFadeTransition(
                  context: context,
                  state: state,
                  child: ForgotPassowrdChenge(phoneNumber: phoneNumber),
                );
              },
            ),
            GoRoute(
              parentNavigatorKey: appNavigatorKey,
              path: Routes.editProfileScreen,
              name: Routes.editProfileScreen,
              pageBuilder: (context, state) {
                final extraData = state.extra;

                if (extraData == null || extraData is! Map<String, dynamic>) {
                  return screenWithFadeTransition(
                    context: context,
                    state: state,
                    child: const Center(child: Text("بيانات غير صحيحة")),
                  );
                }

                final name = extraData['name'] as String? ?? '';
                final email = extraData['email'] as String? ?? '';
                final phone = extraData['phone'] as String? ?? '';
                final image = extraData['image'] as String? ?? '';
                final bio = extraData['bio'] as String? ?? '';

                return screenWithFadeTransition(
                  context: context,
                  state: state,
                  child: EditProfileScreen(
                    name: name,
                    email: email,
                    phone: phone,
                    image: image,
                    bio: bio,
                  ),
                );
              },
            ),
            GoRoute(
              parentNavigatorKey: appNavigatorKey,
              path: Routes.bottomNavBar,
              name: Routes.bottomNavBar,
              pageBuilder: (context, state) => screenWithFadeTransition(
                context: context,
                state: state,
                child: const BottomNavBar(),
              ),
            ),
          ],
        );
}

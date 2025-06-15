import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../routes/app_router.dart';

extension Navigation on BuildContext {
  Future<dynamic> pushNamed(String routeName, {Object? arguments}) {
    return GoRouter.of(AppRouter.appNavigatorKey.currentState!.context)
        .pushNamed(routeName, extra: arguments);
  }

  Future<dynamic> push(Widget screen) {
    return Navigator.of(this)
        .push(MaterialPageRoute(builder: (context) => screen));
  }

  Future<dynamic> pushAndRemoveUntil(Widget screen) {
    return Navigator.of(this).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (context) => screen,
      ),
      (route) => false,
    );
  }

  Future<dynamic> pushReplacement(Widget screen) {
    return Navigator.of(this)
        .pushReplacement(MaterialPageRoute(builder: (context) => screen));
  }

  Future<dynamic> pushReplacementNamed(String routeName, {Object? arguments}) {
    return GoRouter.of(AppRouter.appNavigatorKey.currentState!.context)
        .pushReplacementNamed(routeName, extra: arguments);
  }

  void pushNamedAndRemoveUntil(String routeName,
      {Object? arguments, required RoutePredicate predicate}) {
    return GoRouter.of(AppRouter.appNavigatorKey.currentState!.context)
        .goNamed(routeName, extra: arguments);
  }

  void pop() =>
      GoRouter.of(AppRouter.appNavigatorKey.currentState!.context).pop();
}

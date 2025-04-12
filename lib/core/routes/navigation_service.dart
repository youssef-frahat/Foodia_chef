import 'package:go_router/go_router.dart';

import 'app_router.dart';

class NavigationService {

  navigateTo(String routeName, {dynamic arguments}) {
    GoRouter.of(AppRouter.appNavigatorKey.currentState!.context).pushNamed(routeName, extra: arguments);
  }

  navigateReplacementTo(String routeName, {dynamic arguments}) {
    GoRouter.of(AppRouter.appNavigatorKey.currentState!.context).pushReplacementNamed(routeName, extra: arguments);
  }
  navigatePushNamedAndRemoveUntil(String routeName, {dynamic arguments}) {
    GoRouter.of(AppRouter.appNavigatorKey.currentState!.context).goNamed(routeName,  extra: arguments);
  }

  popup() {
    GoRouter.of(AppRouter.appNavigatorKey.currentState!.context).pop();
  }
}
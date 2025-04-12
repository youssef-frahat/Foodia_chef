import 'dart:developer';

import 'package:flutter/material.dart';


class GoRouterObserver extends NavigatorObserver {
  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
   log('#################### Route didPush: $route #####################');
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    log('#################### Route didPop: $route #####################');
  }

  @override
  void didRemove(Route<dynamic> route, Route<dynamic>? previousRoute) {
    log(
        '#################### Route didRemove: $route #####################');
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    log(
        '#################### Route didReplace: $newRoute #####################');
  }
}

import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectivityHelper {
  const ConnectivityHelper._();

  static Future<bool> get connected async =>
      !(await Connectivity().checkConnectivity())
          .contains(ConnectivityResult.none);
}

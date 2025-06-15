import 'package:foodia_chef/core/helpers/shared_pref_local_storage.dart';

class AppConstants {
  static const String authorization = 'Authorization';
  static const String bearer = 'Bearer';
  static String token = SharedPref().get(key: "token");
}

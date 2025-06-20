import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  static late SharedPreferences sharedPreferences;
  static init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  dynamic get({
    required String key,
  }) {
    return sharedPreferences.get(key);
  }

  Future<bool> set({required String key, required dynamic value}) async {
    if (value is String) {
      return await sharedPreferences.setString(key, value);
    }
    if (value is int) {
      return await sharedPreferences.setInt(key, value);
    }
    if (value is bool) {
      return await sharedPreferences.setBool(key, value);
    }

    return await sharedPreferences.setDouble(key, value);
  }

  Future<bool> remove({required String key}) async {
    return await sharedPreferences.remove(key);
  }

  Future<bool> clear() async {
    return await sharedPreferences.clear();
  }

  bool containKey({required String key}) {
    return sharedPreferences.containsKey(key);
  }
}

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureLocalStorage {
  static const FlutterSecureStorage storage = FlutterSecureStorage();

  static Future<void> write(String key, String value) async {
    await storage.write(key: key, value: value);
  }

  static Future<String?> read(String key) async {
    String? value = await storage.read(key: key);
    return value;
  }

  static Future<void> delete(String key) async {
    await storage.delete(key: key);
  }
}

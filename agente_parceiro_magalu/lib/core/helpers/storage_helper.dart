import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageHelper {
  static const FlutterSecureStorage _secureStorage = FlutterSecureStorage();

  static Future<String?> read({required String key}) async {
    return _secureStorage.read(key: key);
  }

  static Future<void> write(
      {required String key, required dynamic value}) async {
    return _secureStorage.write(key: key, value: value.toString());
  }

  static Future<void> delete({required String key}) {
    return _secureStorage.delete(key: key);
  }

  static Future<void> deleteAll() {
    return _secureStorage.deleteAll();
  }
}

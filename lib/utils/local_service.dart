import 'package:get_storage/get_storage.dart';
import 'package:base_flutter/models/api/user_info.dart';
import 'package:base_flutter/models/token/token_manager.dart';
import 'package:flutter_keychain/flutter_keychain.dart';

class LocalService {
  static final _box = GetStorage();

  static void save(String key, dynamic value, bool userOnly) {
    UserInfo? user = TokenManager.userInfo;
    String userId = user?.email ?? "";
    String finalKey = userOnly ? userId + key : key;
    _box.write(finalKey, value);
  }

  static dynamic get(String key, bool userOnly) {
    UserInfo? user = TokenManager.userInfo;
    String userId = user?.email ?? "";
    String finalKey = userOnly ? userId + key : key;
    return _box.read(finalKey);
  }
}

class KeyChainService {
  static Future save(String key, dynamic value, bool userOnly) async {
    UserInfo? user = TokenManager.userInfo;
    String userId = user?.email ?? "";
    String finalKey = userOnly ? userId + key : key;
    if (value == null) {
      return await FlutterKeychain.remove(key: finalKey);
    }
    return await FlutterKeychain.put(key: finalKey, value: value);
  }

  static Future<dynamic> get(String key, bool userOnly) async {
    UserInfo? user = TokenManager.userInfo;
    String userId = user?.email ?? "";
    String finalKey = userOnly ? userId + key : key;
    return await FlutterKeychain.get(key: finalKey);
  }
}

import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  static late SharedPreferences sharedPreferences;

  static init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static Future<dynamic> setData({
    required String key,
    required dynamic value,
  }) async {
    if (value is String) return await sharedPreferences.setString(key, value);
    if (value is bool) return await sharedPreferences.setBool(key, value);
    if (value is int) return await sharedPreferences.setInt(key, value);
    return await sharedPreferences.setDouble(key, value);
  }

  static dynamic getData({
    required String key,
  }) async {
    return sharedPreferences.get(key);
  }

  static Future<dynamic> reloadData() async {
    return await sharedPreferences.reload();
  }

  static dynamic deleteData({
    required String key,
  }) {
    return sharedPreferences.remove(key);
  }
}

import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  static late SharedPreferences sharedPreferences;

  static init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static Future<bool> putData(
  {
   required String key,
   required bool value
}
      ) async {
    return await sharedPreferences.setBool(key, value);
  }


  static Future<bool> putDataList(
      {
        required String key,
        required List<String> value
      }
      ) async {
    return await sharedPreferences.setStringList(key, value);
  }

  static dynamic getData(
  {
    required String key,
  }) {
    return sharedPreferences.get(key);
  }


  static dynamic getDataList(
      {
        required String key,
      }) {
    return sharedPreferences.getStringList(key);
  }

  static Future<bool> saveLoginData(
      String key,
      dynamic value) async {
    if (value is String) return await sharedPreferences.setString(key, value);
    if (value is int) return await sharedPreferences.setInt(key, value);
    if (value is bool) return await sharedPreferences.setBool(key, value);
    return await sharedPreferences.setDouble(key, value);
  }

  static removeData({required key}) async {
    return await sharedPreferences.remove(key);
  }

  static Future<bool> clearData() async {
    return await sharedPreferences.clear();
  }
}

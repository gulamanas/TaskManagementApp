import 'package:shared_preferences/shared_preferences.dart';

class TodoSharedPreff {
  static Future<SharedPreferences> getInstance() async {
    return await SharedPreferences.getInstance();
  }

  static setInt(SharedPreferences pref, String key, int value) async {
    pref.setInt(key, value);
  }

  static setBool(SharedPreferences pref, String key, bool value) async {
    pref.setBool(key, value);
  }

  static setDouble(SharedPreferences pref, String key, double value) async {
    pref.setDouble(key, value);
  }

  static setString(SharedPreferences pref, String key, String value) async {
    pref.setString(key, value);
  }

  static getString(String key) async {
    return await getInstance().then((instance) => {instance.getString(key)});
  }

  static getInt(String key) async {
    return await getInstance().then((instance) => {instance.getInt(key)});
  }

  static getBool(String key) async {
    return await getInstance().then((instance) => {instance.getBool(key)});
  }

  static getDouble(String key) async {
    return await getInstance().then((instance) => {instance.getDouble(key)});
  }
}
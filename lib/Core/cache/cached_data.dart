import 'package:shared_preferences/shared_preferences.dart';

class CachedData {
  static late SharedPreferences _prefrences;
  static Future init() async =>
      _prefrences = await SharedPreferences.getInstance();
  static Future<void> saveData({key, data}) async {
    await _prefrences.setString(key, data);
  }

  static String? getData({key}) {
    return _prefrences.getString(key);
  }

  static bool containsKey(key) {
    return _prefrences.containsKey(key);
  }

  static Future<void> deleteData(key) async {
    await _prefrences.remove(key);
  }

  static Future<void> deleteAllData() async {
    await _prefrences.clear();
  }
}

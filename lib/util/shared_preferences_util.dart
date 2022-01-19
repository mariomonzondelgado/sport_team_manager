import 'package:shared_preferences/shared_preferences.dart';

/// Utils to work with Shaared Preference plugin
class SharedPreferenceUtils {
  /// Returns a value for the given [key] or null if [key] is not in the storage.
  static Future<String?> get(String key) async {
    final prefs = await SharedPreferences.getInstance();
    final value = prefs.getString(key);
    return value;
  }

  /// Saves the [key] with the given [value].
  static set(String key, String? value) async {
    final prefs = await SharedPreferences.getInstance();
    if (value == null) {
      remove(key);
    } else {
      await prefs.setString(key, value);
    }
  }

  /// Returns a boolean value for the given [key],
  /// return false if [key] does not exist.
  static Future<bool?> getBool(String key) async {
    final prefs = await SharedPreferences.getInstance();
    final value = prefs.getBool(key);
    return value ?? false;
  }

  /// Saves the [key] with the given [value].
  static Future<void> setBool(String key, bool? value) async {
    final prefs = await SharedPreferences.getInstance();
    if (value == null) {
      remove(key);
    } else {
      await prefs.setBool(key, value);
    }
  }

  /// Deletes all keys.
  static removeAll() async {
    final pref = await SharedPreferences.getInstance();
    await pref.clear();
  }

  /// Deletes associated value for the given [key].
  static remove(String key) async {
    final pref = await SharedPreferences.getInstance();
    await pref.remove(key);
  }
}

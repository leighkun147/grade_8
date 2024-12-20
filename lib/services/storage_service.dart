import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  final SharedPreferences _prefs;

  StorageService(this._prefs);

  Future<bool> setString(String key, String value) async {
    return await _prefs.setString(key, value);
  }

  String? getString(String key) {
    return _prefs.getString(key);
  }

  Future<bool> setInt(String key, int value) async {
    return await _prefs.setInt(key, value);
  }

  int? getInt(String key) {
    return _prefs.getInt(key);
  }

  Future<bool> setBool(String key, bool value) async {
    return await _prefs.setBool(key, value);
  }

  bool? getBool(String key) {
    return _prefs.getBool(key);
  }

  Future<bool> setObject<T>(String key, T value) async {
    return await _prefs.setString(key, jsonEncode(value));
  }

  T? getObject<T>(String key, T Function(Map<String, dynamic> json) fromJson) {
    final value = _prefs.getString(key);
    if (value == null) return null;
    return fromJson(jsonDecode(value) as Map<String, dynamic>);
  }

  Future<bool> remove(String key) async {
    return await _prefs.remove(key);
  }

  Future<bool> clear() async {
    return await _prefs.clear();
  }

  bool hasKey(String key) {
    return _prefs.containsKey(key);
  }

  Set<String> getKeys() {
    return _prefs.getKeys();
  }

  Future<void> reload() async {
    await _prefs.reload();
  }
}

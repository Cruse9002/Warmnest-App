import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  static const String keyUserProfile = 'user_profile';
  static const String keyMoodLogs = 'mood_logs';
  static const String keyJournalEntries = 'journal_entries';
  static const String keyBreathingSessions = 'breathing_sessions';
  static const String keyPomodoroSessions = 'pomodoro_sessions';
  static const String keyChatHistory = 'chat_history';
  static const String keyLanguage = 'language';
  static const String keyDarkMode = 'dark_mode';

  Future<void> saveJson(String key, Map<String, dynamic> value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, jsonEncode(value));
  }

  Future<Map<String, dynamic>?> readJson(String key) async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(key);
    if (raw == null) return null;
    return jsonDecode(raw) as Map<String, dynamic>;
  }

  Future<void> saveJsonList(String key, List<Map<String, dynamic>> values) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, jsonEncode(values));
  }

  Future<List<dynamic>> readJsonList(String key) async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(key);
    if (raw == null) return [];
    final decoded = jsonDecode(raw);
    if (decoded is List<dynamic>) return decoded;
    return [];
  }

  Future<void> saveBool(String key, bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(key, value);
  }

  Future<bool?> readBool(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(key);
  }

  Future<void> saveString(String key, String value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, value);
  }

  Future<String?> readString(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }

  Future<void> clearAll() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}



import 'dart:math';
import 'package:flutter/material.dart';
import 'models.dart';
import 'storage_service.dart';

class AppState extends ChangeNotifier {
  final StorageService _storage;

  UserProfile? _user;
  List<MoodLog> _moodLogs = [];
  List<JournalEntryModel> _journalEntries = [];
  List<BreathingSession> _breathingSessions = [];
  List<PomodoroSession> _pomodoroSessions = [];
  List<ChatMessageModel> _chatHistory = [];
  String _language = 'en';
  bool _darkMode = true;

  AppState(this._storage);

  UserProfile? get user => _user;
  List<MoodLog> get moodLogs => List.unmodifiable(_moodLogs);
  List<JournalEntryModel> get journalEntries => List.unmodifiable(_journalEntries);
  List<BreathingSession> get breathingSessions => List.unmodifiable(_breathingSessions);
  List<PomodoroSession> get pomodoroSessions => List.unmodifiable(_pomodoroSessions);
  List<ChatMessageModel> get chatHistory => List.unmodifiable(_chatHistory);
  String get language => _language;
  bool get darkMode => _darkMode;

  Future<void> load() async {
    // user
    final userJson = await _storage.readJson(StorageService.keyUserProfile);
    if (userJson != null) {
      _user = UserProfile.fromJson(userJson);
      _darkMode = _user?.darkMode ?? _darkMode;
      _language = _user?.language ?? _language;
    } else {
      final lang = await _storage.readString(StorageService.keyLanguage);
      final dark = await _storage.readBool(StorageService.keyDarkMode);
      if (lang != null) _language = lang;
      if (dark != null) _darkMode = dark;
    }

    // mood logs
    final moodList = await _storage.readJsonList(StorageService.keyMoodLogs);
    _moodLogs = moodList
        .whereType<Map<String, dynamic>>()
        .map((e) => MoodLog.fromJson(e))
        .toList();

    // journals
    final journalList = await _storage.readJsonList(StorageService.keyJournalEntries);
    _journalEntries = journalList
        .whereType<Map<String, dynamic>>()
        .map((e) => JournalEntryModel.fromJson(e))
        .toList();

    // breathing
    final breathingList = await _storage.readJsonList(StorageService.keyBreathingSessions);
    _breathingSessions = breathingList
        .whereType<Map<String, dynamic>>()
        .map((e) => BreathingSession.fromJson(e))
        .toList();

    // pomodoro
    final pomoList = await _storage.readJsonList(StorageService.keyPomodoroSessions);
    _pomodoroSessions = pomoList
        .whereType<Map<String, dynamic>>()
        .map((e) => PomodoroSession.fromJson(e))
        .toList();

    // chat
    final chatList = await _storage.readJsonList(StorageService.keyChatHistory);
    _chatHistory = chatList
        .whereType<Map<String, dynamic>>()
        .map((e) => ChatMessageModel.fromJson(e))
        .toList();

    notifyListeners();
  }

  Future<void> login({required String email, required String name}) async {
    final id = _randomId();
    _user = UserProfile(
      id: id,
      email: email,
      name: name,
      language: _language,
      onboarded: false,
      hasCompletedQuestionnaire: false,
      darkMode: _darkMode,
    );
    await _storage.saveJson(StorageService.keyUserProfile, _user!.toJson());
    notifyListeners();
  }

  Future<void> logout() async {
    _user = null;
    await _storage.clearAll();
    notifyListeners();
  }

  Future<void> updateProfile(UserProfile updated) async {
    _user = updated;
    _language = updated.language;
    _darkMode = updated.darkMode;
    await _storage.saveJson(StorageService.keyUserProfile, updated.toJson());
    notifyListeners();
  }

  Future<void> setLanguage(String lang) async {
    _language = lang;
    await _storage.saveString(StorageService.keyLanguage, lang);
    if (_user != null) {
      await updateProfile(_user!.copyWith(language: lang));
    } else {
      notifyListeners();
    }
  }

  Future<void> setDarkMode(bool value) async {
    _darkMode = value;
    await _storage.saveBool(StorageService.keyDarkMode, value);
    if (_user != null) {
      await updateProfile(_user!.copyWith(darkMode: value));
    } else {
      notifyListeners();
    }
  }

  Future<void> addMood(MoodLog log) async {
    _moodLogs = [..._moodLogs, log];
    await _storage.saveJsonList(
      StorageService.keyMoodLogs,
      _moodLogs.map((e) => e.toJson()).toList(),
    );
    notifyListeners();
  }

  Future<void> addJournal(JournalEntryModel entry) async {
    _journalEntries = [..._journalEntries, entry];
    await _storage.saveJsonList(
      StorageService.keyJournalEntries,
      _journalEntries.map((e) => e.toJson()).toList(),
    );
    notifyListeners();
  }

  Future<void> addBreathingSession(BreathingSession s) async {
    _breathingSessions = [..._breathingSessions, s];
    await _storage.saveJsonList(
      StorageService.keyBreathingSessions,
      _breathingSessions.map((e) => e.toJson()).toList(),
    );
    notifyListeners();
  }

  Future<void> addPomodoroSession(PomodoroSession s) async {
    _pomodoroSessions = [..._pomodoroSessions, s];
    await _storage.saveJsonList(
      StorageService.keyPomodoroSessions,
      _pomodoroSessions.map((e) => e.toJson()).toList(),
    );
    notifyListeners();
  }

  Future<void> addChatMessage(ChatMessageModel m) async {
    _chatHistory = [..._chatHistory, m];
    await _storage.saveJsonList(
      StorageService.keyChatHistory,
      _chatHistory.map((e) => e.toJson()).toList(),
    );
    notifyListeners();
  }

  String _randomId() {
    final r = Random();
    return List.generate(12, (_) => r.nextInt(36).toRadixString(36)).join();
  }
}

class AppStateProvider extends InheritedNotifier<AppState> {
  const AppStateProvider({super.key, required AppState super.notifier, required super.child});

  static AppState of(BuildContext context) {
    final provider = context.dependOnInheritedWidgetOfExactType<AppStateProvider>();
    assert(provider != null, 'AppStateProvider not found in widget tree');
    return provider!.notifier!;
  }
}



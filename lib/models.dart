
class UserProfile {
  final String id;
  final String email;
  final String name;
  final String language; // 'en' | 'ta'
  final bool onboarded;
  final bool hasCompletedQuestionnaire;
  final bool darkMode;
  final String? photoUrl;
  final String? dob;
  final String? gender; // 'male' | 'female' | 'other' | 'preferNotToSay'
  final String? favoriteColor;
  final String? stressSource;
  final String? copingMechanism;

  const UserProfile({
    required this.id,
    required this.email,
    required this.name,
    required this.language,
    required this.onboarded,
    required this.hasCompletedQuestionnaire,
    required this.darkMode,
    this.photoUrl,
    this.dob,
    this.gender,
    this.favoriteColor,
    this.stressSource,
    this.copingMechanism,
  });

  UserProfile copyWith({
    String? id,
    String? email,
    String? name,
    String? language,
    bool? onboarded,
    bool? hasCompletedQuestionnaire,
    bool? darkMode,
    String? photoUrl,
    String? dob,
    String? gender,
    String? favoriteColor,
    String? stressSource,
    String? copingMechanism,
  }) {
    return UserProfile(
      id: id ?? this.id,
      email: email ?? this.email,
      name: name ?? this.name,
      language: language ?? this.language,
      onboarded: onboarded ?? this.onboarded,
      hasCompletedQuestionnaire: hasCompletedQuestionnaire ?? this.hasCompletedQuestionnaire,
      darkMode: darkMode ?? this.darkMode,
      photoUrl: photoUrl ?? this.photoUrl,
      dob: dob ?? this.dob,
      gender: gender ?? this.gender,
      favoriteColor: favoriteColor ?? this.favoriteColor,
      stressSource: stressSource ?? this.stressSource,
      copingMechanism: copingMechanism ?? this.copingMechanism,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'email': email,
        'name': name,
        'language': language,
        'onboarded': onboarded,
        'hasCompletedQuestionnaire': hasCompletedQuestionnaire,
        'darkMode': darkMode,
        'photoUrl': photoUrl,
        'dob': dob,
        'gender': gender,
        'favoriteColor': favoriteColor,
        'stressSource': stressSource,
        'copingMechanism': copingMechanism,
      };

  factory UserProfile.fromJson(Map<String, dynamic> json) => UserProfile(
        id: json['id'] as String,
        email: json['email'] as String,
        name: json['name'] as String,
        language: json['language'] as String? ?? 'en',
        onboarded: json['onboarded'] as bool? ?? false,
        hasCompletedQuestionnaire: json['hasCompletedQuestionnaire'] as bool? ?? false,
        darkMode: json['darkMode'] as bool? ?? true,
        photoUrl: json['photoUrl'] as String?,
        dob: json['dob'] as String?,
        gender: json['gender'] as String?,
        favoriteColor: json['favoriteColor'] as String?,
        stressSource: json['stressSource'] as String?,
        copingMechanism: json['copingMechanism'] as String?,
      );
}

class MoodLog {
  final String id;
  final String mood; // 'happy' | 'calm' | 'neutral' | 'anxious' | 'sad'
  final int intensity; // 1-10
  final DateTime timestamp;
  final String? note;

  const MoodLog({
    required this.id,
    required this.mood,
    required this.intensity,
    required this.timestamp,
    this.note,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'mood': mood,
        'intensity': intensity,
        'timestamp': timestamp.toIso8601String(),
        'note': note,
      };

  factory MoodLog.fromJson(Map<String, dynamic> json) => MoodLog(
        id: json['id'] as String,
        mood: json['mood'] as String,
        intensity: json['intensity'] as int,
        timestamp: DateTime.parse(json['timestamp'] as String),
        note: json['note'] as String?,
      );
}

class JournalEntryModel {
  final String id;
  final String content;
  final DateTime timestamp;
  final List<String> tags;

  const JournalEntryModel({
    required this.id,
    required this.content,
    required this.timestamp,
    this.tags = const [],
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'content': content,
        'timestamp': timestamp.toIso8601String(),
        'tags': tags,
      };

  factory JournalEntryModel.fromJson(Map<String, dynamic> json) => JournalEntryModel(
        id: json['id'] as String,
        content: json['content'] as String,
        timestamp: DateTime.parse(json['timestamp'] as String),
        tags: (json['tags'] as List<dynamic>? ?? []).cast<String>(),
      );
}

class BreathingSession {
  final String exerciseId;
  final int durationMinutes;
  final DateTime timestamp;

  const BreathingSession({
    required this.exerciseId,
    required this.durationMinutes,
    required this.timestamp,
  });

  Map<String, dynamic> toJson() => {
        'exerciseId': exerciseId,
        'durationMinutes': durationMinutes,
        'timestamp': timestamp.toIso8601String(),
      };

  factory BreathingSession.fromJson(Map<String, dynamic> json) => BreathingSession(
        exerciseId: json['exerciseId'] as String,
        durationMinutes: json['durationMinutes'] as int,
        timestamp: DateTime.parse(json['timestamp'] as String),
      );
}

class PomodoroSession {
  final String id;
  final DateTime startTime;
  final DateTime endTime;
  final int workDurationMinutes;
  final int breakDurationMinutes;
  final int cyclesCompleted;

  const PomodoroSession({
    required this.id,
    required this.startTime,
    required this.endTime,
    required this.workDurationMinutes,
    required this.breakDurationMinutes,
    required this.cyclesCompleted,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'startTime': startTime.toIso8601String(),
        'endTime': endTime.toIso8601String(),
        'workDurationMinutes': workDurationMinutes,
        'breakDurationMinutes': breakDurationMinutes,
        'cyclesCompleted': cyclesCompleted,
      };

  factory PomodoroSession.fromJson(Map<String, dynamic> json) => PomodoroSession(
        id: json['id'] as String,
        startTime: DateTime.parse(json['startTime'] as String),
        endTime: DateTime.parse(json['endTime'] as String),
        workDurationMinutes: json['workDurationMinutes'] as int,
        breakDurationMinutes: json['breakDurationMinutes'] as int,
        cyclesCompleted: json['cyclesCompleted'] as int,
      );
}

class ChatMessageModel {
  final String id;
  final String text;
  final bool isBot;
  final DateTime timestamp;

  const ChatMessageModel({
    required this.id,
    required this.text,
    required this.isBot,
    required this.timestamp,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'text': text,
        'isBot': isBot,
        'timestamp': timestamp.toIso8601String(),
      };

  factory ChatMessageModel.fromJson(Map<String, dynamic> json) => ChatMessageModel(
        id: json['id'] as String,
        text: json['text'] as String,
        isBot: json['isBot'] as bool? ?? false,
        timestamp: DateTime.parse(json['timestamp'] as String),
      );
}



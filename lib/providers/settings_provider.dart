import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppSettings {
  final ThemeMode themeMode;
  final bool notificationsEnabled;
  final String language;
  final bool soundEnabled;
  final bool vibrationEnabled;
  final DateTime? examDate;

  AppSettings({
    this.themeMode = ThemeMode.system,
    this.notificationsEnabled = true,
    this.language = 'en',
    this.soundEnabled = true,
    this.vibrationEnabled = true,
    this.examDate,
  });

  AppSettings copyWith({
    ThemeMode? themeMode,
    bool? notificationsEnabled,
    String? language,
    bool? soundEnabled,
    bool? vibrationEnabled,
    DateTime? examDate,
  }) {
    return AppSettings(
      themeMode: themeMode ?? this.themeMode,
      notificationsEnabled: notificationsEnabled ?? this.notificationsEnabled,
      language: language ?? this.language,
      soundEnabled: soundEnabled ?? this.soundEnabled,
      vibrationEnabled: vibrationEnabled ?? this.vibrationEnabled,
      examDate: examDate ?? this.examDate,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'themeMode': themeMode.index,
      'notificationsEnabled': notificationsEnabled,
      'language': language,
      'soundEnabled': soundEnabled,
      'vibrationEnabled': vibrationEnabled,
      'examDate': examDate?.toIso8601String(),
    };
  }

  factory AppSettings.fromJson(Map<String, dynamic> json) {
    return AppSettings(
      themeMode: ThemeMode.values[json['themeMode'] as int],
      notificationsEnabled: json['notificationsEnabled'] as bool,
      language: json['language'] as String,
      soundEnabled: json['soundEnabled'] as bool,
      vibrationEnabled: json['vibrationEnabled'] as bool,
      examDate: json['examDate'] != null
          ? DateTime.parse(json['examDate'] as String)
          : null,
    );
  }
}

final settingsProvider =
    StateNotifierProvider<SettingsNotifier, AppSettings>((ref) {
  return SettingsNotifier();
});

class SettingsNotifier extends StateNotifier<AppSettings> {
  SettingsNotifier() : super(AppSettings()) {
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    final settingsJson = prefs.getString('settings');
    if (settingsJson != null) {
      final settingsMap = Map<String, dynamic>.from(
        // ignore: unnecessary_cast
        const JsonDecoder().convert(settingsJson) as Map,
      );
      state = AppSettings.fromJson(settingsMap);
    }
  }

  Future<void> _saveSettings() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
      'settings',
      const JsonEncoder().convert(state.toJson()),
    );
  }

  Future<void> updateThemeMode(ThemeMode themeMode) async {
    state = state.copyWith(themeMode: themeMode);
    await _saveSettings();
  }

  Future<void> toggleNotifications() async {
    state = state.copyWith(notificationsEnabled: !state.notificationsEnabled);
    await _saveSettings();
  }

  Future<void> updateLanguage(String language) async {
    state = state.copyWith(language: language);
    await _saveSettings();
  }

  Future<void> toggleSound() async {
    state = state.copyWith(soundEnabled: !state.soundEnabled);
    await _saveSettings();
  }

  Future<void> toggleVibration() async {
    state = state.copyWith(vibrationEnabled: !state.vibrationEnabled);
    await _saveSettings();
  }

  Future<void> updateExamDate(DateTime examDate) async {
    state = state.copyWith(examDate: examDate);
    await _saveSettings();
  }

  Future<void> resetSettings() async {
    state = AppSettings();
    await _saveSettings();
  }
}

// Provider for exam countdown
final examCountdownProvider = Provider<Duration?>((ref) {
  final settings = ref.watch(settingsProvider);
  if (settings.examDate == null) return null;
  
  final now = DateTime.now();
  return settings.examDate!.difference(now);
});

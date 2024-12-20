import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../lib/providers/settings_provider.dart';

void main() {
  late ProviderContainer container;

  setUp(() async {
    TestWidgetsFlutterBinding.ensureInitialized();
    SharedPreferences.setMockInitialValues({});
    
    container = ProviderContainer();
  });

  tearDown(() {
    container.dispose();
  });

  group('SettingsProvider', () {
    test('initial state has default values', () {
      final settings = container.read(settingsProvider);
      
      expect(settings.themeMode, equals(ThemeMode.system));
      expect(settings.notificationsEnabled, isTrue);
      expect(settings.language, equals('en'));
      expect(settings.soundEnabled, isTrue);
      expect(settings.vibrationEnabled, isTrue);
      expect(settings.examDate, isNull);
    });

    test('updateThemeMode updates theme mode', () async {
      final notifier = container.read(settingsProvider.notifier);
      
      await notifier.updateThemeMode(ThemeMode.dark);
      
      final settings = container.read(settingsProvider);
      expect(settings.themeMode, equals(ThemeMode.dark));
    });

    test('toggleNotifications toggles notification state', () async {
      final notifier = container.read(settingsProvider.notifier);
      
      final initialState = container.read(settingsProvider).notificationsEnabled;
      await notifier.toggleNotifications();
      
      final newState = container.read(settingsProvider).notificationsEnabled;
      expect(newState, equals(!initialState));
    });

    test('updateLanguage changes language', () async {
      final notifier = container.read(settingsProvider.notifier);
      
      await notifier.updateLanguage('am');
      
      final settings = container.read(settingsProvider);
      expect(settings.language, equals('am'));
    });

    test('toggleSound toggles sound state', () async {
      final notifier = container.read(settingsProvider.notifier);
      
      final initialState = container.read(settingsProvider).soundEnabled;
      await notifier.toggleSound();
      
      final newState = container.read(settingsProvider).soundEnabled;
      expect(newState, equals(!initialState));
    });

    test('toggleVibration toggles vibration state', () async {
      final notifier = container.read(settingsProvider.notifier);
      
      final initialState = container.read(settingsProvider).vibrationEnabled;
      await notifier.toggleVibration();
      
      final newState = container.read(settingsProvider).vibrationEnabled;
      expect(newState, equals(!initialState));
    });

    test('updateExamDate updates exam date', () async {
      final notifier = container.read(settingsProvider.notifier);
      final examDate = DateTime(2024, 12, 31);
      
      await notifier.updateExamDate(examDate);
      
      final settings = container.read(settingsProvider);
      expect(settings.examDate, equals(examDate));
    });

    test('resetSettings resets all settings to default', () async {
      final notifier = container.read(settingsProvider.notifier);
      
      // Change some settings
      await notifier.updateThemeMode(ThemeMode.dark);
      await notifier.toggleNotifications();
      await notifier.updateLanguage('am');
      
      // Reset settings
      await notifier.resetSettings();
      
      final settings = container.read(settingsProvider);
      expect(settings.themeMode, equals(ThemeMode.system));
      expect(settings.notificationsEnabled, isTrue);
      expect(settings.language, equals('en'));
      expect(settings.soundEnabled, isTrue);
      expect(settings.vibrationEnabled, isTrue);
      expect(settings.examDate, isNull);
    });
  });

  group('examCountdownProvider', () {
    test('returns null when exam date is not set', () {
      final countdown = container.read(examCountdownProvider);
      expect(countdown, isNull);
    });

    test('returns duration until exam when date is set', () async {
      final notifier = container.read(settingsProvider.notifier);
      final examDate = DateTime.now().add(const Duration(days: 30));
      
      await notifier.updateExamDate(examDate);
      
      final countdown = container.read(examCountdownProvider);
      expect(countdown, isNotNull);
      expect(countdown!.inDays, equals(30));
    });
  });
}

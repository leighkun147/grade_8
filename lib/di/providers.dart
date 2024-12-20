import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/storage_service.dart';
import '../services/analytics_service.dart';

// Core Services
final sharedPreferencesProvider = Provider<SharedPreferences>((ref) {
  throw UnimplementedError();
});

final storageServiceProvider = Provider<StorageService>((ref) {
  final prefs = ref.watch(sharedPreferencesProvider);
  return StorageService(prefs);
});

final analyticsServiceProvider = Provider<AnalyticsService>((ref) {
  return AnalyticsService();
});

// Cache Providers
final cacheDurationProvider = Provider<Duration>((ref) {
  return const Duration(days: 7);
});

// Environment Configuration
final environmentProvider = Provider<String>((ref) {
  // TODO: Implement environment configuration
  return 'development';
});

// Global State Providers
final isOnlineProvider = StateProvider<bool>((ref) {
  return true;
});

final currentRouteProvider = StateProvider<String>((ref) {
  return '/';
});

// App Lifecycle Provider
final appLifecycleProvider = StateProvider<AppLifecycleState>((ref) {
  return AppLifecycleState.resumed;
});

// Device Info Provider
final deviceInfoProvider = FutureProvider((ref) async {
  // TODO: Implement device info
  return {};
});

// App Version Provider
final appVersionProvider = Provider<String>((ref) {
  return '1.0.0';
});

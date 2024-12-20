import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_performance/firebase_performance.dart';

class MonitoringService {
  static final MonitoringService _instance = MonitoringService._internal();
  factory MonitoringService() => _instance;
  MonitoringService._internal();

  late final FirebaseAnalytics _analytics;
  late final FirebaseCrashlytics _crashlytics;
  late final FirebasePerformance _performance;

  Future<void> initialize() async {
    _analytics = FirebaseAnalytics.instance;
    _crashlytics = FirebaseCrashlytics.instance;
    _performance = FirebasePerformance.instance;

    // Enable collection
    await _crashlytics.setCrashlyticsCollectionEnabled(true);
    await _performance.setPerformanceCollectionEnabled(true);

    // Set up error handling
    FlutterError.onError = (FlutterErrorDetails details) {
      FlutterError.presentError(details);
      _crashlytics.recordFlutterError(details);
    };
  }

  // Analytics methods
  Future<void> logEvent(String name, Map<String, dynamic> parameters) async {
    await _analytics.logEvent(name: name, parameters: parameters);
  }

  Future<void> logScreenView(String screenName) async {
    await _analytics.logScreenView(screenName: screenName);
  }

  Future<void> setUserProperty(String name, String value) async {
    await _analytics.setUserProperty(name: name, value: value);
  }

  // Performance monitoring methods
  Trace startTrace(String name) {
    return _performance.newTrace(name);
  }

  HttpMetric startHttpMetric(String url, HttpMethod method) {
    return _performance.newHttpMetric(url, method);
  }

  // Error reporting methods
  Future<void> recordError(dynamic error, StackTrace stack) async {
    await _crashlytics.recordError(error, stack);
  }

  Future<void> log(String message) async {
    await _crashlytics.log(message);
  }

  Future<void> setCustomKey(String key, dynamic value) async {
    await _crashlytics.setCustomKey(key, value);
  }

  Future<void> setUserIdentifier(String identifier) async {
    await _crashlytics.setUserIdentifier(identifier);
  }
}

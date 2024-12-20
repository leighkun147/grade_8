import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TestHelpers {
  static Widget wrapWithMaterialApp(Widget widget) {
    return MaterialApp(
      home: Scaffold(body: widget),
    );
  }

  static Widget wrapWithProviderScope(Widget widget) {
    return ProviderScope(
      overrides: [],
      child: MaterialApp(
        home: Scaffold(body: widget),
      ),
    );
  }

  static Future<void> loadSharedPreferences() async {
    TestWidgetsFlutterBinding.ensureInitialized();
    SharedPreferences.setMockInitialValues({});
  }
}

class MockNavigatorObserver extends NavigatorObserver {
  List<Route<dynamic>> pushedRoutes = [];
  List<Route<dynamic>> poppedRoutes = [];

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    pushedRoutes.add(route);
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    poppedRoutes.add(route);
  }
}

extension PumpApp on WidgetTester {
  Future<void> pumpWithMaterialApp(Widget widget) {
    return pumpWidget(TestHelpers.wrapWithMaterialApp(widget));
  }

  Future<void> pumpWithProviderScope(Widget widget) {
    return pumpWidget(TestHelpers.wrapWithProviderScope(widget));
  }
}

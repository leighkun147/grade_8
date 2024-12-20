import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import '../../lib/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Performance Tests', () {
    testWidgets('Measure app startup time', (tester) async {
      final stopwatch = Stopwatch()..start();
      
      app.main();
      await tester.pumpAndSettle();
      
      stopwatch.stop();
      debugPrint('App startup time: ${stopwatch.elapsedMilliseconds}ms');
      
      // Startup should be under 2 seconds
      expect(stopwatch.elapsedMilliseconds, lessThan(2000));
    });

    testWidgets('Measure frame build time for quiz list', (tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Navigate to quiz screen
      await tester.tap(find.text('Quizzes'));
      await tester.pumpAndSettle();

      final stopwatch = Stopwatch()..start();
      
      // Simulate scroll
      await tester.fling(
        find.byType(ListView),
        const Offset(0, -500),
        3000,
      );
      await tester.pumpAndSettle();
      
      stopwatch.stop();
      debugPrint('Quiz list scroll time: ${stopwatch.elapsedMilliseconds}ms');
      
      // Scroll should be smooth (under 16ms per frame)
      expect(stopwatch.elapsedMilliseconds / 60, lessThan(16));
    });

    testWidgets('Measure memory usage during navigation', (tester) async {
      app.main();
      await tester.pumpAndSettle();

      final initialMemory = await IntegrationTestWidgetsFlutterBinding
          .instance
          .watchPerformance(() async {
        // Navigate through different screens
        await tester.tap(find.text('Study Materials'));
        await tester.pumpAndSettle();

        await tester.tap(find.text('Profile'));
        await tester.pumpAndSettle();

        await tester.tap(find.text('Quizzes'));
        await tester.pumpAndSettle();
      });

      debugPrint('Performance metrics: ${initialMemory.toString()}');
      
      // Check if memory usage is within acceptable range
      expect(
        initialMemory.memoryInfo?.currentRss,
        lessThan(100 * 1024 * 1024), // 100 MB
      );
    });

    testWidgets('Measure quiz submission performance', (tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Navigate to quiz
      await tester.tap(find.text('Start Quiz'));
      await tester.pumpAndSettle();

      final stopwatch = Stopwatch()..start();

      // Answer all questions
      for (var i = 0; i < 10; i++) {
        await tester.tap(find.byType(RadioListTile).first);
        await tester.tap(find.text('Next'));
        await tester.pumpAndSettle();
      }

      // Submit quiz
      await tester.tap(find.text('Submit'));
      await tester.pumpAndSettle();

      stopwatch.stop();
      debugPrint('Quiz submission time: ${stopwatch.elapsedMilliseconds}ms');

      // Submission should be under 1 second
      expect(stopwatch.elapsedMilliseconds, lessThan(1000));
    });

    testWidgets('Measure study material loading time', (tester) async {
      app.main();
      await tester.pumpAndSettle();

      await tester.tap(find.text('Study Materials'));
      await tester.pumpAndSettle();

      final stopwatch = Stopwatch()..start();

      // Load PDF
      await tester.tap(find.text('Mathematics'));
      await tester.pumpAndSettle();

      stopwatch.stop();
      debugPrint('PDF loading time: ${stopwatch.elapsedMilliseconds}ms');

      // PDF should load under 3 seconds
      expect(stopwatch.elapsedMilliseconds, lessThan(3000));
    });
  });
}

import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_driver/flutter_driver.dart' hide find;
import '../helpers/test_helpers.dart';
import '../../lib/main.dart' as app;

void main() {
  group('Performance Benchmarks', () {
    late FlutterDriver driver;

    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    tearDownAll(() async {
      await driver.close();
    });

    test('App startup time', () async {
      final timeline = await driver.traceAction(() async {
        await app.main();
      });

      final summary = TimelineSummary.summarize(timeline);
      
      // Verify startup performance
      expect(
        summary.frameBuildTime!.inMilliseconds,
        lessThan(1000), // Should start in less than 1 second
      );
      
      // Save timeline
      await summary.writeTimelineToFile(
        'startup_timeline',
        pretty: true,
        includeSummary: true,
      );
    });

    test('Smooth scrolling performance', () async {
      final timeline = await driver.traceAction(() async {
        // Scroll through study materials
        await driver.scroll(
          find.byType('ListView'),
          0,
          -300,
          const Duration(milliseconds: 500),
        );
      });

      final summary = TimelineSummary.summarize(timeline);
      
      // Verify smooth scrolling
      expect(summary.averageFrameBuildTime.inMilliseconds, lessThan(16));
      expect(summary.missed99thPercentileFrames, equals(0));
      
      // Save timeline
      await summary.writeTimelineToFile(
        'scrolling_timeline',
        pretty: true,
        includeSummary: true,
      );
    });

    test('Memory usage during navigation', () async {
      final timeline = await driver.traceAction(() async {
        // Navigate through different screens
        await driver.tap(find.text('Study Materials'));
        await driver.tap(find.text('Quizzes'));
        await driver.tap(find.text('Progress'));
        await driver.tap(find.text('Settings'));
      });

      final summary = TimelineSummary.summarize(timeline);
      
      // Verify memory usage
      expect(summary.maxRss, lessThan(100 * 1024 * 1024)); // Less than 100MB
      
      // Save timeline
      await summary.writeTimelineToFile(
        'navigation_timeline',
        pretty: true,
        includeSummary: true,
      );
    });

    test('Quiz submission performance', () async {
      final timeline = await driver.traceAction(() async {
        // Complete and submit quiz
        await driver.tap(find.text('Start Quiz'));
        for (var i = 0; i < 10; i++) {
          await driver.tap(find.byType('RadioListTile').first);
          await driver.tap(find.text('Next'));
        }
        await driver.tap(find.text('Submit'));
      });

      final summary = TimelineSummary.summarize(timeline);
      
      // Verify submission performance
      expect(
        summary.frameBuildTime!.inMilliseconds,
        lessThan(500), // Should process in less than 500ms
      );
      
      // Save timeline
      await summary.writeTimelineToFile(
        'quiz_submission_timeline',
        pretty: true,
        includeSummary: true,
      );
    });

    test('Study material loading time', () async {
      final timeline = await driver.traceAction(() async {
        // Load PDF study material
        await driver.tap(find.text('Mathematics Chapter 1'));
      });

      final summary = TimelineSummary.summarize(timeline);
      
      // Verify loading performance
      expect(
        summary.frameBuildTime!.inMilliseconds,
        lessThan(2000), // Should load in less than 2 seconds
      );
      
      // Save timeline
      await summary.writeTimelineToFile(
        'material_loading_timeline',
        pretty: true,
        includeSummary: true,
      );
    });

    test('Search performance', () async {
      final timeline = await driver.traceAction(() async {
        // Perform search
        await driver.tap(find.byType('SearchBar'));
        await driver.enterText('algebra equations');
      });

      final summary = TimelineSummary.summarize(timeline);
      
      // Verify search performance
      expect(
        summary.frameBuildTime!.inMilliseconds,
        lessThan(100), // Search should update in less than 100ms
      );
      
      // Save timeline
      await summary.writeTimelineToFile(
        'search_timeline',
        pretty: true,
        includeSummary: true,
      );
    });

    test('Animation smoothness', () async {
      final timeline = await driver.traceAction(() async {
        // Trigger various animations
        await driver.tap(find.text('Start Quiz'));
        await driver.tap(find.text('Submit'));
      });

      final summary = TimelineSummary.summarize(timeline);
      
      // Verify animation smoothness
      expect(summary.averageFrameBuildTime.inMilliseconds, lessThan(16));
      expect(summary.missed99thPercentileFrames, equals(0));
      
      // Save timeline
      await summary.writeTimelineToFile(
        'animation_timeline',
        pretty: true,
        includeSummary: true,
      );
    });

    test('Offline mode performance', () async {
      final timeline = await driver.traceAction(() async {
        // Switch to offline mode and perform actions
        await driver.tap(find.text('Go Offline'));
        await driver.tap(find.text('Study Materials'));
        await driver.scroll(
          find.byType('ListView'),
          0,
          -300,
          const Duration(milliseconds: 500),
        );
      });

      final summary = TimelineSummary.summarize(timeline);
      
      // Verify offline performance
      expect(
        summary.frameBuildTime!.inMilliseconds,
        lessThan(500), // Should be faster in offline mode
      );
      
      // Save timeline
      await summary.writeTimelineToFile(
        'offline_timeline',
        pretty: true,
        includeSummary: true,
      );
    });
  });
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import '../../lib/screens/quiz_screen.dart';
import '../../lib/providers/quiz_provider.dart';
import '../helpers/test_helpers.dart';

void main() {
  group('QuizScreen', () {
    late ProviderContainer container;

    setUp(() {
      container = ProviderContainer();
    });

    tearDown(() {
      container.dispose();
    });

    testWidgets('displays quiz questions correctly', (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          parent: container,
          child: MaterialApp(
            home: QuizScreen(
              quizId: '1',
            ),
          ),
        ),
      );

      // Verify quiz title
      expect(find.text('Question 1'), findsOneWidget);

      // Verify options are displayed
      expect(find.byType(RadioListTile), findsNWidgets(4));

      // Verify navigation buttons
      expect(find.text('Next'), findsOneWidget);
      expect(find.text('Previous'), findsNothing);
    });

    testWidgets('handles answer selection', (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          parent: container,
          child: MaterialApp(
            home: QuizScreen(
              quizId: '1',
            ),
          ),
        ),
      );

      // Select an answer
      await tester.tap(find.byType(RadioListTile).first);
      await tester.pumpAndSettle();

      // Verify answer is selected
      final radioTile = tester.widget<RadioListTile>(
        find.byType(RadioListTile).first,
      );
      expect(radioTile.value, equals(radioTile.groupValue));
    });

    testWidgets('navigates between questions', (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          parent: container,
          child: MaterialApp(
            home: QuizScreen(
              quizId: '1',
            ),
          ),
        ),
      );

      // Go to next question
      await tester.tap(find.text('Next'));
      await tester.pumpAndSettle();

      // Verify on second question
      expect(find.text('Question 2'), findsOneWidget);
      expect(find.text('Previous'), findsOneWidget);

      // Go back to first question
      await tester.tap(find.text('Previous'));
      await tester.pumpAndSettle();

      // Verify back on first question
      expect(find.text('Question 1'), findsOneWidget);
    });

    testWidgets('shows timer', (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          parent: container,
          child: MaterialApp(
            home: QuizScreen(
              quizId: '1',
            ),
          ),
        ),
      );

      // Verify timer is displayed
      expect(find.byType(TimerWidget), findsOneWidget);

      // Wait for timer to update
      await tester.pump(const Duration(seconds: 1));

      // Verify timer updates
      final timerText = find.textContaining(':');
      expect(timerText, findsOneWidget);
    });

    testWidgets('submits quiz', (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          parent: container,
          child: MaterialApp(
            home: QuizScreen(
              quizId: '1',
            ),
          ),
        ),
      );

      // Answer all questions
      for (var i = 0; i < 10; i++) {
        await tester.tap(find.byType(RadioListTile).first);
        await tester.tap(find.text('Next'));
        await tester.pumpAndSettle();
      }

      // Submit quiz
      await tester.tap(find.text('Submit'));
      await tester.pumpAndSettle();

      // Verify results are shown
      expect(find.text('Quiz Results'), findsOneWidget);
      expect(find.byType(ResultsChart), findsOneWidget);
    });

    testWidgets('handles time up', (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          parent: container,
          child: MaterialApp(
            home: QuizScreen(
              quizId: '1',
            ),
          ),
        ),
      );

      // Fast forward timer
      await tester.pump(const Duration(minutes: 30));

      // Verify time up dialog
      expect(find.text('Time Up!'), findsOneWidget);
      expect(find.text('Submit Quiz'), findsOneWidget);
    });

    testWidgets('shows correct answer explanations', (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          parent: container,
          child: MaterialApp(
            home: QuizScreen(
              quizId: '1',
              showExplanations: true,
            ),
          ),
        ),
      );

      // Select wrong answer
      await tester.tap(find.byType(RadioListTile).last);
      await tester.pumpAndSettle();

      // Verify explanation is shown
      expect(find.byType(ExplanationCard), findsOneWidget);
      expect(find.text('Explanation:'), findsOneWidget);
    });
  });
}

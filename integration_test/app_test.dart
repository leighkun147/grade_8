import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import '../lib/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('end-to-end test', () {
    testWidgets('verify onboarding flow', (tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Verify splash screen is shown
      expect(find.text('Grade 8 National Exam Prep'), findsOneWidget);

      // Wait for splash screen animation
      await Future.delayed(const Duration(seconds: 2));
      await tester.pumpAndSettle();

      // Verify navigation to home screen
      expect(find.text('Welcome'), findsOneWidget);
    });

    testWidgets('verify quiz flow', (tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Navigate to quiz screen
      await tester.tap(find.text('Start Quiz'));
      await tester.pumpAndSettle();

      // Verify quiz screen elements
      expect(find.text('Question 1'), findsOneWidget);
      expect(find.byType(RadioListTile), findsNWidgets(4));

      // Select an answer
      await tester.tap(find.byType(RadioListTile).first);
      await tester.pumpAndSettle();

      // Tap next button
      await tester.tap(find.text('Next'));
      await tester.pumpAndSettle();

      // Verify moving to next question
      expect(find.text('Question 2'), findsOneWidget);
    });

    testWidgets('verify study materials flow', (tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Navigate to study materials
      await tester.tap(find.text('Study Materials'));
      await tester.pumpAndSettle();

      // Verify study materials screen elements
      expect(find.text('Mathematics'), findsOneWidget);
      expect(find.text('Science'), findsOneWidget);

      // Tap on a subject
      await tester.tap(find.text('Mathematics'));
      await tester.pumpAndSettle();

      // Verify subject materials are shown
      expect(find.text('Algebra'), findsOneWidget);
    });

    testWidgets('verify profile flow', (tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Navigate to profile
      await tester.tap(find.byIcon(Icons.person));
      await tester.pumpAndSettle();

      // Verify profile screen elements
      expect(find.text('Profile'), findsOneWidget);
      expect(find.text('Settings'), findsOneWidget);

      // Tap settings
      await tester.tap(find.text('Settings'));
      await tester.pumpAndSettle();

      // Verify settings screen
      expect(find.text('Dark Mode'), findsOneWidget);
      expect(find.text('Notifications'), findsOneWidget);

      // Toggle dark mode
      await tester.tap(find.byType(Switch).first);
      await tester.pumpAndSettle();

      // Verify theme change
      final switch1 = tester.widget<Switch>(find.byType(Switch).first);
      expect(switch1.value, isTrue);
    });
  });
}

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import '../../lib/widgets/animated_list_item.dart';
import '../helpers/test_helpers.dart';

void main() {
  group('AnimatedListItem', () {
    testWidgets('renders child widget', (tester) async {
      const childKey = Key('child');
      const child = Text('Test Child', key: childKey);

      await tester.pumpWithMaterialApp(
        const AnimatedListItem(
          child: child,
          index: 0,
        ),
      );

      expect(find.byKey(childKey), findsOneWidget);
    });

    testWidgets('animates when shown', (tester) async {
      await tester.pumpWithMaterialApp(
        const AnimatedListItem(
          child: Text('Test'),
          index: 0,
        ),
      );

      final initialOpacity = tester.widget<FadeTransition>(
        find.byType(FadeTransition),
      ).opacity.value;

      await tester.pump(const Duration(milliseconds: 200));

      final animatedOpacity = tester.widget<FadeTransition>(
        find.byType(FadeTransition),
      ).opacity.value;

      expect(initialOpacity, isNot(equals(animatedOpacity)));
    });

    testWidgets('respects delay based on index', (tester) async {
      await tester.pumpWithMaterialApp(
        const AnimatedListItem(
          child: Text('Test'),
          index: 2,
          delay: Duration(milliseconds: 100),
        ),
      );

      final initialOpacity = tester.widget<FadeTransition>(
        find.byType(FadeTransition),
      ).opacity.value;

      // Wait for delay (index * delay)
      await tester.pump(const Duration(milliseconds: 200));

      final delayedOpacity = tester.widget<FadeTransition>(
        find.byType(FadeTransition),
      ).opacity.value;

      expect(initialOpacity, isNot(equals(delayedOpacity)));
    });

    testWidgets('no animation when animate is false', (tester) async {
      await tester.pumpWithMaterialApp(
        const AnimatedListItem(
          child: Text('Test'),
          index: 0,
          animate: false,
        ),
      );

      final initialOpacity = tester.widget<FadeTransition>(
        find.byType(FadeTransition),
      ).opacity.value;

      await tester.pump(const Duration(milliseconds: 200));

      final finalOpacity = tester.widget<FadeTransition>(
        find.byType(FadeTransition),
      ).opacity.value;

      expect(initialOpacity, equals(finalOpacity));
      expect(initialOpacity, equals(1.0));
    });
  });
}

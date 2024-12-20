import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import '../../lib/widgets/animated_card.dart';
import '../helpers/test_helpers.dart';

void main() {
  group('AnimatedCard', () {
    testWidgets('renders child widget', (tester) async {
      const childKey = Key('child');
      const child = Text('Test Child', key: childKey);

      await tester.pumpWithMaterialApp(
        const AnimatedCard(child: child),
      );

      expect(find.byKey(childKey), findsOneWidget);
    });

    testWidgets('responds to tap', (tester) async {
      var tapped = false;
      await tester.pumpWithMaterialApp(
        AnimatedCard(
          onTap: () => tapped = true,
          child: const Text('Test'),
        ),
      );

      await tester.tap(find.byType(AnimatedCard));
      await tester.pumpAndSettle();

      expect(tapped, isTrue);
    });

    testWidgets('animates on tap', (tester) async {
      await tester.pumpWithMaterialApp(
        AnimatedCard(
          onTap: () {},
          child: const Text('Test'),
        ),
      );

      final initialTransform = tester.widget<Transform>(
        find.byType(Transform).first,
      );

      await tester.tap(find.byType(AnimatedCard));
      await tester.pump(const Duration(milliseconds: 100));

      final animatedTransform = tester.widget<Transform>(
        find.byType(Transform).first,
      );

      expect(
        initialTransform.transform.getMaxScaleOnAxis(),
        isNot(equals(animatedTransform.transform.getMaxScaleOnAxis())),
      );
    });

    testWidgets('applies custom border radius', (tester) async {
      const borderRadius = BorderRadius.all(Radius.circular(20));

      await tester.pumpWithMaterialApp(
        const AnimatedCard(
          borderRadius: borderRadius,
          child: Text('Test'),
        ),
      );

      final container = tester.widget<Container>(
        find.descendant(
          of: find.byType(AnimatedCard),
          matching: find.byType(Container),
        ),
      );

      expect(
        (container.decoration as BoxDecoration).borderRadius,
        equals(borderRadius),
      );
    });

    testWidgets('applies custom color', (tester) async {
      const color = Colors.red;

      await tester.pumpWithMaterialApp(
        const AnimatedCard(
          color: color,
          child: Text('Test'),
        ),
      );

      final container = tester.widget<Container>(
        find.descendant(
          of: find.byType(AnimatedCard),
          matching: find.byType(Container),
        ),
      );

      expect(
        (container.decoration as BoxDecoration).color,
        equals(color),
      );
    });
  });
}

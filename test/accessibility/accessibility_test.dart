import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import '../../lib/main.dart' as app;

void main() {
  group('Accessibility Tests', () {
    testWidgets('Home screen meets accessibility guidelines', (tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Check for sufficient contrast
      final texts = tester.widgetList<Text>(find.byType(Text));
      for (final text in texts) {
        final textStyle = text.style ?? const TextStyle();
        if (textStyle.color != null) {
          final backgroundColor = Theme.of(tester.element(find.byType(MaterialApp)))
              .scaffoldBackgroundColor;
          
          // Calculate contrast ratio (simplified)
          final contrast = _calculateContrastRatio(
            textStyle.color!,
            backgroundColor,
          );
          
          expect(
            contrast,
            greaterThanOrEqualTo(4.5), // WCAG AA standard for normal text
            reason: 'Text "${text.data}" has insufficient contrast',
          );
        }
      }

      // Check for minimum tap target size
      final tapTargets = tester.widgetList<GestureDetector>(
        find.byType(GestureDetector),
      );
      for (final target in tapTargets) {
        final size = tester.getSize(find.byWidget(target));
        expect(
          size.width,
          greaterThanOrEqualTo(48.0),
          reason: 'Tap target width is too small',
        );
        expect(
          size.height,
          greaterThanOrEqualTo(48.0),
          reason: 'Tap target height is too small',
        );
      }

      // Check for semantic labels
      final semantics = tester.widgetList<Semantics>(find.byType(Semantics));
      for (final semantic in semantics) {
        if (semantic.properties.label != null) {
          expect(
            semantic.properties.label!.isNotEmpty,
            isTrue,
            reason: 'Empty semantic label found',
          );
        }
      }
    });

    testWidgets('Quiz screen is accessible', (tester) async {
      app.main();
      await tester.pumpAndSettle();

      await tester.tap(find.text('Start Quiz'));
      await tester.pumpAndSettle();

      // Check for proper heading hierarchy
      final headings = tester.widgetList<Text>(find.byType(Text));
      var foundH1 = false;
      for (final heading in headings) {
        final style = heading.style;
        if (style?.fontSize != null && style!.fontSize! >= 24) {
          foundH1 = true;
          break;
        }
      }
      expect(foundH1, isTrue, reason: 'No main heading found');

      // Check radio buttons accessibility
      final radioButtons = tester.widgetList<RadioListTile>(
        find.byType(RadioListTile),
      );
      for (final radio in radioButtons) {
        expect(
          radio.groupValue != null,
          isTrue,
          reason: 'Radio button missing group value',
        );
      }
    });

    testWidgets('Navigation is keyboard accessible', (tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Simulate tab navigation
      await tester.sendKeyEvent(LogicalKeyboardKey.tab);
      await tester.pumpAndSettle();

      // Verify focus indicator is visible
      final focus = find.byType(Focus);
      expect(focus, findsWidgets);

      // Check if all interactive elements are focusable
      final interactiveElements = [
        ...tester.widgetList<ElevatedButton>(find.byType(ElevatedButton)),
        ...tester.widgetList<TextButton>(find.byType(TextButton)),
        ...tester.widgetList<IconButton>(find.byType(IconButton)),
      ];

      for (final element in interactiveElements) {
        expect(
          element.focusNode != null || element.autofocus == true,
          isTrue,
          reason: 'Interactive element not focusable',
        );
      }
    });
  });
}

double _calculateContrastRatio(Color foreground, Color background) {
  double luminance1 = foreground.computeLuminance();
  double luminance2 = background.computeLuminance();
  
  double brightest = luminance1 > luminance2 ? luminance1 : luminance2;
  double darkest = luminance1 > luminance2 ? luminance2 : luminance1;
  
  return (brightest + 0.05) / (darkest + 0.05);
}

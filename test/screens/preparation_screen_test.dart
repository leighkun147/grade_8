import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import '../../lib/screens/preparation_screen.dart';
import '../../lib/providers/study_materials_provider.dart';
import '../helpers/test_helpers.dart';

void main() {
  group('PreparationScreen', () {
    late ProviderContainer container;

    setUp(() {
      container = ProviderContainer();
    });

    tearDown(() {
      container.dispose();
    });

    testWidgets('displays study materials correctly', (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          parent: container,
          child: const MaterialApp(
            home: PreparationScreen(),
          ),
        ),
      );

      // Verify subject filters
      expect(find.text('Mathematics'), findsOneWidget);
      expect(find.text('Science'), findsOneWidget);
      expect(find.text('English'), findsOneWidget);

      // Verify material types
      expect(find.text('PDFs'), findsOneWidget);
      expect(find.text('Videos'), findsOneWidget);
      expect(find.text('Practice Sets'), findsOneWidget);
    });

    testWidgets('filters materials by subject', (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          parent: container,
          child: const MaterialApp(
            home: PreparationScreen(),
          ),
        ),
      );

      // Select Mathematics
      await tester.tap(find.text('Mathematics'));
      await tester.pumpAndSettle();

      // Verify filtered materials
      expect(find.text('Mathematics Chapter 1'), findsOneWidget);
      expect(find.text('Science Chapter 1'), findsNothing);
    });

    testWidgets('filters materials by type', (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          parent: container,
          child: const MaterialApp(
            home: PreparationScreen(),
          ),
        ),
      );

      // Select PDFs
      await tester.tap(find.text('PDFs'));
      await tester.pumpAndSettle();

      // Verify filtered materials
      expect(find.byType(PDFListItem), findsWidgets);
      expect(find.byType(VideoListItem), findsNothing);
    });

    testWidgets('handles material download', (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          parent: container,
          child: const MaterialApp(
            home: PreparationScreen(),
          ),
        ),
      );

      // Find download button
      final downloadButton = find.byIcon(Icons.download);
      expect(downloadButton, findsWidgets);

      // Tap download
      await tester.tap(downloadButton.first);
      await tester.pumpAndSettle();

      // Verify download started
      expect(find.byType(DownloadProgressIndicator), findsOneWidget);
    });

    testWidgets('shows search results', (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          parent: container,
          child: const MaterialApp(
            home: PreparationScreen(),
          ),
        ),
      );

      // Open search
      await tester.tap(find.byIcon(Icons.search));
      await tester.pumpAndSettle();

      // Enter search query
      await tester.enterText(find.byType(TextField), 'algebra');
      await tester.pumpAndSettle();

      // Verify search results
      expect(find.text('Basic Algebra'), findsOneWidget);
      expect(find.text('Advanced Algebra'), findsOneWidget);
    });

    testWidgets('handles offline mode', (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          parent: container,
          child: const MaterialApp(
            home: PreparationScreen(isOffline: true),
          ),
        ),
      );

      // Verify offline indicator
      expect(find.text('Offline Mode'), findsOneWidget);

      // Verify only downloaded materials shown
      expect(find.byIcon(Icons.download_done), findsWidgets);
      expect(find.byIcon(Icons.download), findsNothing);
    });

    testWidgets('shows progress tracking', (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          parent: container,
          child: const MaterialApp(
            home: PreparationScreen(),
          ),
        ),
      );

      // Open progress section
      await tester.tap(find.text('Progress'));
      await tester.pumpAndSettle();

      // Verify progress elements
      expect(find.byType(ProgressChart), findsOneWidget);
      expect(find.byType(SubjectProgressCard), findsWidgets);
    });

    testWidgets('handles material bookmarking', (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          parent: container,
          child: const MaterialApp(
            home: PreparationScreen(),
          ),
        ),
      );

      // Find bookmark button
      final bookmarkButton = find.byIcon(Icons.bookmark_border);
      expect(bookmarkButton, findsWidgets);

      // Tap bookmark
      await tester.tap(bookmarkButton.first);
      await tester.pumpAndSettle();

      // Verify bookmark added
      expect(find.byIcon(Icons.bookmark), findsOneWidget);
    });

    testWidgets('shows material details', (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          parent: container,
          child: const MaterialApp(
            home: PreparationScreen(),
          ),
        ),
      );

      // Tap material item
      await tester.tap(find.byType(MaterialListItem).first);
      await tester.pumpAndSettle();

      // Verify details screen
      expect(find.byType(MaterialDetailsScreen), findsOneWidget);
      expect(find.text('Description'), findsOneWidget);
      expect(find.text('Related Materials'), findsOneWidget);
    });
  });
}

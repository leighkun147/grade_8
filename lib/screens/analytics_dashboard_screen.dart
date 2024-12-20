import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/analytics_provider.dart';
import '../widgets/performance_chart.dart';
import '../widgets/subject_progress_card.dart';

class AnalyticsDashboardScreen extends ConsumerWidget {
  const AnalyticsDashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final analytics = ref.watch(analyticsProvider);
    analytics.logScreenView('Analytics Dashboard');

    return Scaffold(
      appBar: AppBar(
        title: const Text('Analytics Dashboard'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Performance Overview',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 16),
            const PerformanceChart(
              scores: [85, 90, 75, 95, 80, 85],
              labels: ['Math', 'Eng', 'Geo', 'His', 'Bio', 'Phy'],
            ),
            const SizedBox(height: 32),
            Text(
              'Subject Progress',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 16),
            const SubjectProgressCard(
              subject: 'Mathematics',
              progress: 0.75,
              questionsCompleted: 150,
              totalQuestions: 200,
            ),
            const SizedBox(height: 16),
            const SubjectProgressCard(
              subject: 'English',
              progress: 0.60,
              questionsCompleted: 120,
              totalQuestions: 200,
            ),
            const SizedBox(height: 16),
            const SubjectProgressCard(
              subject: 'Geography',
              progress: 0.45,
              questionsCompleted: 90,
              totalQuestions: 200,
            ),
          ],
        ),
      ),
    );
  }
}

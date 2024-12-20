import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'subject_service.dart';

class RecommendationService {
  final SubjectService _subjectService;

  RecommendationService(this._subjectService);

  // Generate personalized study recommendations
  List<StudyRecommendation> getRecommendations({
    required Map<String, Map<String, double>> subjectScores,
    required Map<String, int> studyTime,
    required int daysUntilExam,
  }) {
    final recommendations = <StudyRecommendation>[];

    // Analyze each subject
    for (var subject in subjectScores.keys) {
      final topicScores = subjectScores[subject]!;
      final timeSpent = studyTime[subject] ?? 0;

      // Get weak topics
      final weakTopics = _subjectService.getTopicRecommendations(
        subject: subject,
        topicScores: topicScores,
      );

      // Generate study plan
      final studyPlan = _subjectService.generateStudyPlan(
        subject: subject,
        daysUntilExam: daysUntilExam,
        topicScores: topicScores,
      );

      // Add topic-specific recommendations
      for (var topic in weakTopics) {
        recommendations.add(
          StudyRecommendation(
            title: 'Focus on $topic in $subject',
            description: _generateTopicRecommendation(
              subject: subject,
              topic: topic,
              score: topicScores[topic] ?? 0.0,
            ),
            priority: _calculatePriority(
              score: topicScores[topic] ?? 0.0,
              daysUntilExam: daysUntilExam,
              isPrerequisite: _isPrerequisite(topic),
            ),
            resources: _getTopicResources(subject, topic),
            estimatedTime: _estimateStudyTime(
              topic: topic,
              score: topicScores[topic] ?? 0.0,
            ),
          ),
        );
      }

      // Add time management recommendations
      if (timeSpent < _getRecommendedTime(subject)) {
        recommendations.add(
          StudyRecommendation(
            title: 'Increase study time for $subject',
            description: 'You should spend more time on $subject to improve your performance.',
            priority: Priority.medium,
            resources: _getTimeManagementResources(),
            estimatedTime: _getRecommendedTime(subject) - timeSpent,
          ),
        );
      }

      // Add exam preparation recommendations
      if (daysUntilExam <= 30) {
        recommendations.add(
          StudyRecommendation(
            title: 'Exam Preparation for $subject',
            description: _generateExamPreparationTips(subject),
            priority: Priority.high,
            resources: _getExamPrepResources(subject),
            estimatedTime: 120, // 2 hours
          ),
        );
      }
    }

    // Sort recommendations by priority
    recommendations.sort((a, b) => b.priority.index.compareTo(a.priority.index));

    return recommendations;
  }

  // Generate topic-specific recommendation
  String _generateTopicRecommendation({
    required String subject,
    required String topic,
    required double score,
  }) {
    final techniques = _subjectService.getStudyTechniques(subject);
    final mistakes = _subjectService.getCommonMistakes(subject);
    final tools = _subjectService.getInteractiveTools(subject);

    return '''
Focus on improving your understanding of $topic in $subject.
Recommended study techniques:
${techniques.map((t) => '- $t').join('\n')}

Common mistakes to avoid:
${mistakes.entries.map((e) => '- ${e.key}: ${e.value}').join('\n')}

Helpful tools:
${tools.map((t) => '- $t').join('\n')}
''';
  }

  // Calculate recommendation priority
  Priority _calculatePriority({
    required double score,
    required int daysUntilExam,
    required bool isPrerequisite,
  }) {
    if (score < 0.5 || isPrerequisite) {
      return Priority.high;
    } else if (score < 0.7 || daysUntilExam <= 30) {
      return Priority.medium;
    } else {
      return Priority.low;
    }
  }

  // Check if topic is a prerequisite
  bool _isPrerequisite(String topic) {
    return _subjectService.prerequisites.containsKey(topic);
  }

  // Get topic-specific resources
  List<StudyResource> _getTopicResources(String subject, String topic) {
    return [
      StudyResource(
        title: '$topic Study Guide',
        type: ResourceType.document,
        url: 'path/to/study/guide',
      ),
      StudyResource(
        title: '$topic Video Tutorial',
        type: ResourceType.video,
        url: 'path/to/video',
      ),
      StudyResource(
        title: '$topic Practice Questions',
        type: ResourceType.quiz,
        url: 'path/to/quiz',
      ),
    ];
  }

  // Estimate study time needed (in minutes)
  int _estimateStudyTime({
    required String topic,
    required double score,
  }) {
    if (score < 0.5) {
      return 120; // 2 hours
    } else if (score < 0.7) {
      return 90; // 1.5 hours
    } else {
      return 60; // 1 hour
    }
  }

  // Get recommended study time per subject (in minutes)
  int _getRecommendedTime(String subject) {
    switch (subject) {
      case 'Mathematics':
      case 'Science':
        return 180; // 3 hours
      case 'English':
      case 'Amharic':
        return 120; // 2 hours
      default:
        return 90; // 1.5 hours
    }
  }

  // Get time management resources
  List<StudyResource> _getTimeManagementResources() {
    return [
      StudyResource(
        title: 'Time Management Tips',
        type: ResourceType.document,
        url: 'path/to/tips',
      ),
      StudyResource(
        title: 'Study Schedule Template',
        type: ResourceType.document,
        url: 'path/to/template',
      ),
    ];
  }

  // Generate exam preparation tips
  String _generateExamPreparationTips(String subject) {
    return '''
Exam Preparation Tips for $subject:
1. Review past exam questions
2. Practice time management
3. Focus on weak areas
4. Take mock exams
5. Review common mistakes
''';
  }

  // Get exam preparation resources
  List<StudyResource> _getExamPrepResources(String subject) {
    return [
      StudyResource(
        title: 'Past Exam Papers',
        type: ResourceType.document,
        url: 'path/to/papers',
      ),
      StudyResource(
        title: 'Exam Techniques',
        type: ResourceType.video,
        url: 'path/to/techniques',
      ),
      StudyResource(
        title: 'Mock Exam',
        type: ResourceType.quiz,
        url: 'path/to/mock',
      ),
    ];
  }
}

// Enums and Classes
enum Priority { low, medium, high }

enum ResourceType { document, video, quiz, interactive }

class StudyRecommendation {
  final String title;
  final String description;
  final Priority priority;
  final List<StudyResource> resources;
  final int estimatedTime;

  StudyRecommendation({
    required this.title,
    required this.description,
    required this.priority,
    required this.resources,
    required this.estimatedTime,
  });
}

class StudyResource {
  final String title;
  final ResourceType type;
  final String url;

  StudyResource({
    required this.title,
    required this.type,
    required this.url,
  });
}

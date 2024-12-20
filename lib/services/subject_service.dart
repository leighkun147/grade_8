import 'package:flutter_riverpod/flutter_riverpod.dart';

class SubjectService {
  // Subject-specific learning paths
  static const Map<String, List<String>> learningPaths = {
    'Mathematics': [
      'Numbers and Operations',
      'Algebra',
      'Geometry',
      'Data Analysis',
      'Problem Solving',
    ],
    'Science': [
      'Physics',
      'Chemistry',
      'Biology',
      'Scientific Method',
      'Lab Experiments',
    ],
    'English': [
      'Grammar',
      'Reading Comprehension',
      'Writing',
      'Vocabulary',
      'Literature',
    ],
    'Amharic': [
      'Grammar',
      'Literature',
      'Writing',
      'Reading',
      'Poetry',
    ],
    'Social Studies': [
      'History',
      'Geography',
      'Civics',
      'Economics',
      'Current Events',
    ],
  };

  // Difficulty levels for each topic
  static const Map<String, List<String>> difficultyLevels = {
    'Beginner': ['Basic Concepts', 'Fundamentals', 'Introduction'],
    'Intermediate': ['Practice Problems', 'Applications', 'Examples'],
    'Advanced': ['Complex Problems', 'Past Exam Questions', 'Challenges'],
  };

  // Interactive elements for each subject
  static const Map<String, List<String>> interactiveElements = {
    'Mathematics': [
      'Interactive Graphs',
      'Geometry Tools',
      'Calculator',
      'Formula Sheet',
    ],
    'Science': [
      'Virtual Lab',
      'Periodic Table',
      'Experiment Simulator',
      'Science Calculator',
    ],
    'English': [
      'Dictionary',
      'Grammar Checker',
      'Writing Assistant',
      'Pronunciation Guide',
    ],
  };

  // Study techniques for each subject
  static const Map<String, List<String>> studyTechniques = {
    'Mathematics': [
      'Practice Problems',
      'Step-by-Step Solutions',
      'Formula Memorization',
      'Visual Learning',
    ],
    'Science': [
      'Concept Mapping',
      'Lab Experiments',
      'Visual Aids',
      'Real-world Applications',
    ],
    'English': [
      'Reading Aloud',
      'Writing Practice',
      'Vocabulary Building',
      'Group Discussions',
    ],
  };

  // Common mistakes and solutions
  static const Map<String, Map<String, String>> commonMistakes = {
    'Mathematics': {
      'Sign Errors': 'Double-check signs in equations',
      'Order of Operations': 'Remember PEMDAS',
      'Formula Application': 'Verify formula prerequisites',
    },
    'Science': {
      'Unit Conversion': 'Use conversion charts',
      'Chemical Equations': 'Balance equations first',
      'Graph Interpretation': 'Check axis labels',
    },
    'English': {
      'Subject-Verb Agreement': 'Match subject with verb',
      'Tense Consistency': 'Maintain same tense',
      'Article Usage': 'Review article rules',
    },
  };

  // Topic prerequisites
  static const Map<String, List<String>> prerequisites = {
    'Algebra': ['Basic Operations', 'Number Properties'],
    'Geometry': ['Basic Algebra', 'Angle Properties'],
    'Chemistry': ['Basic Math', 'Scientific Notation'],
    'Physics': ['Basic Math', 'Units and Measurement'],
    'Grammar': ['Parts of Speech', 'Sentence Structure'],
  };

  // Get recommended study order
  List<String> getStudyOrder(String subject, String topic) {
    final order = <String>[];
    final prereqs = prerequisites[topic] ?? [];
    order.addAll(prereqs);
    order.add(topic);
    return order;
  }

  // Get interactive tools
  List<String> getInteractiveTools(String subject) {
    return interactiveElements[subject] ?? [];
  }

  // Get study techniques
  List<String> getStudyTechniques(String subject) {
    return studyTechniques[subject] ?? [];
  }

  // Get common mistakes
  Map<String, String> getCommonMistakes(String subject) {
    return commonMistakes[subject] ?? {};
  }

  // Get difficulty level
  String getDifficultyLevel(String topic) {
    for (var level in difficultyLevels.keys) {
      if (difficultyLevels[level]!.any((t) => topic.contains(t))) {
        return level;
      }
    }
    return 'Intermediate';
  }

  // Get learning path
  List<String> getLearningPath(String subject) {
    return learningPaths[subject] ?? [];
  }

  // Generate study plan
  Map<String, dynamic> generateStudyPlan({
    required String subject,
    required int daysUntilExam,
    required Map<String, double> topicScores,
  }) {
    final topics = learningPaths[subject] ?? [];
    final plan = <String, dynamic>{};
    
    // Allocate days based on topic difficulty and current scores
    for (var topic in topics) {
      final score = topicScores[topic] ?? 0.0;
      final difficulty = getDifficultyLevel(topic);
      
      // Calculate days needed based on score and difficulty
      int daysNeeded;
      switch (difficulty) {
        case 'Beginner':
          daysNeeded = score < 0.7 ? 3 : 1;
          break;
        case 'Intermediate':
          daysNeeded = score < 0.7 ? 4 : 2;
          break;
        case 'Advanced':
          daysNeeded = score < 0.7 ? 5 : 3;
          break;
        default:
          daysNeeded = 2;
      }
      
      plan[topic] = {
        'days': daysNeeded,
        'techniques': getStudyTechniques(subject),
        'mistakes': getCommonMistakes(subject),
        'tools': getInteractiveTools(subject),
      };
    }
    
    return plan;
  }

  // Get topic recommendations
  List<String> getTopicRecommendations({
    required String subject,
    required Map<String, double> topicScores,
  }) {
    final recommendations = <String>[];
    final topics = learningPaths[subject] ?? [];
    
    // Find weak topics
    for (var topic in topics) {
      final score = topicScores[topic] ?? 0.0;
      if (score < 0.7) {
        recommendations.add(topic);
      }
    }
    
    // Sort by prerequisite order
    recommendations.sort((a, b) {
      final aPrereqs = prerequisites[a]?.length ?? 0;
      final bPrereqs = prerequisites[b]?.length ?? 0;
      return aPrereqs.compareTo(bPrereqs);
    });
    
    return recommendations;
  }
}

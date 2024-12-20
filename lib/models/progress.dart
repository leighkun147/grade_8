class Progress {
  final String userId;
  final Map<String, SubjectProgress> subjects;
  final List<QuizAttempt> quizHistory;
  final int totalStudyTime; // in minutes
  final int streakDays;
  final DateTime lastStudyDate;

  Progress({
    required this.userId,
    required this.subjects,
    required this.quizHistory,
    required this.totalStudyTime,
    required this.streakDays,
    required this.lastStudyDate,
  });

  factory Progress.fromJson(Map<String, dynamic> json) {
    return Progress(
      userId: json['userId'] as String,
      subjects: Map<String, SubjectProgress>.from(
        json['subjects'].map(
          (key, value) => MapEntry(key, SubjectProgress.fromJson(value)),
        ),
      ),
      quizHistory: (json['quizHistory'] as List)
          .map((q) => QuizAttempt.fromJson(q))
          .toList(),
      totalStudyTime: json['totalStudyTime'] as int,
      streakDays: json['streakDays'] as int,
      lastStudyDate: DateTime.parse(json['lastStudyDate'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'subjects': subjects.map((key, value) => MapEntry(key, value.toJson())),
      'quizHistory': quizHistory.map((q) => q.toJson()).toList(),
      'totalStudyTime': totalStudyTime,
      'streakDays': streakDays,
      'lastStudyDate': lastStudyDate.toIso8601String(),
    };
  }
}

class SubjectProgress {
  final String subject;
  final double completionPercentage;
  final int questionsAttempted;
  final int questionsCorrect;
  final List<String> completedTopics;
  final List<String> strugglingTopics;

  SubjectProgress({
    required this.subject,
    required this.completionPercentage,
    required this.questionsAttempted,
    required this.questionsCorrect,
    required this.completedTopics,
    required this.strugglingTopics,
  });

  factory SubjectProgress.fromJson(Map<String, dynamic> json) {
    return SubjectProgress(
      subject: json['subject'] as String,
      completionPercentage: json['completionPercentage'] as double,
      questionsAttempted: json['questionsAttempted'] as int,
      questionsCorrect: json['questionsCorrect'] as int,
      completedTopics: List<String>.from(json['completedTopics']),
      strugglingTopics: List<String>.from(json['strugglingTopics']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'subject': subject,
      'completionPercentage': completionPercentage,
      'questionsAttempted': questionsAttempted,
      'questionsCorrect': questionsCorrect,
      'completedTopics': completedTopics,
      'strugglingTopics': strugglingTopics,
    };
  }
}

class QuizAttempt {
  final String quizId;
  final DateTime attemptDate;
  final int score;
  final Duration timeTaken;
  final List<int> answeredOptions;
  final bool completed;

  QuizAttempt({
    required this.quizId,
    required this.attemptDate,
    required this.score,
    required this.timeTaken,
    required this.answeredOptions,
    required this.completed,
  });

  factory QuizAttempt.fromJson(Map<String, dynamic> json) {
    return QuizAttempt(
      quizId: json['quizId'] as String,
      attemptDate: DateTime.parse(json['attemptDate'] as String),
      score: json['score'] as int,
      timeTaken: Duration(seconds: json['timeTaken'] as int),
      answeredOptions: List<int>.from(json['answeredOptions']),
      completed: json['completed'] as bool,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'quizId': quizId,
      'attemptDate': attemptDate.toIso8601String(),
      'score': score,
      'timeTaken': timeTaken.inSeconds,
      'answeredOptions': answeredOptions,
      'completed': completed,
    };
  }
}

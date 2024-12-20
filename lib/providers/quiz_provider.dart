import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/quiz.dart';

final quizProvider = StateNotifierProvider<QuizNotifier, List<Quiz>>((ref) {
  return QuizNotifier();
});

final activeQuizProvider = StateNotifierProvider<ActiveQuizNotifier, Quiz?>((ref) {
  return ActiveQuizNotifier();
});

class QuizNotifier extends StateNotifier<List<Quiz>> {
  QuizNotifier() : super([]) {
    _loadQuizzes();
  }

  Future<void> _loadQuizzes() async {
    // TODO: Load quizzes from local storage or API
    state = _getMockQuizzes();
  }

  List<Quiz> _getMockQuizzes() {
    return [
      Quiz(
        id: '1',
        subject: 'Mathematics',
        title: 'Algebra Practice Quiz',
        description: 'Test your algebra skills',
        questions: [
          Question(
            id: '1',
            text: 'Solve for x: 2x + 5 = 13',
            options: ['x = 4', 'x = 6', 'x = 8', 'x = 3'],
            correctOption: 0,
            explanation: 'Subtract 5 from both sides: 2x = 8\nDivide both sides by 2: x = 4',
          ),
          // Add more questions...
        ],
        timeLimit: 30,
        type: QuizType.practice,
        coins: 100,
        year: '2024',
      ),
      // Add more quizzes...
    ];
  }

  void addQuiz(Quiz quiz) {
    state = [...state, quiz];
  }

  void removeQuiz(String quizId) {
    state = state.where((quiz) => quiz.id != quizId).toList();
  }

  List<Quiz> getQuizzesBySubject(String subject) {
    return state.where((quiz) => quiz.subject == subject).toList();
  }

  List<Quiz> getQuizzesByType(QuizType type) {
    return state.where((quiz) => quiz.type == type).toList();
  }
}

class ActiveQuizNotifier extends StateNotifier<Quiz?> {
  ActiveQuizNotifier() : super(null);

  void startQuiz(Quiz quiz) {
    state = quiz;
  }

  void endQuiz() {
    state = null;
  }
}

// Provider for quiz progress
final quizProgressProvider =
    StateNotifierProvider<QuizProgressNotifier, Map<String, List<int>>>((ref) {
  return QuizProgressNotifier();
});

class QuizProgressNotifier extends StateNotifier<Map<String, List<int>>> {
  QuizProgressNotifier() : super({});

  void saveAnswer(String quizId, int questionIndex, int answer) {
    final answers = state[quizId] ?? List.filled(20, -1); // Default size
    answers[questionIndex] = answer;
    state = {...state, quizId: answers};
  }

  void clearAnswers(String quizId) {
    final newState = Map<String, List<int>>.from(state);
    newState.remove(quizId);
    state = newState;
  }

  List<int> getAnswers(String quizId) {
    return state[quizId] ?? [];
  }
}

// Provider for quiz statistics
final quizStatsProvider =
    StateNotifierProvider<QuizStatsNotifier, Map<String, Map<String, dynamic>>>(
        (ref) {
  return QuizStatsNotifier();
});

class QuizStatsNotifier extends StateNotifier<Map<String, Map<String, dynamic>>> {
  QuizStatsNotifier() : super({});

  void updateStats(String quizId, {
    required int score,
    required Duration timeTaken,
    required int totalQuestions,
  }) {
    final stats = {
      'score': score,
      'timeTaken': timeTaken.inSeconds,
      'totalQuestions': totalQuestions,
      'completedAt': DateTime.now().toIso8601String(),
    };
    state = {...state, quizId: stats};
  }

  Map<String, dynamic>? getStats(String quizId) {
    return state[quizId];
  }

  double getAverageScore() {
    if (state.isEmpty) return 0.0;
    final scores = state.values.map((stats) => stats['score'] as int);
    return scores.reduce((a, b) => a + b) / scores.length;
  }
}

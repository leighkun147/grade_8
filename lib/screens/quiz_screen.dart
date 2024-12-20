import 'package:flutter/material.dart';
import '../widgets/bottom_navigation.dart';
import '../widgets/quiz_question.dart';
import '../models/quiz.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int _currentQuestionIndex = 0;
  List<int?> _userAnswers = [];
  late PageController _pageController;
  bool _isQuizComplete = false;

  // Mock quiz data
  final Quiz _quiz = Quiz(
    id: '1',
    subject: 'Mathematics',
    title: 'Algebra Practice Quiz',
    description: 'Test your algebra skills with this practice quiz',
    questions: [
      Question(
        id: '1',
        text: 'Solve for x: 2x + 5 = 13',
        options: ['x = 4', 'x = 6', 'x = 8', 'x = 3'],
        correctOption: 0,
        explanation: 'Subtract 5 from both sides: 2x = 8\nDivide both sides by 2: x = 4',
      ),
      Question(
        id: '2',
        text: 'What is the value of y in: y² = 16',
        options: ['y = 4', 'y = ±4', 'y = 8', 'y = 2'],
        correctOption: 1,
        explanation: 'The square root of 16 can be either 4 or -4',
      ),
      Question(
        id: '3',
        text: 'Simplify: 3(x + 2) - 2x',
        options: ['x + 6', '5x + 2', 'x + 2', '3x + 6'],
        correctOption: 0,
        explanation: '3(x + 2) - 2x = 3x + 6 - 2x = x + 6',
      ),
    ],
    timeLimit: 30,
    type: QuizType.practice,
    coins: 100,
    year: '2024',
  );

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _userAnswers = List.filled(_quiz.questions.length, null);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _handleAnswer(int questionIndex, int answerIndex) {
    setState(() {
      _userAnswers[questionIndex] = answerIndex;
    });
  }

  void _nextQuestion() {
    if (_currentQuestionIndex < _quiz.questions.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      setState(() {
        _currentQuestionIndex++;
      });
    } else {
      setState(() {
        _isQuizComplete = true;
      });
    }
  }

  void _previousQuestion() {
    if (_currentQuestionIndex > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      setState(() {
        _currentQuestionIndex--;
      });
    }
  }

  int _calculateScore() {
    int score = 0;
    for (int i = 0; i < _quiz.questions.length; i++) {
      if (_userAnswers[i] == _quiz.questions[i].correctOption) {
        score++;
      }
    }
    return score;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_quiz.title),
        actions: [
          TextButton(
            onPressed: () {
              setState(() {
                _isQuizComplete = true;
              });
            },
            child: const Text(
              'Submit',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
      body: _isQuizComplete
          ? _buildQuizSummary()
          : Column(
              children: [
                LinearProgressIndicator(
                  value: (_currentQuestionIndex + 1) / _quiz.questions.length,
                  backgroundColor: Colors.grey[200],
                  valueColor: AlwaysStoppedAnimation<Color>(
                    Theme.of(context).primaryColor,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Question ${_currentQuestionIndex + 1}/${_quiz.questions.length}',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Row(
                        children: [
                          const Icon(Icons.timer_outlined),
                          const SizedBox(width: 4),
                          Text(
                            '${_quiz.timeLimit}:00',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: PageView.builder(
                    controller: _pageController,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: _quiz.questions.length,
                    onPageChanged: (index) {
                      setState(() {
                        _currentQuestionIndex = index;
                      });
                    },
                    itemBuilder: (context, index) {
                      return QuizQuestion(
                        question: _quiz.questions[index],
                        selectedAnswer: _userAnswers[index],
                        onAnswerSelected: (answerIndex) =>
                            _handleAnswer(index, answerIndex),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      if (_currentQuestionIndex > 0)
                        ElevatedButton(
                          onPressed: _previousQuestion,
                          child: const Text('Previous'),
                        )
                      else
                        const SizedBox(width: 80),
                      ElevatedButton(
                        onPressed: _nextQuestion,
                        child: Text(
                          _currentQuestionIndex == _quiz.questions.length - 1
                              ? 'Finish'
                              : 'Next',
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
      bottomNavigationBar: const BottomNavigation(currentIndex: 3),
    );
  }

  Widget _buildQuizSummary() {
    final score = _calculateScore();
    final percentage = (score / _quiz.questions.length) * 100;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Icon(
            Icons.assignment_turned_in,
            size: 64,
            color: Colors.green,
          ),
          const SizedBox(height: 24),
          Text(
            'Quiz Complete!',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(height: 16),
          Text(
            'You scored',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 8),
          Text(
            '$score/${_quiz.questions.length}',
            style: Theme.of(context).textTheme.displayMedium?.copyWith(
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.bold,
                ),
          ),
          Text(
            '${percentage.toStringAsFixed(1)}%',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: Theme.of(context).primaryColor,
                ),
          ),
          const SizedBox(height: 32),
          const Text(
            'Question Review',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          ...List.generate(
            _quiz.questions.length,
            (index) => Card(
              margin: const EdgeInsets.only(bottom: 16),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          'Question ${index + 1}',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Icon(
                          _userAnswers[index] ==
                                  _quiz.questions[index].correctOption
                              ? Icons.check_circle
                              : Icons.cancel,
                          color: _userAnswers[index] ==
                                  _quiz.questions[index].correctOption
                              ? Colors.green
                              : Colors.red,
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(_quiz.questions[index].text),
                    const SizedBox(height: 8),
                    if (_userAnswers[index] !=
                        _quiz.questions[index].correctOption) ...[
                      Text(
                        'Your answer: ${_quiz.questions[index].options[_userAnswers[index] ?? 0]}',
                        style: const TextStyle(color: Colors.red),
                      ),
                      Text(
                        'Correct answer: ${_quiz.questions[index].options[_quiz.questions[index].correctOption]}',
                        style: const TextStyle(color: Colors.green),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Explanation: ${_quiz.questions[index].explanation}',
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Back to Quizzes'),
          ),
        ],
      ),
    );
  }
}

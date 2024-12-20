enum QuizType { practice, mock, daily }

class Quiz {
  final String id;
  final String subject;
  final String title;
  final String description;
  final List<Question> questions;
  final int timeLimit; // in minutes
  final QuizType type;
  final int coins;
  final String year;

  Quiz({
    required this.id,
    required this.subject,
    required this.title,
    required this.description,
    required this.questions,
    required this.timeLimit,
    required this.type,
    required this.coins,
    required this.year,
  });

  factory Quiz.fromJson(Map<String, dynamic> json) {
    return Quiz(
      id: json['id'] as String,
      subject: json['subject'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      questions: (json['questions'] as List)
          .map((q) => Question.fromJson(q))
          .toList(),
      timeLimit: json['timeLimit'] as int,
      type: QuizType.values.firstWhere(
        (e) => e.toString() == 'QuizType.${json['type']}',
      ),
      coins: json['coins'] as int,
      year: json['year'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'subject': subject,
      'title': title,
      'description': description,
      'questions': questions.map((q) => q.toJson()).toList(),
      'timeLimit': timeLimit,
      'type': type.toString().split('.').last,
      'coins': coins,
      'year': year,
    };
  }
}

class Question {
  final String id;
  final String text;
  final List<String> options;
  final int correctOption;
  final String explanation;

  Question({
    required this.id,
    required this.text,
    required this.options,
    required this.correctOption,
    required this.explanation,
  });

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      id: json['id'] as String,
      text: json['text'] as String,
      options: List<String>.from(json['options']),
      correctOption: json['correctOption'] as int,
      explanation: json['explanation'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'text': text,
      'options': options,
      'correctOption': correctOption,
      'explanation': explanation,
    };
  }
}

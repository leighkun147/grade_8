enum Difficulty {
  beginner,
  intermediate,
  advanced,
}

class DifficultySystem {
  static const Map<Difficulty, Map<String, dynamic>> levelCharacteristics = {
    Difficulty.beginner: {
      'description': 'Basic concepts and fundamental principles',
      'questionTypes': [
        'Multiple choice',
        'True/False',
        'Simple fill in the blanks',
      ],
      'timeAllowed': 30, // seconds per question
      'pointsPerQuestion': 1,
    },
    Difficulty.intermediate: {
      'description': 'Application of concepts and problem-solving',
      'questionTypes': [
        'Multiple choice with explanation',
        'Short answer',
        'Problem-solving',
      ],
      'timeAllowed': 45, // seconds per question
      'pointsPerQuestion': 2,
    },
    Difficulty.advanced: {
      'description': 'Complex problem-solving and analysis',
      'questionTypes': [
        'Long answer',
        'Case studies',
        'Multi-step problems',
      ],
      'timeAllowed': 60, // seconds per question
      'pointsPerQuestion': 3,
    },
  };

  static const Map<String, Map<Difficulty, List<String>>> subjectSkills = {
    'Mathematics': {
      Difficulty.beginner: [
        'Basic arithmetic',
        'Simple equations',
        'Basic geometry',
      ],
      Difficulty.intermediate: [
        'Linear equations',
        'Geometric proofs',
        'Word problems',
      ],
      Difficulty.advanced: [
        'Complex equations',
        'Advanced geometry',
        'Mathematical modeling',
      ],
    },
    'English': {
      Difficulty.beginner: [
        'Basic grammar',
        'Simple vocabulary',
        'Short reading',
      ],
      Difficulty.intermediate: [
        'Complex grammar',
        'Essay writing',
        'Reading comprehension',
      ],
      Difficulty.advanced: [
        'Advanced writing',
        'Literary analysis',
        'Critical thinking',
      ],
    },
    'Geography': {
      Difficulty.beginner: [
        'Basic map reading',
        'Simple landforms',
        'Local geography',
      ],
      Difficulty.intermediate: [
        'Climate patterns',
        'Resource distribution',
        'Population studies',
      ],
      Difficulty.advanced: [
        'Environmental analysis',
        'Geographic systems',
        'Resource management',
      ],
    },
    'History': {
      Difficulty.beginner: [
        'Basic timeline',
        'Key figures',
        'Major events',
      ],
      Difficulty.intermediate: [
        'Cause and effect',
        'Historical analysis',
        'Cultural studies',
      ],
      Difficulty.advanced: [
        'Complex analysis',
        'Historical research',
        'Document analysis',
      ],
    },
    'Social Sciences': {
      Difficulty.beginner: [
        'Basic rights',
        'Simple civics',
        'Local government',
      ],
      Difficulty.intermediate: [
        'Constitutional rights',
        'Government systems',
        'Social issues',
      ],
      Difficulty.advanced: [
        'Policy analysis',
        'Complex social issues',
        'Governance studies',
      ],
    },
    'Biology': {
      Difficulty.beginner: [
        'Basic cells',
        'Simple systems',
        'Life cycles',
      ],
      Difficulty.intermediate: [
        'Body systems',
        'Genetics basics',
        'Ecosystem studies',
      ],
      Difficulty.advanced: [
        'Complex systems',
        'Advanced genetics',
        'Environmental biology',
      ],
    },
    'Physics': {
      Difficulty.beginner: [
        'Basic forces',
        'Simple machines',
        'Energy types',
      ],
      Difficulty.intermediate: [
        'Motion analysis',
        'Energy conversion',
        'Circuit basics',
      ],
      Difficulty.advanced: [
        'Complex mechanics',
        'Advanced circuits',
        'Wave analysis',
      ],
    },
    'Chemistry': {
      Difficulty.beginner: [
        'Basic elements',
        'Simple reactions',
        'States of matter',
      ],
      Difficulty.intermediate: [
        'Chemical equations',
        'Solution chemistry',
        'Acid-base reactions',
      ],
      Difficulty.advanced: [
        'Complex reactions',
        'Equilibrium',
        'Organic basics',
      ],
    },
  };

  static int calculatePoints(Difficulty difficulty, int correctAnswers) {
    final pointsPerQuestion = levelCharacteristics[difficulty]!['pointsPerQuestion'] as int;
    return correctAnswers * pointsPerQuestion;
  }

  static String getDifficultyDescription(Difficulty difficulty) {
    return levelCharacteristics[difficulty]!['description'] as String;
  }

  static List<String> getQuestionTypes(Difficulty difficulty) {
    return levelCharacteristics[difficulty]!['questionTypes'] as List<String>;
  }

  static int getTimeAllowed(Difficulty difficulty) {
    return levelCharacteristics[difficulty]!['timeAllowed'] as int;
  }
}

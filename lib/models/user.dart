class User {
  final String id;
  final String name;
  final String email;
  final String photoUrl;
  final int coins;
  final int level;
  final Map<String, double> subjectProgress;
  final List<String> completedQuizzes;
  final List<String> achievements;

  User({
    required this.id,
    required this.name,
    required this.email,
    this.photoUrl = '',
    this.coins = 0,
    this.level = 1,
    Map<String, double>? subjectProgress,
    List<String>? completedQuizzes,
    List<String>? achievements,
  })  : subjectProgress = subjectProgress ?? {},
        completedQuizzes = completedQuizzes ?? [],
        achievements = achievements ?? [];

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      photoUrl: json['photoUrl'] as String? ?? '',
      coins: json['coins'] as int? ?? 0,
      level: json['level'] as int? ?? 1,
      subjectProgress: Map<String, double>.from(json['subjectProgress'] ?? {}),
      completedQuizzes: List<String>.from(json['completedQuizzes'] ?? []),
      achievements: List<String>.from(json['achievements'] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'photoUrl': photoUrl,
      'coins': coins,
      'level': level,
      'subjectProgress': subjectProgress,
      'completedQuizzes': completedQuizzes,
      'achievements': achievements,
    };
  }

  User copyWith({
    String? name,
    String? photoUrl,
    int? coins,
    int? level,
    Map<String, double>? subjectProgress,
    List<String>? completedQuizzes,
    List<String>? achievements,
  }) {
    return User(
      id: id,
      name: name ?? this.name,
      email: email,
      photoUrl: photoUrl ?? this.photoUrl,
      coins: coins ?? this.coins,
      level: level ?? this.level,
      subjectProgress: subjectProgress ?? this.subjectProgress,
      completedQuizzes: completedQuizzes ?? this.completedQuizzes,
      achievements: achievements ?? this.achievements,
    );
  }
}

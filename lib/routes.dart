import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'screens/leaderboard_screen.dart';
import 'screens/preparation_screen.dart';
import 'screens/quiz_screen.dart';
import 'screens/profile_screen.dart';
import 'screens/study_materials_screen.dart';

class AppRoutes {
  static const String home = '/home';
  static const String leaderboard = '/leaderboard';
  static const String preparation = '/preparation';
  static const String quiz = '/quiz';
  static const String profile = '/profile';
  static const String studyMaterials = '/study-materials';

  static final Map<String, WidgetBuilder> routes = {
    home: (context) => const HomeScreen(),
    leaderboard: (context) => const LeaderboardScreen(),
    preparation: (context) => const PreparationScreen(),
    quiz: (context) => const QuizScreen(),
    profile: (context) => const ProfileScreen(),
    studyMaterials: (context) => const StudyMaterialsScreen(),
  };
}

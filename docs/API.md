# Grade 8 National Exam Prep App API Documentation

## Providers

### UserProvider
Manages user state and authentication.

```dart
final userProvider = StateNotifierProvider<UserNotifier, User?>((ref) {
  return UserNotifier();
});
```

Methods:
- `updateUser(User user)`: Update user information
- `updateProgress(String subject, double progress)`: Update subject progress
- `addCoins(int amount)`: Add coins to user balance
- `levelUp()`: Increase user level
- `logout()`: Clear user session

### QuizProvider
Handles quiz state and progress.

```dart
final quizProvider = StateNotifierProvider<QuizNotifier, List<Quiz>>((ref) {
  return QuizNotifier();
});
```

Methods:
- `addQuiz(Quiz quiz)`: Add new quiz
- `removeQuiz(String quizId)`: Remove quiz
- `getQuizzesBySubject(String subject)`: Get subject-specific quizzes
- `getQuizzesByType(QuizType type)`: Get quizzes by type

### StudyMaterialsProvider
Manages study materials and downloads.

```dart
final studyMaterialsProvider = StateNotifierProvider<StudyMaterialsNotifier, List<StudyMaterial>>((ref) {
  return StudyMaterialsNotifier();
});
```

Methods:
- `getMaterialsBySubject(String subject)`: Get subject materials
- `searchMaterials(String query)`: Search materials
- `toggleDownloadStatus(String materialId)`: Toggle download state
- `addMaterial(StudyMaterial material)`: Add new material

## Services

### CacheService
Handles local caching of data.

```dart
class CacheService {
  Future<void> writeToCache<T>({
    required String key,
    required T data,
    Duration? expiry,
  });

  Future<T?> readFromCache<T>({
    required String key,
    required T Function(Map<String, dynamic> json) fromJson,
  });

  Future<void> removeFromCache(String key);
  Future<void> clearCache();
}
```

### StorageService
Manages persistent storage.

```dart
class StorageService {
  Future<bool> setString(String key, String value);
  String? getString(String key);
  Future<bool> setObject<T>(String key, T value);
  T? getObject<T>(String key, T Function(Map<String, dynamic> json) fromJson);
}
```

## Widgets

### AnimatedCard
Interactive card with animations.

```dart
const AnimatedCard({
  Key? key,
  required Widget child,
  VoidCallback? onTap,
  bool expanded = false,
  Duration duration = const Duration(milliseconds: 300),
  Curve curve = Curves.easeInOut,
  double elevation = 1.0,
  Color? color,
  BorderRadius? borderRadius,
});
```

### AnimatedListItem
Animated list item with entrance animation.

```dart
const AnimatedListItem({
  Key? key,
  required Widget child,
  required int index,
  Duration delay = const Duration(milliseconds: 100),
  bool animate = true,
});
```

### CustomChip
Versatile chip component.

```dart
const CustomChip({
  Key? key,
  required String label,
  IconData? icon,
  Color? color,
  VoidCallback? onTap,
  bool selected = false,
  bool outlined = false,
});
```

## Models

### User
```dart
class User {
  final String id;
  final String name;
  final String email;
  final int level;
  final int coins;
  final Map<String, double> subjectProgress;
  
  // Constructors and methods...
}
```

### Quiz
```dart
class Quiz {
  final String id;
  final String subject;
  final String title;
  final String description;
  final List<Question> questions;
  final int timeLimit;
  final QuizType type;
  final int coins;
  final String year;
  
  // Constructors and methods...
}
```

### StudyMaterial
```dart
class StudyMaterial {
  final String id;
  final String title;
  final String subject;
  final String type;
  final String filePath;
  final int size;
  final DateTime uploadDate;
  final bool isDownloaded;
  
  // Constructors and methods...
}
```

## Error Handling

### AppError
```dart
class AppError {
  final String message;
  final ErrorType type;
  final dynamic originalError;
  final StackTrace? stackTrace;
  
  // Factory constructors...
  factory AppError.network(dynamic error);
  factory AppError.auth(String message);
  factory AppError.validation(String message);
  factory AppError.server(String message);
  factory AppError.unknown(dynamic error, [StackTrace? stackTrace]);
}
```

## Navigation

### CustomNavigator
```dart
class CustomNavigator {
  static Future<T?> push<T>(
    BuildContext context,
    Widget page, {
    TransitionType type = TransitionType.slide,
    SlideDirection direction = SlideDirection.right,
  });

  static Future<T?> pushReplacement<T, TO>(
    BuildContext context,
    Widget page, {
    TransitionType type = TransitionType.slide,
    SlideDirection direction = SlideDirection.right,
  });
}
```

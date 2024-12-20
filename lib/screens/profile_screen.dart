import 'package:flutter/material.dart';
import '../widgets/bottom_navigation.dart';
import '../models/user.dart';
import '../models/progress.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _isDarkMode = false;
  bool _notificationsEnabled = true;

  // Mock user data
  final User _user = User(
    id: '1',
    name: 'John Doe',
    email: 'john.doe@example.com',
    photoUrl: 'assets/images/user_avatar.png',
    coins: 1250,
    level: 8,
    subjectProgress: {
      'Mathematics': 75.0,
      'Science': 82.0,
      'English': 90.0,
      'Social Studies': 85.0,
    },
  );

  // Mock progress data
  final Progress _progress = Progress(
    userId: '1',
    subjects: {
      'Mathematics': SubjectProgress(
        subject: 'Mathematics',
        completionPercentage: 75.0,
        questionsAttempted: 150,
        questionsCorrect: 120,
        completedTopics: ['Algebra', 'Geometry'],
        strugglingTopics: ['Trigonometry'],
      ),
      'Science': SubjectProgress(
        subject: 'Science',
        completionPercentage: 82.0,
        questionsAttempted: 200,
        questionsCorrect: 164,
        completedTopics: ['Physics', 'Chemistry'],
        strugglingTopics: ['Biology'],
      ),
    },
    quizHistory: [],
    totalStudyTime: 3600,
    streakDays: 7,
    lastStudyDate: DateTime.now(),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              // TODO: Implement edit profile
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Profile Header
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor.withOpacity(0.1),
              ),
              child: Column(
                children: [
                  Stack(
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundImage: AssetImage(_user.photoUrl),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.camera_alt,
                            size: 20,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    _user.name,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    _user.email,
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildStatCard(
                        'Level',
                        _user.level.toString(),
                        Icons.trending_up,
                      ),
                      const SizedBox(width: 24),
                      _buildStatCard(
                        'Coins',
                        _user.coins.toString(),
                        Icons.stars,
                      ),
                      const SizedBox(width: 24),
                      _buildStatCard(
                        'Streak',
                        '${_progress.streakDays} days',
                        Icons.local_fire_department,
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Subject Progress
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Subject Progress',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  ..._user.subjectProgress.entries.map(
                    (entry) => Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                entry.key,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Text(
                                '${entry.value.toStringAsFixed(1)}%',
                                style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          LinearProgressIndicator(
                            value: entry.value / 100,
                            backgroundColor: Colors.grey[200],
                            valueColor: AlwaysStoppedAnimation<Color>(
                              Theme.of(context).primaryColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Settings
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Settings',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildSettingTile(
                    'Dark Mode',
                    Icons.dark_mode,
                    Switch(
                      value: _isDarkMode,
                      onChanged: (value) {
                        setState(() {
                          _isDarkMode = value;
                        });
                      },
                    ),
                  ),
                  _buildSettingTile(
                    'Notifications',
                    Icons.notifications,
                    Switch(
                      value: _notificationsEnabled,
                      onChanged: (value) {
                        setState(() {
                          _notificationsEnabled = value;
                        });
                      },
                    ),
                  ),
                  _buildSettingTile(
                    'Language',
                    Icons.language,
                    const Text('English'),
                  ),
                  _buildSettingTile(
                    'Help & Support',
                    Icons.help,
                    const Icon(Icons.chevron_right),
                  ),
                  _buildSettingTile(
                    'About',
                    Icons.info,
                    const Icon(Icons.chevron_right),
                  ),
                ],
              ),
            ),

            // Logout Button
            Padding(
              padding: const EdgeInsets.all(16),
              child: ElevatedButton(
                onPressed: () {
                  // TODO: Implement logout
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  minimumSize: const Size(double.infinity, 48),
                ),
                child: const Text(
                  'Logout',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const BottomNavigation(currentIndex: 4),
    );
  }

  Widget _buildStatCard(String label, String value, IconData icon) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 12,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(
            icon,
            color: Theme.of(context).primaryColor,
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          Text(
            label,
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingTile(String title, IconData icon, Widget trailing) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      trailing: trailing,
      onTap: trailing is Icon ? () {} : null,
    );
  }
}

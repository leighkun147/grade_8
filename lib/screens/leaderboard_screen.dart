import 'package:flutter/material.dart';
import '../widgets/bottom_navigation.dart';
import '../widgets/leaderboard_card.dart';
import '../models/leaderboard.dart';

class LeaderboardScreen extends StatefulWidget {
  const LeaderboardScreen({super.key});

  @override
  State<LeaderboardScreen> createState() => _LeaderboardScreenState();
}

class _LeaderboardScreenState extends State<LeaderboardScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final List<String> _periods = ['Daily', 'Weekly', 'Monthly', 'All Time'];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _periods.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  // Temporary mock data
  List<LeaderboardEntry> _getMockLeaderboardData() {
    return List.generate(
      20,
      (index) => LeaderboardEntry(
        userId: 'user$index',
        userName: 'Student ${index + 1}',
        photoUrl: 'assets/images/user_avatar.png',
        coins: 1000 - (index * 50),
        rank: index + 1,
        tier: index < 3
            ? LeaderboardTier.master
            : index < 10
                ? LeaderboardTier.diamond
                : LeaderboardTier.gold,
        subjectPerformance: {
          'Math': 85.0,
          'Science': 78.0,
          'English': 92.0,
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Leaderboard'),
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          tabs: _periods.map((period) => Tab(text: period)).toList(),
        ),
      ),
      body: Column(
        children: [
          // User's current rank card
          Card(
            margin: const EdgeInsets.all(16),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  const CircleAvatar(
                    radius: 25,
                    backgroundImage: AssetImage('assets/images/user_avatar.png'),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Your Rank',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            Text(
                              '#15',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                            const SizedBox(width: 8),
                            const Text('🏅'),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Row(
                        children: const [
                          Icon(Icons.star, color: Colors.amber, size: 20),
                          SizedBox(width: 4),
                          Text(
                            '850',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Top 15%',
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          // Leaderboard list
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: _periods.map((period) {
                final leaderboardData = _getMockLeaderboardData();
                return ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: leaderboardData.length,
                  itemBuilder: (context, index) {
                    return LeaderboardCard(
                      entry: leaderboardData[index],
                      showMedal: index < 3,
                    );
                  },
                );
              }).toList(),
            ),
          ),
        ],
      ),
      bottomNavigationBar: const BottomNavigation(currentIndex: 1),
    );
  }
}

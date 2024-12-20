import 'package:flutter/material.dart';
import '../widgets/bottom_navigation.dart';
import '../models/quiz.dart';

class PreparationScreen extends StatefulWidget {
  const PreparationScreen({super.key});

  @override
  State<PreparationScreen> createState() => _PreparationScreenState();
}

class _PreparationScreenState extends State<PreparationScreen> {
  final List<String> _years = ['2023', '2022', '2021', '2020', '2019'];
  String _selectedYear = '2023';

  // Mock exam data
  final Map<String, List<Map<String, dynamic>>> _examData = {
    '2023': [
      {
        'subject': 'Mathematics',
        'totalQuestions': 50,
        'timeLimit': 90,
        'difficulty': 'Medium',
        'attempts': 245,
        'avgScore': 75.5,
      },
      {
        'subject': 'Science',
        'totalQuestions': 60,
        'timeLimit': 120,
        'difficulty': 'Hard',
        'attempts': 198,
        'avgScore': 68.2,
      },
      // Add more subjects...
    ],
    // Add more years...
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Exam Preparation'),
      ),
      body: Column(
        children: [
          // Year selector
          Container(
            padding: const EdgeInsets.all(16),
            color: Theme.of(context).primaryColor.withOpacity(0.1),
            child: Row(
              children: [
                const Text(
                  'Select Year:',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: DropdownButton<String>(
                    value: _selectedYear,
                    isExpanded: true,
                    items: _years.map((year) {
                      return DropdownMenuItem(
                        value: year,
                        child: Text(year),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedYear = value!;
                      });
                    },
                  ),
                ),
              ],
            ),
          ),

          // Exam cards
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: (_examData[_selectedYear] ?? []).length,
              itemBuilder: (context, index) {
                final exam = _examData[_selectedYear]![index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 16),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              exam['subject'],
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                color: Theme.of(context)
                                    .primaryColor
                                    .withOpacity(0.1),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                exam['difficulty'],
                                style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            _buildStatItem(
                              Icons.question_answer,
                              '${exam['totalQuestions']}',
                              'Questions',
                            ),
                            _buildStatItem(
                              Icons.timer,
                              '${exam['timeLimit']} min',
                              'Duration',
                            ),
                            _buildStatItem(
                              Icons.people,
                              '${exam['attempts']}',
                              'Attempts',
                            ),
                            _buildStatItem(
                              Icons.analytics,
                              '${exam['avgScore']}%',
                              'Avg. Score',
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            Expanded(
                              child: ElevatedButton.icon(
                                onPressed: () {
                                  // TODO: Start practice mode
                                },
                                icon: const Icon(Icons.book),
                                label: const Text('Practice Mode'),
                                style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.all(12),
                                ),
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: ElevatedButton.icon(
                                onPressed: () {
                                  // TODO: Start mock exam
                                },
                                icon: const Icon(Icons.timer),
                                label: const Text('Mock Exam'),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      Theme.of(context).colorScheme.secondary,
                                  padding: const EdgeInsets.all(12),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: const BottomNavigation(currentIndex: 2),
    );
  }

  Widget _buildStatItem(IconData icon, String value, String label) {
    return Column(
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
    );
  }
}

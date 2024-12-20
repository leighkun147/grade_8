import 'package:flutter/material.dart';
import '../widgets/bottom_navigation.dart';

class StudyMaterialsScreen extends StatefulWidget {
  const StudyMaterialsScreen({super.key});

  @override
  State<StudyMaterialsScreen> createState() => _StudyMaterialsScreenState();
}

class _StudyMaterialsScreenState extends State<StudyMaterialsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final List<String> _subjects = [
    'Mathematics',
    'Science',
    'English',
    'Social Studies',
    'Amharic',
  ];

  // Mock study materials data
  final Map<String, List<Map<String, dynamic>>> _materials = {
    'Mathematics': [
      {
        'title': 'Algebra Basics',
        'type': 'PDF',
        'size': '2.5 MB',
        'icon': Icons.picture_as_pdf,
        'color': Colors.red,
      },
      {
        'title': 'Geometry Formulas',
        'type': 'PDF',
        'size': '1.8 MB',
        'icon': Icons.picture_as_pdf,
        'color': Colors.red,
      },
      {
        'title': 'Math Concepts Video',
        'type': 'Video',
        'size': '45 MB',
        'icon': Icons.play_circle_fill,
        'color': Colors.blue,
      },
    ],
    'Science': [
      {
        'title': 'Physics Laws',
        'type': 'PDF',
        'size': '3.2 MB',
        'icon': Icons.picture_as_pdf,
        'color': Colors.red,
      },
      {
        'title': 'Chemistry Experiments',
        'type': 'Video',
        'size': '65 MB',
        'icon': Icons.play_circle_fill,
        'color': Colors.blue,
      },
    ],
    // Add more subjects and materials...
  };

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _subjects.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Study Materials'),
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          tabs: _subjects.map((subject) => Tab(text: subject)).toList(),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: _subjects.map((subject) {
          final materials = _materials[subject] ?? [];
          return materials.isEmpty
              ? const Center(
                  child: Text('No materials available yet'),
                )
              : ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: materials.length,
                  itemBuilder: (context, index) {
                    final material = materials[index];
                    return Card(
                      margin: const EdgeInsets.only(bottom: 16),
                      child: ListTile(
                        leading: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: material['color'].withOpacity(0.1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Icon(
                            material['icon'],
                            color: material['color'],
                          ),
                        ),
                        title: Text(
                          material['title'],
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Text(
                          '${material['type']} • ${material['size']}',
                          style: TextStyle(
                            color: Colors.grey[600],
                          ),
                        ),
                        trailing: IconButton(
                          icon: const Icon(Icons.download),
                          onPressed: () {
                            // TODO: Implement download functionality
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  'Downloading ${material['title']}...',
                                ),
                              ),
                            );
                          },
                        ),
                        onTap: () {
                          // TODO: Implement material viewing
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: Text(material['title']),
                              content: const Text(
                                'This feature will be implemented soon!',
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: const Text('OK'),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    );
                  },
                );
        }).toList(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // TODO: Implement search functionality
          showSearch(
            context: context,
            delegate: _StudyMaterialSearchDelegate(_materials),
          );
        },
        child: const Icon(Icons.search),
      ),
      bottomNavigationBar: const BottomNavigation(currentIndex: 2),
    );
  }
}

class _StudyMaterialSearchDelegate extends SearchDelegate<String> {
  final Map<String, List<Map<String, dynamic>>> materials;

  _StudyMaterialSearchDelegate(this.materials);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, '');
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return _buildSearchResults();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return _buildSearchResults();
  }

  Widget _buildSearchResults() {
    List<MapEntry<String, Map<String, dynamic>>> results = [];

    materials.forEach((subject, materialsList) {
      for (var material in materialsList) {
        if (material['title'].toString().toLowerCase().contains(query.toLowerCase())) {
          results.add(MapEntry(subject, material));
        }
      }
    });

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: results.length,
      itemBuilder: (context, index) {
        final result = results[index];
        return Card(
          child: ListTile(
            leading: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: result.value['color'].withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                result.value['icon'],
                color: result.value['color'],
              ),
            ),
            title: Text(result.value['title']),
            subtitle: Text(
              '${result.key} • ${result.value['type']}',
              style: TextStyle(
                color: Colors.grey[600],
              ),
            ),
            onTap: () {
              close(context, result.value['title']);
            },
          ),
        );
      },
    );
  }
}

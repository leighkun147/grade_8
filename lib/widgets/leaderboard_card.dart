import 'package:flutter/material.dart';
import '../models/leaderboard.dart';

class LeaderboardCard extends StatelessWidget {
  final LeaderboardEntry entry;
  final bool showMedal;

  const LeaderboardCard({
    super.key,
    required this.entry,
    this.showMedal = false,
  });

  Widget _buildMedal(int rank) {
    switch (rank) {
      case 1:
        return const Text('🥇', style: TextStyle(fontSize: 24));
      case 2:
        return const Text('🥈', style: TextStyle(fontSize: 24));
      case 3:
        return const Text('🥉', style: TextStyle(fontSize: 24));
      default:
        return const SizedBox.shrink();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: SizedBox(
          width: 60,
          child: Row(
            children: [
              if (showMedal)
                _buildMedal(entry.rank)
              else
                Text(
                  '#${entry.rank}',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
            ],
          ),
        ),
        title: Row(
          children: [
            CircleAvatar(
              radius: 16,
              backgroundImage: AssetImage(entry.photoUrl),
            ),
            const SizedBox(width: 12),
            Text(
              entry.userName,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(width: 8),
            Text(
              entry.tierBadge,
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.star, color: Colors.amber, size: 20),
            const SizedBox(width: 4),
            Text(
              entry.coins.toString(),
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        onTap: () {
          showModalBottomSheet(
            context: context,
            builder: (context) => _buildDetailSheet(context),
          );
        },
      ),
    );
  }

  Widget _buildDetailSheet(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 30,
                backgroundImage: AssetImage(entry.photoUrl),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      entry.userName,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Rank #${entry.rank} ${entry.tierBadge}',
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          const Text(
            'Subject Performance',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          ...entry.subjectPerformance.entries.map(
            (e) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    e.key,
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 4),
                  LinearProgressIndicator(
                    value: e.value / 100,
                    backgroundColor: Colors.grey[200],
                    valueColor: AlwaysStoppedAnimation<Color>(
                      Theme.of(context).primaryColor,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${e.value.toStringAsFixed(1)}%',
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

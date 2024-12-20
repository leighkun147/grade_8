enum LeaderboardTier {
  bronze,
  silver,
  gold,
  platinum,
  diamond,
  master
}

class LeaderboardEntry {
  final String userId;
  final String userName;
  final String photoUrl;
  final int coins;
  final int rank;
  final LeaderboardTier tier;
  final Map<String, double> subjectPerformance;

  LeaderboardEntry({
    required this.userId,
    required this.userName,
    required this.photoUrl,
    required this.coins,
    required this.rank,
    required this.tier,
    required this.subjectPerformance,
  });

  factory LeaderboardEntry.fromJson(Map<String, dynamic> json) {
    return LeaderboardEntry(
      userId: json['userId'] as String,
      userName: json['userName'] as String,
      photoUrl: json['photoUrl'] as String,
      coins: json['coins'] as int,
      rank: json['rank'] as int,
      tier: LeaderboardTier.values.firstWhere(
        (e) => e.toString() == 'LeaderboardTier.${json['tier']}',
      ),
      subjectPerformance: Map<String, double>.from(json['subjectPerformance']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'userName': userName,
      'photoUrl': photoUrl,
      'coins': coins,
      'rank': rank,
      'tier': tier.toString().split('.').last,
      'subjectPerformance': subjectPerformance,
    };
  }

  String get tierBadge {
    switch (tier) {
      case LeaderboardTier.bronze:
        return '🥉';
      case LeaderboardTier.silver:
        return '🥈';
      case LeaderboardTier.gold:
        return '🥇';
      case LeaderboardTier.platinum:
        return '💎';
      case LeaderboardTier.diamond:
        return '👑';
      case LeaderboardTier.master:
        return '🏆';
    }
  }
}

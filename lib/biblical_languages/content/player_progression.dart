import '../progress/biblical_progress.dart';

class PlayerRank {
  const PlayerRank({
    required this.level,
    required this.title,
    required this.minXp,
  });

  final int level;
  final String title;
  final int minXp;
}

const playerRanks = <PlayerRank>[
  PlayerRank(level: 1, title: 'Aprendiz', minXp: 0),
  PlayerRank(level: 2, title: 'Leitor', minXp: 120),
  PlayerRank(level: 3, title: 'Decodificador', minXp: 360),
  PlayerRank(level: 4, title: 'Escriba', minXp: 720),
  PlayerRank(level: 5, title: 'Leitor Avançado', minXp: 1200),
  PlayerRank(level: 6, title: 'Analista', minXp: 1800),
  PlayerRank(level: 7, title: 'Exegeta em Formação', minXp: 3000),
];

class PlayerAchievement {
  const PlayerAchievement({
    required this.id,
    required this.title,
    required this.description,
    required this.unlocked,
  });

  final String id;
  final String title;
  final String description;
  final bool unlocked;
}

class PlayerProgressMetrics {
  const PlayerProgressMetrics({
    required this.rank,
    required this.nextRank,
    required this.rankProgress,
    required this.xpToNextRank,
    required this.dailyGoalCompleted,
    required this.sessionsCompleted,
    required this.masteryOneCount,
    required this.masteryThreeCount,
    required this.masteryFiveCount,
    required this.averageAccuracyLast7,
    required this.achievements,
  });

  final PlayerRank rank;
  final PlayerRank? nextRank;
  final double rankProgress;
  final int xpToNextRank;
  final bool dailyGoalCompleted;
  final int sessionsCompleted;
  final int masteryOneCount;
  final int masteryThreeCount;
  final int masteryFiveCount;
  final int averageAccuracyLast7;
  final List<PlayerAchievement> achievements;

  int get unlockedAchievementCount =>
      achievements.where((achievement) => achievement.unlocked).length;
}

PlayerProgressMetrics buildPlayerProgressMetrics(
  BiblicalProgressSnapshot progress, {
  DateTime? now,
}) {
  final reference = (now ?? DateTime.now().toUtc()).toUtc();
  final rank = playerRankForXp(progress.xp);
  final rankIndex = playerRanks.indexOf(rank);
  final nextRank = rankIndex < playerRanks.length - 1
      ? playerRanks[rankIndex + 1]
      : null;
  final span = nextRank == null ? 1 : nextRank.minXp - rank.minXp;
  final rankProgress = nextRank == null
      ? 1.0
      : ((progress.xp - rank.minXp) / span).clamp(0.0, 1.0);
  final masteryOne = _masteryCount(progress, 1);
  final masteryThree = _masteryCount(progress, 3);
  final masteryFive = _masteryCount(progress, 5);
  final recentSessions = progress.practiceSessions.length <= 7
      ? progress.practiceSessions
      : progress.practiceSessions
          .sublist(progress.practiceSessions.length - 7);
  final averageAccuracy = recentSessions.isEmpty
      ? 0
      : (recentSessions
                  .map((session) => session.accuracy)
                  .reduce((a, b) => a + b) /
              recentSessions.length)
          .round();

  final achievements = <PlayerAchievement>[
    PlayerAchievement(
      id: 'first_session',
      title: 'Primeira Jornada',
      description: 'Conclua sua primeira Daily Session.',
      unlocked: progress.practiceSessions.isNotEmpty,
    ),
    PlayerAchievement(
      id: 'streak_3',
      title: 'Ritmo 3',
      description: 'Mantenha 3 dias seguidos de prática.',
      unlocked: progress.streakDays >= 3,
    ),
    PlayerAchievement(
      id: 'streak_7',
      title: 'Ritmo 7',
      description: 'Mantenha 7 dias seguidos de prática.',
      unlocked: progress.streakDays >= 7,
    ),
    PlayerAchievement(
      id: 'xp_120',
      title: '120 XP',
      description: 'Alcance 120 XP de prática correta.',
      unlocked: progress.xp >= 120,
    ),
    PlayerAchievement(
      id: 'xp_720',
      title: '720 XP',
      description: 'Alcance 720 XP de prática correta.',
      unlocked: progress.xp >= 720,
    ),
    PlayerAchievement(
      id: 'lesson_1',
      title: 'Primeiro Portal',
      description: 'Conclua a Lesson 001.',
      unlocked: progress.completedLessonIds.isNotEmpty,
    ),
    PlayerAchievement(
      id: 'lesson_6',
      title: 'Meio do Mapa',
      description: 'Conclua 6 Lessons.',
      unlocked: progress.completedLessonIds.length >= 6,
    ),
    PlayerAchievement(
      id: 'lesson_12',
      title: 'Mapa Completo',
      description: 'Conclua as 12 Lessons.',
      unlocked: progress.completedLessonIds.length >= 12,
    ),
    PlayerAchievement(
      id: 'mastery_12',
      title: '12 Consolidados',
      description: 'Leve 12 drills a mastery 3 ou mais.',
      unlocked: masteryThree >= 12,
    ),
    PlayerAchievement(
      id: 'mastery_72',
      title: 'Uma Lesson Consolidada',
      description: 'Leve 72 drills a mastery 3 ou mais.',
      unlocked: masteryThree >= 72,
    ),
    PlayerAchievement(
      id: 'perfect_session',
      title: 'Sessão Perfeita',
      description: 'Conclua uma Daily Session com 100% de acurácia.',
      unlocked: progress.practiceSessions.any(
        (session) => session.itemCount > 0 && session.accuracy == 100,
      ),
    ),
    PlayerAchievement(
      id: 'sessions_12',
      title: '12 Sessões',
      description: 'Conclua 12 Daily Sessions.',
      unlocked: progress.practiceSessions.length >= 12,
    ),
  ];

  return PlayerProgressMetrics(
    rank: rank,
    nextRank: nextRank,
    rankProgress: rankProgress,
    xpToNextRank:
        nextRank == null ? 0 : (nextRank.minXp - progress.xp).clamp(0, 1 << 31),
    dailyGoalCompleted: progress.dailyGoalCompletedOn(reference),
    sessionsCompleted: progress.practiceSessions.length,
    masteryOneCount: masteryOne,
    masteryThreeCount: masteryThree,
    masteryFiveCount: masteryFive,
    averageAccuracyLast7: averageAccuracy,
    achievements: List<PlayerAchievement>.unmodifiable(achievements),
  );
}

PlayerRank playerRankForXp(int xp) {
  var rank = playerRanks.first;
  for (final candidate in playerRanks) {
    if (xp >= candidate.minXp) {
      rank = candidate;
    } else {
      break;
    }
  }
  return rank;
}

int _masteryCount(BiblicalProgressSnapshot progress, int minimum) {
  return progress.masteryByDrillId.values
      .where((mastery) => mastery >= minimum)
      .length;
}

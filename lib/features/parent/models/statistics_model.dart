class StatisticsModel {
  final String childId;
  final String childName;
  final String? avatarUrl;
  final int totalPoints;

  final PeriodStats thisWeek;
  final PeriodStats thisMonth;
  final PeriodStats allTime;
  PeriodStats getStatsByType(String type) {
    switch (type) {
      case "ThisMonth":
        return thisMonth;
      case "AllTime":
        return allTime;
      default:
        return thisWeek;
    }
  }

  final Performance performance;

  StatisticsModel({
    required this.childId,
    required this.childName,
    required this.avatarUrl,
    required this.totalPoints,
    required this.thisWeek,
    required this.thisMonth,
    required this.allTime,
    required this.performance,
  });

  factory StatisticsModel.fromJson(Map<String, dynamic> json) {
    final data = json['data'];

    return StatisticsModel(
      childId: data['childId'],
      childName: data['childName'],
      avatarUrl: data['avatarUrl'],
      totalPoints: data['totalPoints'],
      thisWeek: PeriodStats.fromJson(data['thisWeek']),
      thisMonth: PeriodStats.fromJson(data['thisMonth']),
      allTime: PeriodStats.fromJson(data['allTime']),
      performance: Performance.fromJson(data['performance']),
    );
  }
}

class PeriodStats {
  final int earnedPoints;
  final int completedTasks;
  final int avgMinutes;
  final int consecutiveDays;
  final int totalTasks;
  final int refusedTasks;
  final int inReviewTasks;
  final int completedTasksCount;

  PeriodStats({
    required this.earnedPoints,
    required this.completedTasks,
    required this.avgMinutes,
    required this.consecutiveDays,
    required this.totalTasks,
    required this.refusedTasks,
    required this.inReviewTasks,
    required this.completedTasksCount,
  });

  factory PeriodStats.fromJson(Map<String, dynamic> json) {
    return PeriodStats(
      earnedPoints: json['earnedPoints'] ?? 0,
      completedTasks: json['completedTasks'] ?? 0,
      avgMinutes: json['avgMinutes'] ?? 0,
      consecutiveDays: json['consecutiveDays'] ?? 0,
      totalTasks: json['totalTasks'] ?? 0,
      refusedTasks: json['refusedTasks'] ?? 0,
      inReviewTasks: json['inReviewTasks'] ?? 0,
      completedTasksCount: json['completedTasksCount'] ?? 0,
    );
  }
}

class Performance {
  final int improvementPercentage;
  final String improvementText;
  final PerformancePeriod currentPeriod;
  final PerformancePeriod previousPeriod;

  Performance({
    required this.improvementPercentage,
    required this.improvementText,
    required this.currentPeriod,
    required this.previousPeriod,
  });

  factory Performance.fromJson(Map<String, dynamic> json) {
    return Performance(
      improvementPercentage: json['improvementPercentage'] ?? 0,
      improvementText: json['improvementText'] ?? '',
      currentPeriod: PerformancePeriod.fromJson(json['currentPeriod']),
      previousPeriod: PerformancePeriod.fromJson(json['previousPeriod']),
    );
  }
}

class PerformancePeriod {
  final int earnedPoints;
  final int completedTasks;

  PerformancePeriod({required this.earnedPoints, required this.completedTasks});

  factory PerformancePeriod.fromJson(Map<String, dynamic> json) {
    return PerformancePeriod(
      earnedPoints: json['earnedPoints'] ?? 0,
      completedTasks: json['completedTasks'] ?? 0,
    );
  }
}

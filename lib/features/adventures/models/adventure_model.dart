class AdventureModel {
  final String weeklyAdventureId;
  final String adventureId;
  final String titleEn;
  final String titleAr;
  final String descriptionEn;
  final String descriptionAr;
  final String? bannerImageUrl;
  final String descriptionVoiceUrl;

  final int totalDays;
  final int currentDay;
  final int bonusPoints;

  final String status;
  final DateTime startDate;
  final DateTime endDate;

  final int completedTasksCount;
  final int totalTasksCount;

  final int earnedStars;
  final int earnedPoints;

  final bool isCompleted;

  final List<DayStatusModel> daysStatus;

  AdventureModel({
    required this.weeklyAdventureId,
    required this.adventureId,
    required this.titleEn,
    required this.titleAr,
    required this.descriptionEn,
    required this.descriptionAr,
    required this.bannerImageUrl,
    required this.descriptionVoiceUrl,
    required this.totalDays,
    required this.currentDay,
    required this.bonusPoints,
    required this.status,
    required this.startDate,
    required this.endDate,
    required this.completedTasksCount,
    required this.totalTasksCount,
    required this.earnedStars,
    required this.earnedPoints,
    required this.isCompleted,
    required this.daysStatus,
  });

  factory AdventureModel.fromJson(Map<String, dynamic> json) {
    return AdventureModel(
      weeklyAdventureId: json['weeklyAdventureId'],
      adventureId: json['adventureId'],

      titleEn: json['titleEn'] ?? "",
      titleAr: json['titleAr'] ?? "",

      descriptionEn: json['descriptionEn'] ?? "",
      descriptionAr: json['descriptionAr'] ?? "",

      bannerImageUrl: json['bannerImageUrl'],
      descriptionVoiceUrl: json['descriptionVoiceUrl'] ?? "",

      totalDays: json['totalDays'] ?? 0,
      currentDay: json['currentDay'] ?? 0,
      bonusPoints: json['bonusPoints'] ?? 0,

      status: json['status'] ?? "",

      startDate: DateTime.parse(json['startDate']),
      endDate: DateTime.parse(json['endDate']),

      completedTasksCount: json['completedTasksCount'] ?? 0,
      totalTasksCount: json['totalTasksCount'] ?? 0,

      earnedStars: json['earnedStars'] ?? 0,
      earnedPoints: json['earnedPoints'] ?? 0,

      isCompleted: json['isCompleted'] ?? false,

      daysStatus:
          (json['daysStatus'] as List<dynamic>?)
              ?.map((e) => DayStatusModel.fromJson(e))
              .toList() ??
          [],
    );
  }
}

class DayStatusModel {
  final int dayNumber;
  final String status;

  DayStatusModel({required this.dayNumber, required this.status});

  factory DayStatusModel.fromJson(Map<String, dynamic> json) {
    return DayStatusModel(
      dayNumber: json['dayNumber'] ?? 0,
      status: json['status'] ?? "",
    );
  }
}

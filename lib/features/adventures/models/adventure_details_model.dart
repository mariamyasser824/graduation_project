import 'package:rewarding_kids/features/adventures/models/adv_task_model.dart';
import 'package:rewarding_kids/features/child/data/models/task_model.dart';

class AdventureDetailsModel {
  final String weeklyAdventureId;
  final String adventureId;

  final String titleEn;
  final String titleAr;

  final String descriptionEn;
  final String descriptionAr;

  final String goalEn;
  final String goalAr;

  final String? descriptionVoiceUrl;

  final int bonusPoints;
  final int totalDays;
  final int currentDay;

  final String status;

  final int completedTasksCount;
  final int earnedStars;
  final int earnedPoints;

  final bool isCompleted;

  final List<AdvTaskModel> tasks;

  AdventureDetailsModel({
    required this.weeklyAdventureId,
    required this.adventureId,
    required this.titleEn,
    required this.titleAr,
    required this.descriptionEn,
    required this.descriptionAr,
    required this.goalEn,
    required this.goalAr,
    this.descriptionVoiceUrl,
    required this.bonusPoints,
    required this.totalDays,
    required this.currentDay,
    required this.status,
    required this.completedTasksCount,
    required this.earnedStars,
    required this.earnedPoints,
    required this.isCompleted,
    required this.tasks,
  });

  factory AdventureDetailsModel.fromJson(Map<String, dynamic> json) {
    return AdventureDetailsModel(
      weeklyAdventureId: json['weeklyAdventureId'],
      adventureId: json['adventureId'],

      titleEn: json['titleEn'] ?? "",
      titleAr: json['titleAr'] ?? "",

      descriptionEn: json['descriptionEn'] ?? "",
      descriptionAr: json['descriptionAr'] ?? "",

      goalEn: json['goalEn'] ?? "",
      goalAr: json['goalAr'] ?? "",

      descriptionVoiceUrl: json['descriptionVoiceUrl'],

      bonusPoints: json['bonusPoints'] ?? 0,
      totalDays: json['totalDays'] ?? 0,
      currentDay: json['currentDay'] ?? 0,

      status: json['status'] ?? "",

      completedTasksCount: json['completedTasksCount'] ?? 0,
      earnedStars: json['earnedStars'] ?? 0,
      earnedPoints: json['earnedPoints'] ?? 0,

      isCompleted: json['isCompleted'] ?? false,

      tasks: (json['tasks'] as List)
          .map((e) => AdvTaskModel.fromJson(e))
          .toList(),
    );
  }
}

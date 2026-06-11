class AdvTaskModel {
  final String adventureTaskId;
  final String taskTemplateId;

  final String titleEn;
  final String titleAr;

  final int dayNumber;

  final String? storyText;
  final String? storyVoiceUrl;

  final int stars;

  final String accessStatus;
  final String submissionStatus;

  final String? evidenceUrl;

  final int earnedStars;
  final String? submittedAt;

  AdvTaskModel({
    required this.adventureTaskId,
    required this.taskTemplateId,
    required this.titleEn,
    required this.titleAr,
    required this.dayNumber,
    this.storyText,
    this.storyVoiceUrl,
    required this.stars,
    required this.accessStatus,
    required this.submissionStatus,
    this.evidenceUrl,
    required this.earnedStars,
    this.submittedAt,
  });

  factory AdvTaskModel.fromJson(Map<String, dynamic> json) {
    return AdvTaskModel(
      adventureTaskId: json['adventureTaskId'],
      taskTemplateId: json['taskTemplateId'],

      titleEn: json['titleEn'] ?? "",
      titleAr: json['titleAr'] ?? "",

      dayNumber: json['dayNumber'] ?? 0,

      storyText: json['storyText'],
      storyVoiceUrl: json['storyVoiceUrl'],

      stars: json['stars'] ?? 0,

      accessStatus: json['accessStatus'] ?? "",
      submissionStatus: json['submissionStatus'] ?? "",

      evidenceUrl: json['evidenceUrl'],

      earnedStars: json['earnedStars'] ?? 0,
      submittedAt: json['submittedAt'],
    );
  }
}

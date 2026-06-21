enum AdvTaskType { voice, image, auto }

AdvTaskType mapTaskType(String? type) {
  switch (type) {
    case "VoiceQuestion":
      return AdvTaskType.voice;
    case "EvidenceSubmission":
      return AdvTaskType.image;
    case "InstantReward":
      return AdvTaskType.auto;
    default:
      return AdvTaskType.auto;
  }
}

class AdvTaskModel {
  final String adventureTaskId;
  final String taskTemplateId;

  final int dayNumber;

  final String titleEn;
  final String titleAr;

  final String? storyText;
  final String? storyVoiceUrl;

  final int stars;

  final String accessStatus; // Locked / Unlocked / Done
  final String submissionStatus; // NotSubmitted / Pending / Approved / Missed

  final String? evidenceUrl;

  final int earnedStars;

  final DateTime? submittedAt;
  final AdvTaskType type;
  final String weeklyAdventureId;

  AdvTaskModel({
    required this.adventureTaskId,
    required this.taskTemplateId,
    required this.dayNumber,
    required this.titleEn,
    required this.titleAr,
    required this.storyText,
    required this.storyVoiceUrl,
    required this.stars,
    required this.accessStatus,
    required this.submissionStatus,
    required this.evidenceUrl,
    required this.earnedStars,
    required this.submittedAt,
    required this.type,
    required this.weeklyAdventureId,
  });

  factory AdvTaskModel.fromJson(
    Map<String, dynamic> json, {
    required String weeklyAdventureId,
  }) {
    return AdvTaskModel(
      adventureTaskId: json['adventureTaskId'] ?? '',
      taskTemplateId: json['taskTemplateId'] ?? '',

      dayNumber: json['dayNumber'] ?? 0,

      titleEn: json['titleEn'] ?? '',
      titleAr: json['titleAr'] ?? '',

      storyText: json['storyText'],
      storyVoiceUrl: json['storyVoiceUrl'],

      stars: json['stars'] ?? 0,

      accessStatus: json['accessStatus'] ?? '',
      submissionStatus: json['submissionStatus'] ?? '',

      evidenceUrl: json['evidenceUrl'],

      earnedStars: json['earnedStars'] ?? 0,

      submittedAt: json['submittedAt'] != null
          ? DateTime.parse(json['submittedAt'])
          : null,
      type: mapTaskType(json['type']),
      weeklyAdventureId: weeklyAdventureId,
    );
  }
}

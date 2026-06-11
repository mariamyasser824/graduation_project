class ChildTask {
  final String childTaskId;
  final String childId;
  final String childName;
  final String taskTemplateId;
  final String titleAr;
  final String titleEn;
  final String? iconUrl;
  final int points;
  final String status;
  final DateTime assignedAt;
  final DateTime? dueDate;
  final DateTime? completedAt;
  final DateTime? reviewRequestedAt;
  final String? rejectionReason;

  final String? childNote; // ✅ NEW
  final String? answerMediaUrl; // ✅ FIXED

  ChildTask({
    required this.childTaskId,
    required this.childId,
    required this.childName,
    required this.taskTemplateId,
    required this.titleAr,
    required this.titleEn,
    this.iconUrl,
    required this.points,
    required this.status,
    required this.assignedAt,
    this.dueDate,
    this.completedAt,
    this.reviewRequestedAt,
    this.rejectionReason,
    this.childNote,
    this.answerMediaUrl,
  });

  factory ChildTask.fromJson(Map<String, dynamic> json) {
    return ChildTask(
      childTaskId: json['childTaskId'],
      childId: json['childId'],
      childName: json['childName'],
      taskTemplateId: json['taskTemplateId'],
      titleAr: json['titleAr'],
      titleEn: json['titleEn'],
      iconUrl: json['iconUrl'],
      points: json['points'],
      status: json['status'],
      assignedAt: DateTime.parse(json['assignedAt']),
      dueDate: json['dueDate'] != null
          ? DateTime.tryParse(json['dueDate'])
          : null,
      completedAt: json['completedAt'] != null
          ? DateTime.tryParse(json['completedAt'])
          : null,
      reviewRequestedAt: json['reviewRequestedAt'] != null
          ? DateTime.tryParse(json['reviewRequestedAt'])
          : null,
      rejectionReason: json['rejectionReason'],

      childNote: json['childNote'], // ✅
      answerMediaUrl: json['answerMediaUrl'], // ✅
    );
  }
}

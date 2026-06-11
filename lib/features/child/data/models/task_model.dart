class TaskModel {
  final String id;
  final String titleAr;
  final String titleEn;
  final String descriptionAr;
  final String descriptionEn;
  final String? iconUrl;
  final String subCategoryId;
  final String subCategoryNameEn;
  final String difficulty;
  final int basePoints;
  final String templateType;
  final DateTime createdAt;

  TaskModel({
    required this.id,
    required this.titleAr,
    required this.titleEn,
    required this.descriptionAr,
    required this.descriptionEn,
    required this.iconUrl,
    required this.subCategoryId,
    required this.subCategoryNameEn,
    required this.difficulty,
    required this.basePoints,
    required this.templateType,
    required this.createdAt,
  });

  /// =============================
  /// 🔹 Factory
  /// =============================
  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      id: json['id']?.toString() ?? '',
      titleAr: json['titleAr'] ?? '',
      titleEn: json['titleEn'] ?? '',
      descriptionAr: json['descriptionAr'] ?? '',
      descriptionEn: json['descriptionEn'] ?? '',
      iconUrl: json['iconUrl'], // nullable عادي
      subCategoryId: json['subCategoryId']?.toString() ?? '',
      subCategoryNameEn: json['subCategoryNameEn'] ?? '',
      difficulty: json['difficulty'] ?? '',
      basePoints: json['basePoints'] is int
          ? json['basePoints']
          : int.tryParse(json['basePoints']?.toString() ?? '0') ?? 0,
      templateType: json['templateType'] ?? '',
      createdAt: DateTime.tryParse(json['createdAt'] ?? '') ?? DateTime.now(),
    );
  }

  /// =============================
  /// 🔹 Safe Getters
  /// =============================

  /// صورة آمنة دايمًا
  String get safeIconUrl {
    if (iconUrl == null || iconUrl!.isEmpty) {
      return 'assets/child/drawflower.jpg';
    }
    return iconUrl!;
  }

  /// هل فيه صورة ولا لأ
  bool get hasIcon => iconUrl != null && iconUrl!.isNotEmpty;

  /// عنوان حسب اللغة
  String getTitle({bool isArabic = false}) {
    return isArabic ? titleAr : titleEn;
  }

  /// وصف حسب اللغة
  String getDescription({bool isArabic = false}) {
    return isArabic ? descriptionAr : descriptionEn;
  }

  /// نوع المهمة مختصر
  bool get isVoice => templateType == "VoiceQuestion";
  bool get isImage => templateType == "EvidenceSubmission";
  bool get isInstant => templateType == "InstantReward";

  /// =============================
  /// 🔹 ToJson (لو احتجتي ترجعيه)
  /// =============================
  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "titleAr": titleAr,
      "titleEn": titleEn,
      "descriptionAr": descriptionAr,
      "descriptionEn": descriptionEn,
      "iconUrl": iconUrl,
      "subCategoryId": subCategoryId,
      "subCategoryNameEn": subCategoryNameEn,
      "difficulty": difficulty,
      "basePoints": basePoints,
      "templateType": templateType,
      "createdAt": createdAt.toIso8601String(),
    };
  }
}

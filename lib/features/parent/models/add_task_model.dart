class AddTaskModel {
  final String id;
  final String title;
  final String description;
  final String subCategory;
  final String level;
  final int rewardPoints;
  final String iconUrl;

  AddTaskModel({
    required this.id,
    required this.title,
    required this.description,
    required this.subCategory,
    required this.level,
    required this.rewardPoints,
    required this.iconUrl,
  });

  factory AddTaskModel.fromJson(Map<String, dynamic> json) {
    return AddTaskModel(
      id: json['id'],
      title: json['titleEn'] ?? json['titleAr'] ?? '',
      description: json['descriptionEn'] ?? json['descriptionAr'] ?? '',
      subCategory: json['subCategoryNameEn'] ?? '',
      level: json['difficulty'] ?? '',
      rewardPoints: json['basePoints'] ?? 0,
      iconUrl: json['iconUrl'] ?? '',
    );
  }
}

class RewardModel {
  final String id;
  final String nameEn;
  final String nameAr;
  final String descriptionEn;
  final String descriptionAr;
  final int targetPoints;
  final String image;
  final bool targetReached;

  RewardModel({
    required this.id,
    required this.nameEn,
    required this.nameAr,
    required this.descriptionEn,
    required this.descriptionAr,
    required this.targetPoints,
    required this.image,
    required this.targetReached,
  });

  factory RewardModel.fromJson(Map<String, dynamic> json) {
    return RewardModel(
      id: json['id'] ?? '',
      nameEn: json['nameEn'] ?? '',
      nameAr: json['nameAr'] ?? '',
      descriptionEn: json['descriptionEn'] ?? '',
      descriptionAr: json['descriptionAr'] ?? '',
      targetPoints: json['targetPoints'] ?? 0,

      // 🔥 التعديل هنا
      image: json['imageUrl'] ?? '',

      targetReached: json['targetReached'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nameEn': nameEn,
      'nameAr': nameAr,
      'descriptionEn': descriptionEn,
      'descriptionAr': descriptionAr,
      'targetPoints': targetPoints,
      'image': image,
      'targetReached': targetReached,
    };
  }
}

class SubCategoryModel {
  final String id;
  final String name;

  SubCategoryModel({required this.id, required this.name});

  factory SubCategoryModel.fromJson(Map<String, dynamic> json) {
    return SubCategoryModel(
      id: json['id'],
      name: json['nameEn'] ?? json['nameAr'] ?? '', // <== هنا
    );
  }
}

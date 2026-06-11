class GiftModel {
  final String id;
  final String name;
  final String image;
  final int points;

  GiftModel({
    required this.id,
    required this.name,
    required this.image,
    required this.points,
  });

  factory GiftModel.fromJson(Map<String, dynamic> json) {
    return GiftModel(
      id: json['id'],
      name: json['nameEn'], // أو nameAr
      image: json['imageUrl'],
      points: json['pointsCost'],
    );
  }
}

class GiftsResponse {
  final List<GiftModel> gifts;

  GiftsResponse({required this.gifts});

  factory GiftsResponse.fromJson(Map<String, dynamic> json) {
    final items = json['data']['items'] as List;

    return GiftsResponse(
      gifts: items.map((e) => GiftModel.fromJson(e)).toList(),
    );
  }
}

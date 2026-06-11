class RankingModel {
  final List<RankingUser> topRanking;
  final RankingUser? myRank;

  RankingModel({required this.topRanking, this.myRank});

  factory RankingModel.fromJson(Map<String, dynamic> json) {
    return RankingModel(
      topRanking: List<RankingUser>.from(
        json['topRanking'].map((x) => RankingUser.fromJson(x)),
      ),
      myRank: json['myRank'] != null
          ? RankingUser.fromJson(json['myRank'])
          : null,
    );
  }
}

class RankingUser {
  final int rank;
  final String childName;
  final String? avatarUrl;
  final int highestPoints;
  final bool isCurrentChild;

  RankingUser({
    required this.rank,
    required this.childName,
    required this.avatarUrl,
    required this.highestPoints,
    required this.isCurrentChild,
  });

  factory RankingUser.fromJson(Map<String, dynamic> json) {
    return RankingUser(
      rank: json['rank'],
      childName: json['childName'],
      avatarUrl: json['avatarUrl'],
      highestPoints: json['highestPoints'],
      isCurrentChild: json['isCurrentChild'],
    );
  }
}

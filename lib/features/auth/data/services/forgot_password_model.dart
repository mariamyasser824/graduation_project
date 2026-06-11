class ForgotPasswordModel {
  final String userId;

  ForgotPasswordModel({required this.userId});

  factory ForgotPasswordModel.fromJson(Map<String, dynamic> json) {
    return ForgotPasswordModel(userId: json["data"]["userId"]);
  }
}

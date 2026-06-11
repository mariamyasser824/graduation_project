class ResetPasswordModel {
  final String userId;
  final String email;

  ResetPasswordModel({required this.userId, required this.email});

  factory ResetPasswordModel.fromJson(Map<String, dynamic> json) {
    return ResetPasswordModel(
      userId: json["data"]["userId"],
      email: json["data"]["email"],
    );
  }
}

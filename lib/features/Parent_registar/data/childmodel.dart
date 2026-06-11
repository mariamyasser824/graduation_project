class ChildModel {
  final String name;
  final String? nickName;
  final int age;
  final String gender;
  final String relationship;
  final String registrationCode;
  final String qrCodeBase64;

  ChildModel({
    required this.name,
    this.nickName,
    required this.age,
    required this.gender,
    required this.relationship,
    required this.registrationCode,
    required this.qrCodeBase64,
  });

  factory ChildModel.fromJson(Map<String, dynamic> json) {
    final data = json['data'] ?? json;

    return ChildModel(
      name: data['childName'] ?? 'Unknown',
      nickName: data['nickName'] ?? '',
      age: data['age'] ?? 0,
      gender: data['gender'] ?? '',
      relationship: data['relationshipToParent'] ?? '',
      registrationCode: data['registrationCode'] ?? 'No Code',
      qrCodeBase64:
          (data['qrCodeBase64'] != null &&
              data['qrCodeBase64'] != 'qr-code-placeholder')
          ? data['qrCodeBase64']
          : '', // فاضي لو placeholder
    );
  }
}

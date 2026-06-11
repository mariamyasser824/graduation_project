class SubmitTaskResponse {
  final bool succeeded;
  final String? message;
  final SubmitTaskData? data;

  SubmitTaskResponse({required this.succeeded, this.message, this.data});

  factory SubmitTaskResponse.fromJson(Map<String, dynamic> json) {
    return SubmitTaskResponse(
      succeeded: json['succeeded'] ?? false,
      message: json['message'],
      data: json['data'] != null ? SubmitTaskData.fromJson(json['data']) : null,
    );
  }
}

class SubmitTaskData {
  final String? taskId;
  final String? status;
  final int? awardedPoints;
  final String? message;
  final ShadowingResult? shadowingResult;

  SubmitTaskData({
    this.taskId,
    this.status,
    this.awardedPoints,
    this.message,
    this.shadowingResult,
  });

  factory SubmitTaskData.fromJson(Map<String, dynamic> json) {
    return SubmitTaskData(
      taskId: json['taskId']?.toString(),
      status: json['status']?.toString(),
      awardedPoints: json['awardedPoints'],
      message: json['message']?.toString(),
      shadowingResult: json['shadowingResult'] != null
          ? ShadowingResult.fromJson(json['shadowingResult'])
          : null,
    );
  }
}

class ShadowingResult {
  final List<WordModel> words;
  final String? scoreStatus;

  ShadowingResult({required this.words, this.scoreStatus});

  factory ShadowingResult.fromJson(Map<String, dynamic> json) {
    return ShadowingResult(
      scoreStatus: json['scoreStatus'],
      words: json['words'] != null
          ? (json['words'] as List).map((e) => WordModel.fromJson(e)).toList()
          : [],
    );
  }
}

class WordModel {
  final String word;
  final String color;

  WordModel({required this.word, required this.color});

  factory WordModel.fromJson(Map<String, dynamic> json) {
    return WordModel(word: json['word'] ?? "", color: json['color'] ?? "gray");
  }
}

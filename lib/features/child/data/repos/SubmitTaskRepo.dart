import 'package:dio/dio.dart';
import 'package:rewarding_kids/core/network/api_constants.dart';
import 'package:rewarding_kids/core/network/api_service.dart';
import 'package:rewarding_kids/features/child/data/models/SubmitTaskResponseModel.dart';

class SubmitTaskRepo {
  final ApiService _api = ApiService();

  Future<SubmitTaskResponse> submitTask({
    required String taskId,
    String? voicePath,
    String? imagePath,
    String? comment,
  }) async {
    FormData data = FormData.fromMap({
      "TaskId": taskId,

      if (voicePath != null)
        "VoiceFile": await MultipartFile.fromFile(
          voicePath,
          filename: voicePath.split('/').last,
        ),

      if (imagePath != null)
        "EvidenceFile": await MultipartFile.fromFile(
          imagePath,
          filename: imagePath.split('/').last,
        ),

      if (comment != null) "Comment": comment,
    });

    final response = await _api.post(ApiConstants.submitTask(taskId), data);

    if (response["succeeded"] == true) {
      return SubmitTaskResponse.fromJson(response);
    } else {
      throw Exception(response["message"]);
    }
  }
}

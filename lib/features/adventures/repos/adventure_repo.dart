import 'dart:io';
import 'package:dio/dio.dart';
import 'package:rewarding_kids/core/network/api_constants.dart';
import 'package:rewarding_kids/core/network/api_service.dart';
import 'package:rewarding_kids/features/adventures/models/adv_task_model.dart';
import 'package:rewarding_kids/features/adventures/models/adventure_details_model.dart';
import 'package:rewarding_kids/features/adventures/models/adventure_model.dart';

class AdventureRepo {
  final ApiService apiService;

  AdventureRepo(this.apiService);

  /// 🟢 Get All Adventures
  Future<List<AdventureModel>> getAdventures() async {
    final response = await apiService.get(ApiConstants.getChildAdventures);

    final List data = response['data'];

    return data.map((e) => AdventureModel.fromJson(e)).toList();
  }

  /// 🟢 Get Details
  Future<AdventureDetailsModel> getAdventureDetails(String id) async {
    final response = await apiService.get(ApiConstants.getAdventureDetails(id));

    return AdventureDetailsModel.fromJson(response['data']);
  }

  /* 
  Get Tasks
  Future<List<AdvTaskModel>> getAdventureTasks(String id) async {
    final response = await apiService.get(ApiConstants.getAdventureTasks(id));

    final List data = response['data']['tasks'];

    return data.map((e) => AdvTaskModel.fromJson(e)).toList();
  }*/

  Future<dynamic> submitTask({
    required String adventureTaskId,
    required String weeklyAdventureId,
    File? voiceFile,
    File? imageFile,
    String? comment,
  }) async {
    final formData = FormData.fromMap({
      "AdventureTaskId": adventureTaskId,
      "WeeklyAdventureId": weeklyAdventureId,

      if (voiceFile != null)
        "VoiceFile": await MultipartFile.fromFile(
          voiceFile.path,
          filename: "voice.wav",
        ),

      if (imageFile != null)
        "EvidenceFile": await MultipartFile.fromFile(
          imageFile.path,
          filename: "image.jpg",
        ),

      if (comment != null) "Comment": comment,
    });

    await apiService.post(
      ApiConstants.submitAdventureTask,
      formData, // 👈 هنا الصح
    );
    final response = await apiService.post(
      ApiConstants.submitAdventureTask,
      formData,
    );

    return response;
  }
}

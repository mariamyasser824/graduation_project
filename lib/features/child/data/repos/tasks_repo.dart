import 'package:rewarding_kids/core/network/api_constants.dart';
import 'package:rewarding_kids/core/network/api_service.dart';
import 'package:rewarding_kids/features/child/data/models/task_model.dart';

class TasksRepo {
  final ApiService _api = ApiService();

  Future<List<TaskModel>> getTasks(String source) async {
    final response = await _api.get(
      "${ApiConstants.getTasks}?SourceFilter=$source",
    );

    if (response["succeeded"] == true) {
      final List data = response["data"];

      return data.map((e) => TaskModel.fromJson(e)).toList();
    } else {
      throw Exception(response["message"]);
    }
  }
}

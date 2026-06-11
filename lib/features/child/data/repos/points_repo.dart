import 'package:rewarding_kids/core/network/api_constants.dart';
import 'package:rewarding_kids/core/network/api_service.dart';
import '../models/points_model.dart';

class PointsRepo {
  final ApiService _api = ApiService();

  Future<PointsModel> getPoints() async {
    final response = await _api.get(ApiConstants.getChildPoints);

    if (response["succeeded"] == true) {
      return PointsModel.fromJson(response["data"]);
    } else {
      throw Exception(response["message"]);
    }
  }
}

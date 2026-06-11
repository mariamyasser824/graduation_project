import 'package:rewarding_kids/core/network/api_service.dart';
import 'package:rewarding_kids/features/parent/models/statistics_model.dart';

class StatisticsRepo {
  final ApiService apiService;

  StatisticsRepo(this.apiService);

  Future<StatisticsModel> getStatistics(String period) async {
    final response = await apiService.get("/api/Statistics?period=$period");

    return StatisticsModel.fromJson(response);
  }
}

import 'package:rewarding_kids/core/network/api_constants.dart';
import 'package:rewarding_kids/core/network/api_service.dart';
import 'package:rewarding_kids/features/adventures/models/ranking_model.dart';

class RankingRepo {
  final ApiService apiService;

  RankingRepo(this.apiService);

  Future<RankingModel> getGlobalRanking(int topCount) async {
    final response = await apiService.get(
      "${ApiConstants.globalRanking}?topCount=$topCount",
    );

    return RankingModel.fromJson(response['data']);
  }

  Future<RankingModel> getInstitutionRanking(int topCount) async {
    final response = await apiService.get(
      "${ApiConstants.institutionRanking}?topCount=$topCount",
    );

    return RankingModel.fromJson(response['data']);
  }
}

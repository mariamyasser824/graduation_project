import 'package:dio/dio.dart';
import 'package:rewarding_kids/core/network/api_constants.dart';
import 'package:rewarding_kids/features/parent/models/reward_model.dart';

class RewardRepository {
  final Dio dio;

  RewardRepository(this.dio);

  /// 📥 Get Rewards
  Future<List<RewardModel>> getRewards() async {
    print("🔥 API CALLED");

    final response = await dio.get(ApiConstants.getRewards);

    print("🔥 RESPONSE: ${response.data}");

    final data = response.data['data'];

    return (data as List).map((e) => RewardModel.fromJson(e)).toList();
  }

  /// 🎁 Give Reward
  Future<void> giveReward(String rewardId) async {
    await dio.put(ApiConstants.giveReward(rewardId));
  }

  /// ➕ Create Reward
  Future<void> createReward(FormData data) async {
    await dio.post(ApiConstants.createReward, data: data);
  }

  /// ❌ Delete Reward
  Future<void> deleteReward(String rewardId) async {
    await dio.delete(ApiConstants.deleteReward(rewardId));
  }
}

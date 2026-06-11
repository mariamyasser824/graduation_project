import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rewarding_kids/features/parent/cubit/reward_cubit/reward_state.dart';
import 'package:rewarding_kids/features/parent/repos/Reward_repo.dart';

class RewardCubit extends Cubit<RewardState> {
  final RewardRepository repository;

  RewardCubit(this.repository) : super(RewardInitial());

  /// 📥 Get Rewards
  Future<void> getRewards() async {
    emit(RewardLoading());

    try {
      final rewards = await repository.getRewards();
      emit(RewardSuccess(rewards));
    } catch (e) {
      emit(RewardError(e.toString()));
    }
  }

  /// 🎁 Give Reward
  Future<void> giveReward(String rewardId) async {
    emit(GiveRewardLoading());

    try {
      await repository.giveReward(rewardId);
      emit(GiveRewardSuccess());

      /// نعمل refresh بعد ما ندي الجيفت 🔥
      getRewards();
    } catch (e) {
      emit(GiveRewardError(e.toString()));
    }
  }

  Future<void> createReward(FormData data) async {
    emit(RewardLoading());

    try {
      await repository.createReward(data);
      emit(RewardSuccess([])); // هنعمل refresh بعدين
      getRewards();
    } catch (e) {
      emit(RewardError(e.toString()));
    }
  }

  Future<void> deleteReward(String id) async {
    emit(RewardLoading());

    try {
      await repository.deleteReward(id);
      getRewards(); // refresh
    } catch (e) {
      emit(RewardError(e.toString()));
    }
  }
}

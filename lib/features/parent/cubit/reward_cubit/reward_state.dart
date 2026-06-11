import 'package:rewarding_kids/features/parent/models/reward_model.dart';

abstract class RewardState {}

class RewardInitial extends RewardState {}

class RewardLoading extends RewardState {}

class RewardSuccess extends RewardState {
  final List<RewardModel> rewards;

  RewardSuccess(this.rewards);
}

class RewardError extends RewardState {
  final String message;

  RewardError(this.message);
}

/// حالة خاصة بالـ Give
class GiveRewardLoading extends RewardState {}

class GiveRewardSuccess extends RewardState {}

class GiveRewardError extends RewardState {
  final String message;

  GiveRewardError(this.message);
}

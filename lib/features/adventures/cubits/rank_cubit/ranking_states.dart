import 'package:rewarding_kids/features/adventures/models/ranking_model.dart';

abstract class RankingEvent {}

class GetGlobalRanking extends RankingEvent {}

class GetInstitutionRanking extends RankingEvent {}

abstract class RankingState {}

class RankingInitial extends RankingState {}

class RankingLoading extends RankingState {}

class RankingSuccess extends RankingState {
  final RankingModel data;

  RankingSuccess(this.data);
}

class RankingError extends RankingState {
  final String message;

  RankingError(this.message);
}

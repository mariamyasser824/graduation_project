import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rewarding_kids/features/adventures/cubits/rank_cubit/ranking_states.dart';
import 'package:rewarding_kids/features/adventures/repos/ranking_repo.dart';

class RankingBloc extends Bloc<RankingEvent, RankingState> {
  final RankingRepo repo;

  RankingBloc(this.repo) : super(RankingInitial()) {
    on<GetGlobalRanking>(_getGlobal);
    on<GetInstitutionRanking>(_getInstitution);
  }

  Future<void> _getGlobal(
    GetGlobalRanking event,
    Emitter<RankingState> emit,
  ) async {
    emit(RankingLoading());
    try {
      final data = await repo.getGlobalRanking(20);
      emit(RankingSuccess(data));
    } catch (e) {
      emit(RankingError(e.toString()));
    }
  }

  Future<void> _getInstitution(
    GetInstitutionRanking event,
    Emitter<RankingState> emit,
  ) async {
    emit(RankingLoading());
    try {
      final data = await repo.getInstitutionRanking(3);
      emit(RankingSuccess(data));
    } catch (e) {
      emit(RankingError(e.toString()));
    }
  }
}

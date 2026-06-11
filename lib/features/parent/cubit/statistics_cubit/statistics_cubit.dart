import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rewarding_kids/features/parent/repos/statistics_repo.dart';
import 'statistics_state.dart';

class StatisticsCubit extends Cubit<StatisticsState> {
  final StatisticsRepo repo;

  StatisticsCubit(this.repo) : super(StatisticsInitial());

  Future<void> getStatistics(String period) async {
    emit(StatisticsLoading());

    try {
      final data = await repo.getStatistics(period);
      emit(StatisticsSuccess(data));
    } catch (e) {
      emit(StatisticsError(e.toString()));
    }
  }
}

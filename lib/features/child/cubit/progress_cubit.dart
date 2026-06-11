import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rewarding_kids/features/child/data/repos/points_repo.dart';
import 'progress_state.dart';

class ProgressCubit extends Cubit<ProgressState> {
  final PointsRepo repo;

  ProgressCubit(this.repo)
    : super(
        const ProgressState(
          totalPoints: 0,
          goalPoints: 100,
          showCelebration: false,
          status: ProgressStatus.initial,
        ),
      );

  /// 🟢 Fetch from API
  Future<void> fetchPoints() async {
    emit(state.copyWith(status: ProgressStatus.loading));

    try {
      final result = await repo.getPoints();

      emit(
        state.copyWith(
          totalPoints: result.totalPoints,
          status: ProgressStatus.success,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: ProgressStatus.error,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  void addPoints(int value) {
    emit(state.copyWith(totalPoints: state.totalPoints + value));
  }

  void completeTask(int rewardPoints) {
    addPoints(rewardPoints);

    emit(state.copyWith(showCelebration: true));

    Future.delayed(const Duration(seconds: 2), () {
      emit(state.copyWith(showCelebration: false));
    });
  }
}

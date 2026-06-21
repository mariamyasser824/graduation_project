import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rewarding_kids/features/child/cubit/SubmitTaskState%20.dart';
import 'package:rewarding_kids/features/child/data/repos/SubmitTaskRepo.dart';

enum SubmitType { normal, adventure }

class SubmitTaskCubit extends Cubit<SubmitTaskState> {
  final SubmitTaskRepo repo;

  SubmitTaskCubit(this.repo) : super(const SubmitTaskState());
  Future<void> submit({
    required SubmitType type,

    // 🟢 normal
    String? taskId,

    // 🔥 adventure
    String? adventureTaskId,
    String? weeklyAdventureId,

    String? voicePath,
    String? imagePath,
    String? comment,
  }) async {
    emit(state.copyWith(status: SubmitStatus.loading));

    try {
      late final result;

      if (type == SubmitType.normal) {
        result = await repo.submitTask(
          taskId: taskId!,
          voicePath: voicePath,
          imagePath: imagePath,
          comment: comment,
        );
      } else {
        result = await repo.submitAdventureTask(
          adventureTaskId: adventureTaskId!,
          weeklyAdventureId: weeklyAdventureId!,
          voicePath: voicePath,
          imagePath: imagePath,
          comment: comment,
        );
      }

      emit(state.copyWith(status: SubmitStatus.success, response: result));
    } catch (e) {
      emit(state.copyWith(status: SubmitStatus.error, error: e.toString()));
    }
  }
}

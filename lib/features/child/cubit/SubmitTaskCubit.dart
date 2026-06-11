import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rewarding_kids/features/child/cubit/SubmitTaskState%20.dart';
import 'package:rewarding_kids/features/child/data/repos/SubmitTaskRepo.dart';

class SubmitTaskCubit extends Cubit<SubmitTaskState> {
  final SubmitTaskRepo repo;

  SubmitTaskCubit(this.repo) : super(const SubmitTaskState());

  Future<void> submit({
    required String taskId,
    String? voicePath,
    String? imagePath,
    String? comment,
  }) async {
    emit(state.copyWith(status: SubmitStatus.loading));

    try {
      final result = await repo.submitTask(
        taskId: taskId,
        voicePath: voicePath,
        imagePath: imagePath,
        comment: comment,
      );

      emit(state.copyWith(status: SubmitStatus.success, response: result));
    } catch (e) {
      emit(state.copyWith(status: SubmitStatus.error, error: e.toString()));
    }
  }
}

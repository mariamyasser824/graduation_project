import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rewarding_kids/core/network/api_constants.dart';
import 'package:rewarding_kids/core/network/api_service.dart';
import 'package:rewarding_kids/features/parent/models/child_task_model.dart';

part 'task_review_state.dart';

class TaskReviewCubit extends Cubit<TaskReviewState> {
  TaskReviewCubit() : super(TaskReviewInitial());

  final ApiService api = ApiService();

  /// 🟢 Get Details
  Future<void> getTaskDetails(String taskId) async {
    emit(TaskReviewLoading());

    try {
      final response = await api.get(ApiConstants.getTaskDetails(taskId));

      final data = response['data'];
      final task = ChildTask.fromJson(data);

      emit(TaskReviewLoaded(task));
    } catch (e) {
      emit(TaskReviewError(e.toString()));
    }
  }

  Future<void> reviewTask({
    required String childTaskId,
    required bool isApproved,
    String? rejectionReason,
    String? acceptanceMessage,
  }) async {
    emit(TaskReviewActionLoading());

    try {
      final response = await api.post(ApiConstants.reviewTask, {
        "childTaskId": childTaskId,
        "isApproved": isApproved,
        "rejectionReason": rejectionReason,
        "acceptanceMessage": acceptanceMessage,
      });

      final status = response['data']['status'];

      if (status == "Completed") {
        emit(TaskApproved());
      } else if (status == "Rejected") {
        emit(TaskRejected());
      }
    } catch (e) {
      emit(TaskReviewError(e.toString()));
    }
  }
}

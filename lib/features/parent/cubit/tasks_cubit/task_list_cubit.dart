import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rewarding_kids/core/network/api_constants.dart';
import 'package:dio/dio.dart';
import 'package:rewarding_kids/core/network/api_service.dart';
import 'package:rewarding_kids/core/network/dio_client.dart';
import 'package:rewarding_kids/features/parent/models/child_task_model.dart';
import 'package:rewarding_kids/core/utils/pref_helper.dart';
part 'task_list_state.dart';

class TaskListCubit extends Cubit<TaskListState> {
  TaskListCubit() : super(TaskListState(loading: false, tasks: []));

  final ApiService api = ApiService();

  Future<void> fetchTasks({String? status}) async {
    emit(state.copyWith(loading: true, errorMessage: null));

    final childId = await PrefHelper.getChildId();

    try {
      final data = await api.get(
        ApiConstants.getParentTasks +
            "?childId=$childId" +
            (status != null && status != 'all' ? "&Status=$status" : ""),
      );

      final tasks = (data['data']['items'] as List)
          .map((json) => ChildTask.fromJson(json))
          .toList();

      emit(state.copyWith(loading: false, tasks: tasks));
    } catch (e) {
      emit(state.copyWith(loading: false, errorMessage: e.toString()));
    }
  }

  void changeStatus(TaskStatus status) {
    emit(state.copyWith(selectedStatus: status));
    fetchTasks(
      status: status == TaskStatus.all ? null : status.name,
    ); // لو الـ API يدعم فلترة حسب Status
  }
}

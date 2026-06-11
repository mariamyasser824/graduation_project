import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rewarding_kids/features/child/data/repos/tasks_repo.dart';

import 'tasks_state.dart';

class TasksCubit extends Cubit<TasksState> {
  final TasksRepo repo;

  TasksCubit(this.repo) : super(TasksInitial());

  Future<void> getTasks(String source) async {
    emit(TasksLoading());

    try {
      final tasks = await repo.getTasks(source);

      emit(TasksSuccess(tasks));
    } catch (e) {
      emit(TasksError(e.toString()));
    }
  }
}

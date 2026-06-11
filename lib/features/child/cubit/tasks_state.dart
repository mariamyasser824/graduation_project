import '../data/models/task_model.dart';

abstract class TasksState {}

class TasksInitial extends TasksState {}

class TasksLoading extends TasksState {}

class TasksSuccess extends TasksState {
  final List<TaskModel> tasks;

  TasksSuccess(this.tasks);
}

class TasksError extends TasksState {
  final String error;

  TasksError(this.error);
}

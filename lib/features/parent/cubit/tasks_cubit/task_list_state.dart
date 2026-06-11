part of 'task_list_cubit.dart';

enum TaskStatus {
  all,
  ReviewRequested,
  InProgress,
  completed,
  pending,
  rejected,
}

class TaskListState {
  final bool loading;
  final List<ChildTask> tasks;
  final String? errorMessage;
  final TaskStatus selectedStatus;

  TaskListState({
    required this.loading,
    required this.tasks,
    this.errorMessage,
    this.selectedStatus = TaskStatus.all,
  });

  TaskListState copyWith({
    bool? loading,
    List<ChildTask>? tasks,
    String? errorMessage,
    TaskStatus? selectedStatus,
  }) {
    return TaskListState(
      loading: loading ?? this.loading,
      tasks: tasks ?? this.tasks,
      errorMessage: errorMessage,
      selectedStatus: selectedStatus ?? this.selectedStatus,
    );
  }
}

part of 'task_review_cubit.dart';

abstract class TaskReviewState {}

class TaskReviewInitial extends TaskReviewState {}

class TaskReviewLoading extends TaskReviewState {}

class TaskReviewLoaded extends TaskReviewState {
  final ChildTask task;
  TaskReviewLoaded(this.task);
}

class TaskReviewActionLoading extends TaskReviewState {}

class TaskApproved extends TaskReviewState {}

class TaskRejected extends TaskReviewState {}

class TaskReviewError extends TaskReviewState {
  final String message;
  TaskReviewError(this.message);
}

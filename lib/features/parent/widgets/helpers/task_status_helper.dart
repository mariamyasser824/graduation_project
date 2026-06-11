import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rewarding_kids/features/parent/cubit/tasks_cubit/task_list_cubit.dart';

Color taskStatusColor(TaskStatus status) {
  switch (status) {
    case TaskStatus.completed:
      return Color(0xff00A600);
    case TaskStatus.pending:
      return Color(0xffE0B700);
    case TaskStatus.ReviewRequested:
      return Color(0xff7A9EBF);
    case TaskStatus.rejected:
      return Color(0xffFF5792);
    case TaskStatus.all:
      return Colors.grey;
    case TaskStatus.InProgress:
      // TODO: Handle this case.
      throw UnimplementedError();
  }
}

TaskStatus mapStatus(String status) {
  switch (status.toLowerCase()) {
    case 'pending':
      return TaskStatus.pending;
    case 'completed':
      return TaskStatus.completed;
    case 'reviewrequested':
      return TaskStatus.ReviewRequested;
    case 'rejected':
      return TaskStatus.rejected;
    default:
      return TaskStatus.pending;
  }
}

String taskStatusIcon(TaskStatus status) {
  switch (status) {
    case TaskStatus.completed:
      return 'assets/icons/Completed.svg';
    case TaskStatus.pending:
      return 'assets/icons/pinding.svg';
    case TaskStatus.ReviewRequested:
      return 'assets/icons/inreview.svg';
    case TaskStatus.rejected:
      return 'assets/icons/regected.svg';
    case TaskStatus.all:
      return 'assets/icons/regected.svg';
    case TaskStatus.InProgress:
      // TODO: Handle this case.
      throw UnimplementedError();
  }
}

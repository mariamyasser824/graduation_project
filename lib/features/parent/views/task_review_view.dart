import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rewarding_kids/core/constants/app_colors.dart';
import 'package:rewarding_kids/features/parent/cubit/tasks_cubit/task_review_cubit.dart';
import 'package:rewarding_kids/features/parent/models/child_task_model.dart';
import 'package:rewarding_kids/features/parent/widgets/TaskReview_body.dart';

class TaskReviewView extends StatelessWidget {
  const TaskReviewView({super.key, required this.taskId});
  final String taskId;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.Background,
        body: BlocProvider(
          create: (_) => TaskReviewCubit(),
          child: TaskreviewBody(taskId: taskId),
        ),
      ),
    );
  }
}

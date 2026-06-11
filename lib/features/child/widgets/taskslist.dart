import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rewarding_kids/features/child/cubit/tasks_cubit.dart';
import 'package:rewarding_kids/features/child/cubit/tasks_state.dart';
import '../data/models/task_model.dart';
import 'Taskcard.dart';

class Taskslist extends StatelessWidget {
  const Taskslist({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TasksCubit, TasksState>(
      builder: (context, state) {
        /// loading
        if (state is TasksLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        /// success
        if (state is TasksSuccess) {
          List<TaskModel> tasks = state.tasks;

          /// لو مفيش تاسكات
          if (tasks.isEmpty) {
            return const Center(
              child: Text(
                "No tasks available yet 👀",
                style: TextStyle(fontSize: 16),
              ),
            );
          }

          return ListView.builder(
            itemCount: tasks.length,
            itemBuilder: (context, index) {
              final task = tasks[index];
              return Taskcard(task: task);
            },
          );
        }

        /// error
        if (state is TasksError) {
          return Center(
            child: Text(state.error, style: const TextStyle(color: Colors.red)),
          );
        }

        return const SizedBox();
      },
    );
  }
}

import 'package:rewarding_kids/features/child/data/models/task_model.dart';

class BaseTask {
  final String id;
  final String title;
  final bool isAdventure;
  final String? weeklyAdventureId;
  final String? AdventureTaskId;
  BaseTask({
    required this.id,
    required this.title,
    this.isAdventure = false,
    this.weeklyAdventureId,
    this.AdventureTaskId,
  });
}

class TaskArgs {
  final TaskModel? task;
  final BaseTask ?baseTask;

  TaskArgs({required this.task, required this.baseTask});
}

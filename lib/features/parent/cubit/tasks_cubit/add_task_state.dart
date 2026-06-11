import 'package:rewarding_kids/features/parent/models/add_task_model.dart';
import 'package:rewarding_kids/features/parent/models/category_model.dart';
import 'package:rewarding_kids/features/parent/models/sub_category_model.dart';
import 'package:rewarding_kids/features/parent/models/task_form_model.dart';

class AddTaskState {
  final TaskFormModel form;

  final List<CategoryModel> categories;
  final List<SubCategoryModel> subCategories;
  final List<AddTaskModel> tasks;

  final AddTaskModel? selectedTask;
  final DateTime? selectedDate;

  final bool isLoading;
  final String? error;

  const AddTaskState({
    required this.form,
    this.categories = const [],
    this.subCategories = const [],
    this.tasks = const [],
    this.selectedTask,
    this.selectedDate,
    this.isLoading = false,
    this.error,
  });

  factory AddTaskState.initial() {
    return const AddTaskState(form: TaskFormModel());
  }

  AddTaskState copyWith({
    TaskFormModel? form,
    List<CategoryModel>? categories,
    List<SubCategoryModel>? subCategories,
    List<AddTaskModel>? tasks,
    AddTaskModel? selectedTask,
    DateTime? selectedDate,
    bool? isLoading,
    String? error,
  }) {
    return AddTaskState(
      form: form ?? this.form,
      categories: categories ?? this.categories,
      subCategories: subCategories ?? this.subCategories,
      tasks: tasks ?? this.tasks,
      selectedTask: selectedTask ?? this.selectedTask,
      selectedDate: selectedDate ?? this.selectedDate,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }

  bool get canAssign => selectedTask != null && selectedDate != null;
}

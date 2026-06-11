import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rewarding_kids/core/network/api_constants.dart';
import 'package:rewarding_kids/core/network/api_service.dart';
import 'package:rewarding_kids/features/parent/models/add_task_model.dart';
import 'package:rewarding_kids/features/parent/models/category_model.dart';
import 'package:rewarding_kids/features/parent/models/sub_category_model.dart';
import 'add_task_state.dart';

class AssignTaskResult {
  final bool succeeded;
  final String? message;

  AssignTaskResult({required this.succeeded, this.message});
}

class AddTaskCubit extends Cubit<AddTaskState> {
  AddTaskCubit() : super(AddTaskState.initial());

  final ApiService _api = ApiService();

  /// 🟢 1. Get Categories
  Future<void> getCategories() async {
    emit(state.copyWith(isLoading: true));

    try {
      final response = await _api.get(ApiConstants.getCategories);

      final data = response['data'] as List;

      final categories = data.map((e) => CategoryModel.fromJson(e)).toList();

      emit(state.copyWith(categories: categories, isLoading: false));
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }

  /// 🟢 2. Select Category + Get SubCategories
  void selectCategory(CategoryModel category) {
    emit(
      state.copyWith(
        form: state.form.copyWith(
          category: category.id,
          subCategory: null,
          level: null,
        ),
        subCategories: [],
        tasks: [],
        selectedTask: null,
      ),
    );

    getSubCategories(category.id);
  }

  /// 🟢 3. Get SubCategories
  Future<void> getSubCategories(String categoryId) async {
    emit(state.copyWith(isLoading: true));

    try {
      final response = await _api.get(
        ApiConstants.getSubCategories(categoryId),
      );

      final data = response['data'] as List;

      final subCategories = data
          .map((e) => SubCategoryModel.fromJson(e))
          .toList();

      emit(state.copyWith(subCategories: subCategories, isLoading: false));
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }

  /// 🟢 4. Select SubCategory
  void selectSubCategory(SubCategoryModel subCategory) {
    emit(
      state.copyWith(
        form: state.form.copyWith(subCategory: subCategory.id),
        tasks: [],
        selectedTask: null,
      ),
    );

    if (state.form.level != null) {
      getTasks(subCategory.id, state.form.level!);
    }
  }

  /// 🟢 5. Select Level
  void selectLevel(String level) {
    emit(
      state.copyWith(
        form: state.form.copyWith(level: level),
        tasks: [],
        selectedTask: null,
      ),
    );

    if (state.form.subCategory != null) {
      getTasks(state.form.subCategory!, level);
    }
  }

  /// 🟢 6. Get Tasks
  Future<void> getTasks(String subCategoryId, String level) async {
    emit(state.copyWith(isLoading: true));

    try {
      final response = await _api.get(
        ApiConstants.getTaskTemplates(subCategoryId, level),
      );

      final items = response['data']['items'] as List;

      final tasks = items.map((e) => AddTaskModel.fromJson(e)).toList();

      emit(state.copyWith(tasks: tasks, isLoading: false));
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }

  /// 🟢 7. Select Task
  void selectTask(AddTaskModel task) {
    emit(state.copyWith(selectedTask: task, selectedDate: null));
  }

  /// 🟢 8. Select Date
  void selectDate(DateTime date) {
    emit(state.copyWith(selectedDate: date));
  }

  /// 🟢 9. Assign Task
  Future<AssignTaskResult> assignTask() async {
    try {
      final response = await _api.post(ApiConstants.assignTask, {
        "taskTemplateId": state.selectedTask!.id,
        "dueDate": state.selectedDate!.toIso8601String(),
      });

      // 👇 دي الصح
      final succeeded = response['succeeded'] ?? false;
      final message = response['message'] ?? '';

      return AssignTaskResult(succeeded: succeeded, message: message);
    } catch (e) {
      return AssignTaskResult(succeeded: false, message: e.toString());
    }
  }
}

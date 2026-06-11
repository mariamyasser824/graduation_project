import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rewarding_kids/features/parent/cubit/tasks_cubit/task_list_cubit.dart';
import 'package:rewarding_kids/features/parent/models/child_task_model.dart';
import 'package:rewarding_kids/features/parent/widgets/task_card.dart';

class TasksList extends StatefulWidget {
  const TasksList({super.key});

  @override
  State<TasksList> createState() => _TasksListState();
}

class _TasksListState extends State<TasksList> {
  @override
  void initState() {
    super.initState();
    context.read<TaskListCubit>().fetchTasks();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaskListCubit, TaskListState>(
      builder: (context, state) {
        if (state.loading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state.errorMessage != null) {
          return Center(child: Text(state.errorMessage!));
        }
        final filteredTasks = state.selectedStatus == TaskStatus.all
            ? state.tasks
            : state.tasks
                  .where(
                    (task) =>
                        task.status.toLowerCase() ==
                        state.selectedStatus.name.toLowerCase(),
                  )
                  .toList();

        if (filteredTasks.isEmpty) {
          return const Center(child: Text('No tasks'));
        }

        return ListView.builder(
          padding: const EdgeInsets.all(12),
          itemCount: filteredTasks.length,
          itemBuilder: (context, index) {
            return TaskCard(task: filteredTasks[index]);
          },
        );
      },
    );
  }
}
/*import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rewarding_kids/core/network/api_constants.dart';
import 'package:dio/dio.dart';
import 'package:rewarding_kids/core/network/api_service.dart';
import 'package:rewarding_kids/core/network/dio_client.dart';
import 'package:rewarding_kids/features/parent/models/child_task_model.dart';
import 'package:rewarding_kids/core/utils/pref_helper.dart';
part 'task_list_state.dart';

class TaskListCubit extends Cubit<TaskListState> {
  TaskListCubit() : super(TaskListState(loading: false, tasks: []));

  final ApiService api = ApiService();

  Future<void> fetchTasks({String? status}) async {
    emit(state.copyWith(loading: true, errorMessage: null));

    final childId = await PrefHelper.getChildId();

    try {
      final data = await api.get(
        ApiConstants.getParentTasks +
            "?childId=$childId" +
            (status != null && status != 'all' ? "&Status=$status" : ""),
      );

      final tasks = (data['data']['items'] as List)
          .map((json) => ChildTask.fromJson(json))
          .toList();

      emit(state.copyWith(loading: false, tasks: tasks));
    } catch (e) {
      emit(state.copyWith(loading: false, errorMessage: e.toString()));
    }
  }

  void changeStatus(TaskStatus status) {
    emit(state.copyWith(selectedStatus: status));
    fetchTasks(
      status: status == TaskStatus.all ? null : status.name,
    ); // لو الـ API يدعم فلترة حسب Status
  }
} part of 'task_list_cubit.dart';

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
}class ChildTask {
  final String childTaskId;
  final String childId;
  final String childName;
  final String taskTemplateId;
  final String titleAr;
  final String titleEn;
  final String? iconUrl;
  final int points;
  final String status;
  final DateTime assignedAt;
  final DateTime? dueDate;
  final DateTime? completedAt;
  final DateTime? reviewRequestedAt;
  final String? rejectionReason;

  final String? childNote; // ✅ NEW
  final String? answerMediaUrl; // ✅ FIXED

  ChildTask({
    required this.childTaskId,
    required this.childId,
    required this.childName,
    required this.taskTemplateId,
    required this.titleAr,
    required this.titleEn,
    this.iconUrl,
    required this.points,
    required this.status,
    required this.assignedAt,
    this.dueDate,
    this.completedAt,
    this.reviewRequestedAt,
    this.rejectionReason,
    this.childNote,
    this.answerMediaUrl,
  });

  factory ChildTask.fromJson(Map<String, dynamic> json) {
    return ChildTask(
      childTaskId: json['childTaskId'],
      childId: json['childId'],
      childName: json['childName'],
      taskTemplateId: json['taskTemplateId'],
      titleAr: json['titleAr'],
      titleEn: json['titleEn'],
      iconUrl: json['iconUrl'],
      points: json['points'],
      status: json['status'],
      assignedAt: DateTime.parse(json['assignedAt']),
      dueDate: json['dueDate'] != null
          ? DateTime.tryParse(json['dueDate'])
          : null,
      completedAt: json['completedAt'] != null
          ? DateTime.tryParse(json['completedAt'])
          : null,
      reviewRequestedAt: json['reviewRequestedAt'] != null
          ? DateTime.tryParse(json['reviewRequestedAt'])
          : null,
      rejectionReason: json['rejectionReason'],

      childNote: json['childNote'], // ✅
      answerMediaUrl: json['answerMediaUrl'], // ✅
    );
  }
}

 class SubCategoryModel {
  final String id;
  final String name;

  SubCategoryModel({required this.id, required this.name});

  factory SubCategoryModel.fromJson(Map<String, dynamic> json) {
    return SubCategoryModel(
      id: json['id'],
      name: json['nameEn'] ?? json['nameAr'] ?? '', // <== هنا
    );
  }
} class AddTaskModel {
  final String id;
  final String title;
  final String description;
  final String subCategory;
  final String level;
  final int rewardPoints;
  final String iconUrl;

  AddTaskModel({
    required this.id,
    required this.title,
    required this.description,
    required this.subCategory,
    required this.level,
    required this.rewardPoints,
    required this.iconUrl,
  });

  factory AddTaskModel.fromJson(Map<String, dynamic> json) {
    return AddTaskModel(
      id: json['id'],
      title: json['titleEn'] ?? json['titleAr'] ?? '',
      description: json['descriptionEn'] ?? json['descriptionAr'] ?? '',
      subCategory: json['subCategoryNameEn'] ?? '',
      level: json['difficulty'] ?? '',
      rewardPoints: json['basePoints'] ?? 0,
      iconUrl: json['iconUrl'] ?? '',
    );
  }
}
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
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rewarding_kids/core/constants/app_colors.dart';
import 'package:rewarding_kids/features/parent/cubit/layout_cubit/tasks_view_cubit.dart';
import 'package:rewarding_kids/features/parent/cubit/tasks_cubit/task_list_cubit.dart';
import 'package:rewarding_kids/features/parent/widgets/tasks_body.dart';

class TasksView extends StatelessWidget {
  const TasksView({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => TaskListCubit()),
        BlocProvider(create: (_) => TasksViewCubit()),
      ],
      child: const TasksBody(),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:rewarding_kids/Shared/CustomText.dart';
import 'package:rewarding_kids/core/constants/app_colors.dart';
import 'package:rewarding_kids/features/parent/cubit/tasks_cubit/task_list_cubit.dart';
import 'package:rewarding_kids/features/parent/models/child_task_model.dart';
import 'package:rewarding_kids/features/parent/views/task_review_view.dart';
import 'package:rewarding_kids/features/parent/widgets/helpers/task_status_helper.dart';

class TaskCard extends StatelessWidget {
  final ChildTask task;

  const TaskCard({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    final statusEnum = mapStatus(task.status);
    final color = taskStatusColor(statusEnum);

    return GestureDetector(
      onTap: () async {
        if (statusEnum == TaskStatus.ReviewRequested) {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => TaskReviewView(taskId: task.childTaskId),
            ),
          );

          if (result == true) {
            context.read<TaskListCubit>().fetchTasks(); // 🔥 refresh
          }
        }
      },
      child: Container(
        width: MediaQuery.of(context).size.width * 0.9,

        margin: EdgeInsets.only(bottom: 16.h),
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        decoration: BoxDecoration(
          color: Color(0xffF8F4FA),
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(color: color),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CustomText(
                  text: task.titleAr,
                  iscenter: true,
                  size: 16.sp,
                  color: AppColors.titleColor,
                  weight: FontWeight.w500,
                ),
                const Spacer(),
                Container(
                  width: 24.w,
                  height: 24.h,
                  child: SvgPicture.asset(
                    taskStatusIcon(statusEnum),
                    color: color,
                  ),
                ),
              ],
            ),
            SizedBox(height: 6.h),
            CustomText(
              text: "Listen to a short story without interrupting.",
              iscenter: true,
              size: 12.sp,
              color: AppColors.descColor,
              weight: FontWeight.w400,
            ),
            SizedBox(height: 6.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.2,
                      //  height: MediaQuery.of(context).size.height * 0.03,
                      decoration: BoxDecoration(
                        color: Color(0xffE4E4E4),
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: CustomText(
                        text: task.childName,
                        iscenter: true,
                        size: 14.sp,
                        color: Color(0xff60697B),
                        weight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(width: 6.w),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.2,
                      //  height: MediaQuery.of(context).size.height * 0.03,
                      decoration: BoxDecoration(
                        color: Color(0xffE4E4E4),
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: CustomText(
                        text: task.childName,
                        iscenter: true,
                        size: 14.sp,
                        color: Color(0xff60697B),
                        weight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),

                // SizedBox(height: 6.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 30.w,
                      height: 20.h,
                      //padding: EdgeInsets.all(4.w),
                      decoration: BoxDecoration(shape: BoxShape.circle),
                      child: Image.asset('assets/child/coins.png'),
                    ),
                    SizedBox(
                      width: 30.w,
                      height: 20.h,

                      child: CustomText(
                        text: "${task.points}",
                        iscenter: true,
                        size: 14.sp,
                        color: Color(0xff394A59),
                        weight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 6.h),
          ],
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:rewarding_kids/core/constants/app_colors.dart';
import 'package:rewarding_kids/features/onboarding/widgets/popbutton.dart';
import 'package:rewarding_kids/features/parent/cubit/layout_cubit/tasks_view_cubit.dart';
import 'package:rewarding_kids/features/parent/views/add_task_screen.dart';
import 'package:rewarding_kids/features/parent/widgets/AddTaskButton.dart';
import 'package:rewarding_kids/features/parent/widgets/StatusTabs.dart';
import 'package:rewarding_kids/features/parent/widgets/tasks_list.dart';

class TasksBody extends StatelessWidget {
  const TasksBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TasksViewCubit, TasksPage>(
      builder: (context, state) {
        if (state == TasksPage.addTask) {
          return const AddTaskScreen();
        }

        return Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 16.h),
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                height: MediaQuery.of(context).size.height * 0.04,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Popbutton(onPressed: () {}),
                    AddTaskButton(
                      onTap: () {
                        context.read<TasksViewCubit>().showAddTask();
                      },
                      text: 'Add Task',
                    ),
                    SvgPicture.asset(
                      "assets/icons/notification.svg",
                      width: 14.w,
                      height: 16.h,
                    ),
                  ],
                ),
              ),
            ),
            const StatusTabs(),
            const Expanded(child: TasksList()),
          ],
        );
      },
    );
  }
}
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rewarding_kids/Shared/CustomText.dart';
import 'package:rewarding_kids/core/constants/app_colors.dart';

class TasksGrid extends StatelessWidget {
  const TasksGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    final bool isTablet = width >= 600;

    return GridView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: isTablet ? 3 : 2,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
        childAspectRatio: isTablet ? 1.8 : 1.6,
        // ثابت
      ),
      children: const [
        SmallCard(
          image: 'assets/icons/completed_tasks.svg',
          title: 'Total Task',
          value: 0,
          Col: Color(0xffE3D4EB),
        ),
        SmallCard(
          image: 'assets/icons/regected.svg',
          title: 'Refused',
          value: 0,
          Col: Color(0xffFFEBF2),
        ),
        SmallCard(
          image: 'assets/icons/time_minutes.svg',
          title: 'Pending!',
          value: 0,
          Col: Color(0xffBDE0FE),
        ),
        SmallCard(
          image: 'assets/icons/Completed.svg',
          title: 'Complete',
          value: 0,
          Col: Color(0xffBAFFC2),
        ),
      ],
    );
  }
}

class SmallCard extends StatelessWidget {
  final int value;
  final String title;
  final String image;
  final Color Col;
  const SmallCard({
    super.key,
    required this.title,
    required this.value,
    required this.image,
    required this.Col,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100.h,
      decoration: BoxDecoration(
        color: Col,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 20,
            spreadRadius: 4, // ده الـ spread
            offset: Offset(0, 4),
          ),
        ],
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(
                  text: "$value",
                  iscenter: true,
                  size: 20.sp,
                  color: AppColors.titleColor,
                  weight: FontWeight.w500,
                ),
                SvgPicture.asset(image, width: 32.w, height: 32.h),
              ],
            ),
            SizedBox(height: 10.h),
            CustomText(
              text: title,
              iscenter: true,
              size: 12.sp,
              color: AppColors.titleColor,
              weight: FontWeight.w400,
            ),
            // SizedBox(height: 10.h),
          ],
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rewarding_kids/features/parent/cubit/tasks_cubit/task_list_cubit.dart';
import 'package:rewarding_kids/features/parent/models/child_task_model.dart';
import 'package:rewarding_kids/features/parent/widgets/task_card.dart';

class TasksList extends StatefulWidget {
  const TasksList({super.key});

  @override
  State<TasksList> createState() => _TasksListState();
}

class _TasksListState extends State<TasksList> {
  @override
  void initState() {
    super.initState();
    context.read<TaskListCubit>().fetchTasks();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaskListCubit, TaskListState>(
      builder: (context, state) {
        if (state.loading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state.errorMessage != null) {
          return Center(child: Text(state.errorMessage!));
        }
        final filteredTasks = state.selectedStatus == TaskStatus.all
            ? state.tasks
            : state.tasks
                  .where(
                    (task) =>
                        task.status.toLowerCase() ==
                        state.selectedStatus.name.toLowerCase(),
                  )
                  .toList();

        if (filteredTasks.isEmpty) {
          return const Center(child: Text('No tasks'));
        }

        return ListView.builder(
          padding: const EdgeInsets.all(12),
          itemCount: filteredTasks.length,
          itemBuilder: (context, index) {
            return TaskCard(task: filteredTasks[index]);
          },
        );
      },
    );
  }
}
  بص في صفحة عرض التاسكات اما بيعرض كارد التاسك المفروض يعرض الكاتيجوري والليفل  بدل الا اللي انا مكرره والمفروض الباك قالي انو عدل على الريسبونس هوريك دلوقتي وقولي هل كده صح ولا ايه 
➡️ Request: https://go-kid.runasp.net/api/ParentTask?childId=5d807e7b-aef6-4915-96e4-11e6f0c53d22
🔑 Token: eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJuYW1laWQiOiI0NzFhZDQxYS04NzViLTRmOGItYjZhZS03YzAwNmY4ZWVmZDgiLCJlbWFpbCI6ImVubXJteTEyOTIwMDRAZ21haWwuY29tIiwiZ2l2ZW5fbmFtZSI6ImVubXJteTEyOTIwMDRAZ21haWwuY29tIiwicm9sZSI6IlBhcmVudCIsIm5iZiI6MTc3NjI4Nzc5NiwiZXhwIjoxNzc2ODkyNTk2LCJpYXQiOjE3NzYyODc3OTYsImlzcyI6Imh0dHBzOi8vbG9jYWxob3N0OjcyMDQiLCJhdWQiOiJodHRwczovL2xvY2FsaG9zdDo3MjA0In0.DHPr0atGlT9l9LRRJKU8ry4O3bzWfhNPVmvD0kjYzvU
*** Request ***
uri: https://go-kid.runasp.net/api/ParentTask?childId=5d807e7b-aef6-4915-96e4-11e6f0c53d22
method: GET
responseType: ResponseType.json
followRedirects: true
persistentConnection: true
connectTimeout: null
sendTimeout: null
receiveTimeout: null
receiveDataWhenStatusError: true
extra: {}
headers:
 Authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJuYW1laWQiOiI0NzFhZDQxYS04NzViLTRmOGItYjZhZS03YzAwNmY4ZWVmZDgiLCJlbWFpbCI6ImVubXJteTEyOTIwMDRAZ21haWwuY29tIiwiZ2l2ZW5fbmFtZSI6ImVubXJteTEyOTIwMDRAZ21haWwuY29tIiwicm9sZSI6IlBhcmVudCIsIm5iZiI6MTc3NjI4Nzc5NiwiZXhwIjoxNzc2ODkyNTk2LCJpYXQiOjE3NzYyODc3OTYsImlzcyI6Imh0dHBzOi8vbG9jYWxob3N0OjcyMDQiLCJhdWQiOiJodHRwczovL2xvY2FsaG9zdDo3MjA0In0.DHPr0atGlT9l9LRRJKU8ry4O3bzWfhNPVmvD0kjYzvU
data:
null

*** Response ***
uri: https://go-kid.runasp.net/api/ParentTask?childId=5d807e7b-aef6-4915-96e4-11e6f0c53d22
statusCode: 200
statusMessage: 
headers:
 content-type: application/json; charset=utf-8
Response Text:
{"statusCode":"OK","succeeded":true,"message":"Child tasks retrieved successfully","errors":null,"data":{"items":[{"childTaskId":"0d8afe3e-1cdb-408f-b386-d0d38ec5976a","childId":"4dcd6d1e-287f-4216-a8c2-e8842b848488","childName":"hamza","taskTemplateId":"11ad8ec5-f173-4e40-ab03-09b9337be1f2","titleAr":"اميره ","titleEn":"amira","categoryNameAr":"الإبداع والمهارات","categoryNameEn":"Creativity & Skills","subCategoryNameAr":"تلوين","subCategoryNameEn":"Coloring","difficulty":"Medium","iconUrl":null,"points":50,"status":"Completed","assignedAt":"2026-03-25T00:00:00","dueDate":null,"completedAt":"2026-03-25T15:25:15.3060454","reviewRequestedAt":null,"rejectionReason":null,"evidenceUrl":"https://res.cloudinary.com/dhnlpsrf4/raw/upload/v1774452305/ylt4qqz4egzaarqzhpx6.mp3"},{"childTaskId":"0f310c18-9cff-4489-9ce8-7985cf326747","childId":"4dcd6d1e-287f-4216-a8c2-e8842b848488","childName":"hamza","taskTemplateId":"ef8b1304-0fe7-49f0-a01f-3791c345d206","titleAr":"jjj","titleEn":"jjj","categoryNameAr":"السلوك وتحمل المسؤولية","categoryNameEn":"Behavior & Responsibility","subCategoryNameAr":"روتين النوم","subCategoryNameEn":"Bedtime Routine","difficulty":"Hard","iconUrl":null,"points":5,"status":"Pending","assignedAt":"2026-03-27T00:00:00","dueDate":null,"completedAt":null,"reviewRequestedAt":null,"rejectionReason":null,"evidenceUrl":null},{"childTaskId":"147a6f80-ac2e-4d8a-abc0-81fd5e6ceda0","childId":"4dcd6d1e-287f-4216-a8c2-e8842b848488","childName":"hamza","taskTemplateId":"11ad8ec5-f173-4e40-ab03-09b9337be1f2","titleAr":"اميره ","titleEn":"amira","categoryNameAr":"الإبداع والمهارات","categoryNameEn":"Creativity & Skills","subCategoryNameAr":"تلوين","subCategoryNameEn":"Coloring","difficulty":"Medium","iconUrl":null,"points":50,"status":"Pending","assignedAt":"2026-03-27T00:00:00","dueDate":null,"completedAt":null,"reviewRequestedAt":null,"rejectionReason":null,"evidenceUrl":null},{"childTaskId":"17200b70-bb51-471b-9b8f-80c30a0aadf9","childId":"4dcd6d1e-287f-4216-a8c2-e8842b848488","childName":"hamza","taskTemplateId":"cbddfc84-a3d7-4a27-a40d-857f7d633f1b","titleAr":"SS","titleEn":"SS","categoryNameAr":"السلوك وتحمل المسؤولية","categoryNameEn":"Behavior & Responsibility","subCategoryNameAr":"المساعدة في المنزل","subCategoryNameEn":"Helping at Home","difficulty":"Easy","iconUrl":"https://res.cloudinary.com/dhnlpsrf4/image/upload/v1766410786/lr2qvcxndsy3oqfekqfq.png","points":10,"status":"Pending","assignedAt":"2026-03-11T00:00:00","dueDate":null,"completedAt":null,"reviewRequestedAt":null,"rejectionReason":null,"evidenceUrl":null},{"childTaskId":"1743833d-9648-4556-8473-3fc4b46764d0","childId":"4dcd6d1e-287f-4216-a8c2-e8842b848488","childName":"hamza","taskTemplateId":"cbddfc84-a3d7-4a27-a40d-857f7d633f1b","titleAr":"SS","titleEn":"SS","categoryNameAr":"السلوك وتحمل المسؤولية","categoryNameEn":"Behavior & Responsibility","subCategoryNameAr":"المساعدة في المنزل","subCategoryNameEn":"Helping at Home","difficulty":"Easy","iconUrl":"https://res.cloudinary.com/dhnlpsrf4/image/upload/v1766410786/lr2qvcxndsy3oqfekqfq.png","points":10,"status":"Pending","assignedAt":"2026-03-25T00:00:00","dueDate":null,"completedAt":null,"reviewRequestedAt":null,"rejectionReason":null,"evidenceUrl":null},{"childTaskId":"1955c71a-c25a-4611-a9b5-5294e76b0001","childId":"4dcd6d1e-287f-4216-a8c2-e8842b848488","childName":"hamza","taskTemplateId":"4667219e-20d3-460e-b00d-911d0f61b794","titleAr":"test","titleEn":"test","categoryNameAr":"الإبداع والمهارات","categoryNameEn":"Creativity & Skills","subCategoryNameAr":"رسم","subCategoryNameEn":"Drawing","difficulty":"Medium","iconUrl":"https://res.cloudinary.com/dhnlpsrf4/image/upload/v1770035981/ejzlewg5zt6gxdy3qe9u.jpg","points":50,"status":"Pending","assignedAt":"2026-03-29T00:00:00","dueDate":null,"completedAt":null,"reviewRequestedAt":null,"rejectionReason":null,"evidenceUrl":null},{"childTaskId":"23d66888-4d24-4f33-940b-39104ccce3c7","childId":"4dcd6d1e-287f-4216-a8c2-e8842b848488","childName":"hamza","taskTemplateId":"49df3fe2-f541-4964-92e7-6d44bc0b0698","titleAr":"kk","titleEn":"kkk","categoryNameAr":"التطور العاطفي والاجتماعي","categoryNameEn":"Emotional & Social Development","subCategoryNameAr":"مهام اللطف","subCategoryNameEn":"Kindness Tasks","difficulty":"Easy","iconUrl":null,"points":1,"status":"Pending","assignedAt":"2026-03-24T00:00:00","dueDate":null,"completedAt":null,"reviewRequestedAt":null,"rejectionReason":null,"evidenceUrl":null},{"childTaskId":"24b1b164-44a9-401b-9808-463781197cfa","childId":"4dcd6d1e-287f-4216-a8c2-e8842b848488","childName":"hamza","taskTemplateId":"581705c0-b664-4b34-9d9a-fb9f44416fa1","titleAr":"للتجربه","titleEn":"for testing ","categoryNameAr":"المهام الدراسية","categoryNameEn":"Academic Tasks","subCategoryNameAr":"لغة إنجليزية / قراءة","subCategoryNameEn":"English / Reading","difficulty":"Easy","iconUrl":"https://res.cloudinary.com/dhnlpsrf4/image/upload/v1772913474/znbj2wtsnhgxgdehejn0.jpg","points":10,"status":"Completed","assignedAt":"2026-03-11T00:00:00","dueDate":null,"completedAt":"2026-03-11T21:48:04.0576915","reviewRequestedAt":null,"rejectionReason":null,"evidenceUrl":"https://res.cloudinary.com/dhnlpsrf4/raw/upload/v1773265675/icqvswtlfy3qxfxpxqfs.mp3"},{"childTaskId":"252378c4-eb60-49b2-8565-e144a078da7e","childId":"5d807e7b-aef6-4915-96e4-11e6f0c53d22","childName":"roqaia","taskTemplateId":"6e4b6c65-500e-4d3e-b314-8260b66b411f","titleAr":"string","titleEn":"string","categoryNameAr":"السلوك وتحمل المسؤولية","categoryNameEn":"Behavior & Responsibility","subCategoryNameAr":"روتين النوم","subCategoryNameEn":"Bedtime Routine","difficulty":"Easy","iconUrl":"https://res.cloudinary.com/dhnlpsrf4/image/upload/v1769344009/qqxbvv6wrtx0nxt1hwme.jpg","points":8,"status":"Pending","assignedAt":"2026-04-02T04:48:15.4908697","dueDate":"2026-04-05T23:59:59","completedAt":null,"reviewRequestedAt":null,"rejectionReason":null,"evidenceUrl":null},{"childTaskId":"25e640e3-c01e-4d79-8065-260a87c32456","childId":"4dcd6d1e-287f-4216-a8c2-e8842b848488","childName":"hamza","taskTemplateId":"0cd99f64-b836-4ff8-9827-6d6cf54d427e","titleAr":"اميره ","titleEn":"amira","categoryNameAr":"الإبداع والمهارات","categoryNameEn":"Creativity & Skills","subCategoryNameAr":"تلوين","subCategoryNameEn":"Coloring","difficulty":"Medium","iconUrl":null,"points":30,"status":"Rejected","assignedAt":"2026-03-14T00:00:00","dueDate":null,"completedAt":null,"reviewRequestedAt":"2026-03-14T12:24:13.8471695","rejectionReason":"string  not good","evidenceUrl":"https://res.cloudinary.com/dhnlpsrf4/image/upload/v1773491053/ldxhnl7zyvy50z1b1z3s.jpg"}],"pageNumber":1,"totalCount":59,"totalPages":6,"hasPreviousPage":false,"hasNextPage":true}}

➡️ Request: https://go-kid.runasp.net/api/Category
🔑 Token: eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJuYW1laWQiOiI0NzFhZDQxYS04NzViLTRmOGItYjZhZS03YzAwNmY4ZWVmZDgiLCJlbWFpbCI6ImVubXJteTEyOTIwMDRAZ21haWwuY29tIiwiZ2l2ZW5fbmFtZSI6ImVubXJteTEyOTIwMDRAZ21haWwuY29tIiwicm9sZSI6IlBhcmVudCIsIm5iZiI6MTc3NjI4Nzc5NiwiZXhwIjoxNzc2ODkyNTk2LCJpYXQiOjE3NzYyODc3OTYsImlzcyI6Imh0dHBzOi8vbG9jYWxob3N0OjcyMDQiLCJhdWQiOiJodHRwczovL2xvY2FsaG9zdDo3MjA0In0.DHPr0atGlT9l9LRRJKU8ry4O3bzWfhNPVmvD0kjYzvU
*** Request ***
uri: https://go-kid.runasp.net/api/Category
method: GET
responseType: ResponseType.json
followRedirects: true
persistentConnection: true
connectTimeout: null
sendTimeout: null
receiveTimeout: null
receiveDataWhenStatusError: true
extra: {}
headers:
 Authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJuYW1laWQiOiI0NzFhZDQxYS04NzViLTRmOGItYjZhZS03YzAwNmY4ZWVmZDgiLCJlbWFpbCI6ImVubXJteTEyOTIwMDRAZ21haWwuY29tIiwiZ2l2ZW5fbmFtZSI6ImVubXJteTEyOTIwMDRAZ21haWwuY29tIiwicm9sZSI6IlBhcmVudCIsIm5iZiI6MTc3NjI4Nzc5NiwiZXhwIjoxNzc2ODkyNTk2LCJpYXQiOjE3NzYyODc3OTYsImlzcyI6Imh0dHBzOi8vbG9jYWxob3N0OjcyMDQiLCJhdWQiOiJodHRwczovL2xvY2FsaG9zdDo3MjA0In0.DHPr0atGlT9l9LRRJKU8ry4O3bzWfhNPVmvD0kjYzvU
data:
null

*** Response ***
uri: https://go-kid.runasp.net/api/Category
statusCode: 200
statusMessage: 
headers:
 content-type: application/json; charset=utf-8
Response Text:
{"statusCode":"OK","succeeded":true,"message":"Categories retrived succsessfully.","errors":null,"data":[{"id":"12a3f904-3598-49d3-b95b-47744d2f8f2a","nameAr":"المهام الدراسية","nameEn":"Academic Tasks","icon":{"url":"","publicId":""},"colorHex":"#3498db","subCategoriesCount":7},{"id":"5bf424d1-09bf-459d-9fac-3e5ac59293be","nameAr":"السلوك وتحمل المسؤولية","nameEn":"Behavior & Responsibility","icon":{"url":"","publicId":""},"colorHex":"#7d2ecc","subCategoriesCount":5},{"id":"3cf0efbd-81db-4da5-bd78-e9ddc53ae871","nameAr":"الإبداع والمهارات","nameEn":"Creativity & Skills","icon":{"url":"","publicId":""},"colorHex":"#4561b5","subCategoriesCount":5},{"id":"7d03adf4-3754-4d70-95d6-decc2dec027f","nameAr":"التطور العاطفي والاجتماعي","nameEn":"Emotional & Social Development","icon":{"url":"","publicId":""},"colorHex":"#6137a0","subCategoriesCount":5},{"id":"6c3c636f-f8e8-4117-ad37-57c9cea9fe41","nameAr":"الصحة والنشاط البدني","nameEn":"Health & Physical Activities","icon":{"url":"https://res.cloudinary.com/dhnlpsrf4/image/upload/v1765920324/q1s0g8y1colax8txhto6.jpg","publicId":"q1s0g8y1colax8txhto6"},"colorHex":"#7d248f","subCategoriesCount":4},{"id":"8f445b20-cc1c-4dce-8ed9-d4a061d15701","nameAr":"kk``","nameEn":"kk","icon":{"url":"https://res.cloudinary.com/dhnlpsrf4/image/upload/v1765753978/tz6sjmxx9gvbxejbpvyp.jpg","publicId":"tz6sjmxx9gvbxejbpvyp"},"colorHex":"#ad1fa2","subCategoriesCount":0}]}

➡️ Request: https://go-kid.runasp.net/api/TaskSubCategory/category/12a3f904-3598-49d3-b95b-47744d2f8f2a
🔑 Token: eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJuYW1laWQiOiI0NzFhZDQxYS04NzViLTRmOGItYjZhZS03YzAwNmY4ZWVmZDgiLCJlbWFpbCI6ImVubXJteTEyOTIwMDRAZ21haWwuY29tIiwiZ2l2ZW5fbmFtZSI6ImVubXJteTEyOTIwMDRAZ21haWwuY29tIiwicm9sZSI6IlBhcmVudCIsIm5iZiI6MTc3NjI4Nzc5NiwiZXhwIjoxNzc2ODkyNTk2LCJpYXQiOjE3NzYyODc3OTYsImlzcyI6Imh0dHBzOi8vbG9jYWxob3N0OjcyMDQiLCJhdWQiOiJodHRwczovL2xvY2FsaG9zdDo3MjA0In0.DHPr0atGlT9l9LRRJKU8ry4O3bzWfhNPVmvD0kjYzvU
*** Request ***
uri: https://go-kid.runasp.net/api/TaskSubCategory/category/12a3f904-3598-49d3-b95b-47744d2f8f2a
method: GET
responseType: ResponseType.json
followRedirects: true
persistentConnection: true
connectTimeout: null
sendTimeout: null
receiveTimeout: null
receiveDataWhenStatusError: true
extra: {}
headers:
 Authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJuYW1laWQiOiI0NzFhZDQxYS04NzViLTRmOGItYjZhZS03YzAwNmY4ZWVmZDgiLCJlbWFpbCI6ImVubXJteTEyOTIwMDRAZ21haWwuY29tIiwiZ2l2ZW5fbmFtZSI6ImVubXJteTEyOTIwMDRAZ21haWwuY29tIiwicm9sZSI6IlBhcmVudCIsIm5iZiI6MTc3NjI4Nzc5NiwiZXhwIjoxNzc2ODkyNTk2LCJpYXQiOjE3NzYyODc3OTYsImlzcyI6Imh0dHBzOi8vbG9jYWxob3N0OjcyMDQiLCJhdWQiOiJodHRwczovL2xvY2FsaG9zdDo3MjA0In0.DHPr0atGlT9l9LRRJKU8ry4O3bzWfhNPVmvD0kjYzvU
data:
null

*** Response ***
uri: https://go-kid.runasp.net/api/TaskSubCategory/category/12a3f904-3598-49d3-b95b-47744d2f8f2a
statusCode: 200
statusMessage: 
headers:
 content-type: application/json; charset=utf-8
Response Text:
{"statusCode":"OK","succeeded":true,"message":"Sub Categories retrived succsessfully","errors":null,"data":[{"id":"5c14d405-0e4a-40b1-af55-559f8fd058e7","nameAr":"لغة إنجليزية / قراءة","nameEn":"English / Reading","icon":null,"categoryId":"12a3f904-3598-49d3-b95b-47744d2f8f2a","categoryNameEn":"Academic Tasks","categoryNameAr":null},{"id":"ffa4fd88-9a51-4719-b892-93607d1f07a4","nameAr":"واجبات مدرسية","nameEn":"Homework","icon":null,"categoryId":"12a3f904-3598-49d3-b95b-47744d2f8f2a","categoryNameEn":"Academic Tasks","categoryNameAr":null},{"id":"6d65c066-4f42-43d6-9c77-4c8a6c222f9a","nameAr":"رياضيات","nameEn":"Math","icon":null,"categoryId":"12a3f904-3598-49d3-b95b-47744d2f8f2a","categoryNameEn":"Academic Tasks","categoryNameAr":null},{"id":"84dfd53d-7b13-4a75-b3d6-a9c37d407ddc","nameAr":"القرآن والدراسات الإسلامية","nameEn":"Qur’an & Islamic Studies","icon":null,"categoryId":"12a3f904-3598-49d3-b95b-47744d2f8f2a","categoryNameEn":"Academic Tasks","categoryNameAr":null},{"id":"7529e9c8-93ac-4ed5-a03b-d2063c37836c","nameAr":"مشاريع مدرسية 2","nameEn":"School Projects","icon":null,"categoryId":"12a3f904-3598-49d3-b95b-47744d2f8f2a","categoryNameEn":"Academic Tasks","categoryNameAr":null},{"id":"cc3320c1-93f3-4733-83d5-e06146184be5","nameAr":"علوم","nameEn":"Science","icon":null,"categoryId":"12a3f904-3598-49d3-b95b-47744d2f8f2a","categoryNameEn":"Academic Tasks","categoryNameAr":null},{"id":"f5b9b409-fb4d-46c7-acd9-2bf3079a7f87","nameAr":"amira","nameEn":"اميره","icon":{"url":"https://res.cloudinary.com/dhnlpsrf4/image/upload/v1768333903/jrnze9pkw44i7bgyfoec.jpg","publicId":"jrnze9pkw44i7bgyfoec"},"categoryId":"12a3f904-3598-49d3-b95b-47744d2f8f2a","categoryNameEn":"Academic Tasks","categoryNameAr":null}]}

➡️ Request: https://go-kid.runasp.net/api/task-templates?SubCategoryId=5c14d405-0e4a-40b1-af55-559f8fd058e7&Difficulty=Medium
🔑 Token: eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJuYW1laWQiOiI0NzFhZDQxYS04NzViLTRmOGItYjZhZS03YzAwNmY4ZWVmZDgiLCJlbWFpbCI6ImVubXJteTEyOTIwMDRAZ21haWwuY29tIiwiZ2l2ZW5fbmFtZSI6ImVubXJteTEyOTIwMDRAZ21haWwuY29tIiwicm9sZSI6IlBhcmVudCIsIm5iZiI6MTc3NjI4Nzc5NiwiZXhwIjoxNzc2ODkyNTk2LCJpYXQiOjE3NzYyODc3OTYsImlzcyI6Imh0dHBzOi8vbG9jYWxob3N0OjcyMDQiLCJhdWQiOiJodHRwczovL2xvY2FsaG9zdDo3MjA0In0.DHPr0atGlT9l9LRRJKU8ry4O3bzWfhNPVmvD0kjYzvU
*** Request ***
uri: https://go-kid.runasp.net/api/task-templates?SubCategoryId=5c14d405-0e4a-40b1-af55-559f8fd058e7&Difficulty=Medium
method: GET
responseType: ResponseType.json
followRedirects: true
persistentConnection: true
connectTimeout: null
sendTimeout: null
receiveTimeout: null
receiveDataWhenStatusError: true
extra: {}
headers:
 Authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJuYW1laWQiOiI0NzFhZDQxYS04NzViLTRmOGItYjZhZS03YzAwNmY4ZWVmZDgiLCJlbWFpbCI6ImVubXJteTEyOTIwMDRAZ21haWwuY29tIiwiZ2l2ZW5fbmFtZSI6ImVubXJteTEyOTIwMDRAZ21haWwuY29tIiwicm9sZSI6IlBhcmVudCIsIm5iZiI6MTc3NjI4Nzc5NiwiZXhwIjoxNzc2ODkyNTk2LCJpYXQiOjE3NzYyODc3OTYsImlzcyI6Imh0dHBzOi8vbG9jYWxob3N0OjcyMDQiLCJhdWQiOiJodHRwczovL2xvY2FsaG9zdDo3MjA0In0.DHPr0atGlT9l9LRRJKU8ry4O3bzWfhNPVmvD0kjYzvU
data:
null

*** Response ***
uri: https://go-kid.runasp.net/api/task-templates?SubCategoryId=5c14d405-0e4a-40b1-af55-559f8fd058e7&Difficulty=Medium
statusCode: 200
statusMessage: 
headers:
 content-type: application/json; charset=utf-8
Response Text:
{"statusCode":"OK","succeeded":true,"message":"Task templates retrieved successfully","errors":null,"data":{"items":[],"pageNumber":1,"totalCount":0,"totalPages":0,"hasPreviousPage":false,"hasNextPage":false}}

➡️ Request: https://go-kid.runasp.net/api/task-templates?SubCategoryId=5c14d405-0e4a-40b1-af55-559f8fd058e7&Difficulty=Easy
🔑 Token: eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJuYW1laWQiOiI0NzFhZDQxYS04NzViLTRmOGItYjZhZS03YzAwNmY4ZWVmZDgiLCJlbWFpbCI6ImVubXJteTEyOTIwMDRAZ21haWwuY29tIiwiZ2l2ZW5fbmFtZSI6ImVubXJteTEyOTIwMDRAZ21haWwuY29tIiwicm9sZSI6IlBhcmVudCIsIm5iZiI6MTc3NjI4Nzc5NiwiZXhwIjoxNzc2ODkyNTk2LCJpYXQiOjE3NzYyODc3OTYsImlzcyI6Imh0dHBzOi8vbG9jYWxob3N0OjcyMDQiLCJhdWQiOiJodHRwczovL2xvY2FsaG9zdDo3MjA0In0.DHPr0atGlT9l9LRRJKU8ry4O3bzWfhNPVmvD0kjYzvU
*** Request ***
uri: https://go-kid.runasp.net/api/task-templates?SubCategoryId=5c14d405-0e4a-40b1-af55-559f8fd058e7&Difficulty=Easy
method: GET
responseType: ResponseType.json
followRedirects: true
persistentConnection: true
connectTimeout: null
sendTimeout: null
receiveTimeout: null
receiveDataWhenStatusError: true
extra: {}
headers:
 Authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJuYW1laWQiOiI0NzFhZDQxYS04NzViLTRmOGItYjZhZS03YzAwNmY4ZWVmZDgiLCJlbWFpbCI6ImVubXJteTEyOTIwMDRAZ21haWwuY29tIiwiZ2l2ZW5fbmFtZSI6ImVubXJteTEyOTIwMDRAZ21haWwuY29tIiwicm9sZSI6IlBhcmVudCIsIm5iZiI6MTc3NjI4Nzc5NiwiZXhwIjoxNzc2ODkyNTk2LCJpYXQiOjE3NzYyODc3OTYsImlzcyI6Imh0dHBzOi8vbG9jYWxob3N0OjcyMDQiLCJhdWQiOiJodHRwczovL2xvY2FsaG9zdDo3MjA0In0.DHPr0atGlT9l9LRRJKU8ry4O3bzWfhNPVmvD0kjYzvU
data:
null

*** Response ***
uri: https://go-kid.runasp.net/api/task-templates?SubCategoryId=5c14d405-0e4a-40b1-af55-559f8fd058e7&Difficulty=Easy
statusCode: 200
statusMessage: 
headers:
 content-type: application/json; charset=utf-8
Response Text:
{"statusCode":"OK","succeeded":true,"message":"Task templates retrieved successfully","errors":null,"data":{"items":[{"id":"581705c0-b664-4b34-9d9a-fb9f44416fa1","titleAr":"للتجربه","titleEn":"for testing ","descriptionAr":"للتجربه","descriptionEn":"for testing","subCategoryNameAr":"لغة إنجليزية / قراءة","categoryId":"12a3f904-3598-49d3-b95b-47744d2f8f2a","categoryNameAr":"المهام الدراسية","categoryNameEn":"Academic Tasks","iconUrl":"https://res.cloudinary.com/dhnlpsrf4/image/upload/v1772913474/znbj2wtsnhgxgdehejn0.jpg","subCategoryId":"5c14d405-0e4a-40b1-af55-559f8fd058e7","subCategoryNameEn":"English / Reading","difficulty":"Easy","basePoints":10,"templateType":"VoiceQuestion","createdAt":"2026-03-07T19:57:55.8905641"}],"pageNumber":1,"totalCount":1,"totalPages":1,"hasPreviousPage":false,"hasNextPage":false}} */
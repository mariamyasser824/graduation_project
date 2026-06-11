import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rewarding_kids/Shared/CustomText.dart';
import 'package:rewarding_kids/core/constants/app_colors.dart';
import 'package:rewarding_kids/features/parent/cubit/tasks_cubit/add_task_cubit.dart';
import 'package:rewarding_kids/features/parent/cubit/tasks_cubit/add_task_state.dart';
import 'package:rewarding_kids/features/parent/models/add_task_model.dart';
import 'package:rewarding_kids/features/parent/models/child_task_model.dart';
import 'package:rewarding_kids/features/parent/widgets/addtask_appar.dart';
import 'package:rewarding_kids/features/parent/widgets/empty_tasks_state.dart';
import 'package:rewarding_kids/features/parent/widgets/sectionHeafer.dart';
import 'package:rewarding_kids/features/parent/widgets/subcategory_section.dart';
import 'package:rewarding_kids/features/parent/widgets/task_select_card.dart';
import '../widgets/category_section.dart';
import '../widgets/level_section.dart';

class AddTaskBody extends StatelessWidget {
  const AddTaskBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AddTaskCubit()..getCategories(),
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AddtaskAppar(),
                    SizedBox(height: 16.h),

                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.w,
                        vertical: 16.h,
                      ),
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Color(0xffF8F4FA),
                          borderRadius: BorderRadius.circular(16.r),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.25),
                              spreadRadius: 0,
                              blurRadius: 20,
                              offset: Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 16.w,
                            vertical: 16.h,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SectionHeader(
                                title: 'Category',
                                icon: 'assets/icons/category.svg',
                              ),
                              SizedBox(height: 8.h),
                              CategorySection(),
                              SizedBox(height: 20.h),
                              BlocBuilder<AddTaskCubit, AddTaskState>(
                                builder: (context, state) {
                                  if (state.form.category == null) {
                                    return SizedBox();
                                  }
                                  return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const SectionHeader(
                                        title: 'Subcategory',
                                        icon: 'assets/icons/category.svg',
                                      ),
                                      SizedBox(height: 8.h),
                                      SubCategorySection(),
                                    ],
                                  );
                                },
                              ),
                              SizedBox(height: 20.h),
                              SectionHeader(
                                title: 'Level',
                                icon: 'assets/icons/levels.svg',
                              ),
                              SizedBox(height: 8.h),
                              LevelSection(),
                            ],
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: 24.h),
                    BlocBuilder<AddTaskCubit, AddTaskState>(
                      builder: (context, state) {
                        final form = state.form;
                        if (form.category == null &&
                            form.subCategory == null &&
                            form.level == null) {
                          return const EmptyTasksState();
                        }

                        final tasks = state.tasks;
                        if (tasks.isEmpty) return const EmptyTasksState();

                        return ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: tasks.length,
                          itemBuilder: (context, index) {
                            return TaskSelectCard(task: tasks[index]);
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

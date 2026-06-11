import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:rewarding_kids/Shared/CustomText.dart';
import 'package:rewarding_kids/Shared/Custombutton.dart';
import 'package:rewarding_kids/core/constants/app_colors.dart';
import 'package:rewarding_kids/features/parent/cubit/tasks_cubit/add_task_cubit.dart';
import 'package:rewarding_kids/features/parent/cubit/tasks_cubit/add_task_state.dart';

class TaskActions extends StatelessWidget {
  const TaskActions({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddTaskCubit, AddTaskState>(
      buildWhen: (previous, current) =>
          previous.selectedDate != current.selectedDate ||
          previous.canAssign != current.canAssign,
      builder: (context, state) {
        final dateController = TextEditingController(
          text: state.selectedDate == null
              ? ''
              : '${state.selectedDate!.day}/${state.selectedDate!.month}/${state.selectedDate!.year}',
        );
        return Padding(
          padding: EdgeInsets.symmetric(vertical: 8.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                text: "Due Date",
                iscenter: false,
                size: 16.sp,
                weight: FontWeight.w500,
                color: AppColors.titleColor,
              ),

              SizedBox(height: 8.h),

              /// Date Picker - TextFormField style
              SizedBox(
                width: double.infinity,
                height: 48.h,
                child: TextFormField(
                  readOnly: true,
                  onTap: () async {
                    final date = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime.now(),
                      lastDate: DateTime.now().add(const Duration(days: 365)),
                    );

                    if (date != null) {
                      context.read<AddTaskCubit>().selectDate(date);
                    }
                  },
                  /* controller: TextEditingController(
                    text: state.selectedDate == null
                        ? ''
                        : '${state.selectedDate!.day}/${state.selectedDate!.month}/${state.selectedDate!.year}',
                  ),*/
                  decoration: InputDecoration(
                    prefixIcon: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5.w),
                      child: SvgPicture.asset(
                        'assets/icons/timeline.svg',
                        height: 30.h, // الحجم اللي عايزة
                        width: 30.w,
                      ),
                    ),
                    prefixIconConstraints: BoxConstraints(
                      minHeight: 30.h,
                      minWidth: 30.w,
                      maxHeight: 30.h,
                      maxWidth: 30.w,
                    ),

                    hintText: 'Enter Due Date',
                    hintStyle: TextStyle(
                      color: AppColors.descColor,
                      fontSize: 14.sp,
                    ),

                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(color: Color(0xFF8A38F5)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),

              SizedBox(height: 20.h),

              /// Assign Button
              Custombutton(
                onPressed: state.canAssign
                    ? () async {
                        await assignTaskWithDialog(context);
                      }
                    : null,
                text: 'Assign the task to the child',
              ),
            ],
          ),
        );
      },
    );
  }
}

Future<void> assignTaskWithDialog(BuildContext context) async {
  try {
    final result = await context.read<AddTaskCubit>().assignTask();

    if (result.succeeded) {
      _showDialog(
        context,
        title: 'Task assigned Successfully!',
        imagePath: 'assets/icons/done.png',
      );
    } else {
      // لو السيرفر رجع خطأ
      _showDialog(
        context,
        title: 'Error1',
        message: result.message ?? 'An unknown error occurred',
        imagePath: 'assets/icons/done.png',
      );
    }
  } catch (e) {
    // لو فيه مشكلة في request نفسها (مثلاً DioException)
    _showDialog(
      context,
      title: 'Error2',
      message: e.toString(),
      imagePath: 'assets/icons/done.png',
    );
  }
}

void _showDialog(
  BuildContext context, {
  required String title,
  String? message,
  required String imagePath,
}) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (_) {
      return AlertDialog(
        content: SizedBox(
          height: 240.h,
          width: 290.w,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 100.h,
                width: 100.w,
                child: Image.asset(imagePath),
              ),
              SizedBox(height: 10.h),
              CustomText(
                text: title,
                iscenter: true,
                size: 14.sp,
                weight: FontWeight.w500,
                color: AppColors.titleColor,
              ),
              if (message != null) ...[
                SizedBox(height: 10.h),
                CustomText(
                  text: message,
                  iscenter: true,
                  size: 12.sp,
                  weight: FontWeight.w400,
                  color: AppColors.descColor,
                ),
              ],
              SizedBox(height: 10.h),
              Custombutton(
                onPressed: () {
                  if (context.canPop()) context.pop();
                },
                text: 'Continue',
              ),
            ],
          ),
        ),
      );
    },
  );
}

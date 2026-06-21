import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:rewarding_kids/Shared/CustomText.dart';
import 'package:rewarding_kids/Shared/Custombutton.dart';
import 'package:rewarding_kids/core/constants/app_colors.dart';
import 'package:rewarding_kids/features/child/cubit/SubmitTaskCubit.dart';
import 'package:rewarding_kids/features/child/cubit/SubmitTaskState%20.dart';
import 'package:rewarding_kids/features/child/cubit/progress_cubit.dart';
import 'package:rewarding_kids/features/child/data/models/task_model.dart';
import 'package:rewarding_kids/features/child/widgets/coin.dart';
import 'package:rewarding_kids/features/child/widgets/notes_to_parent.dart';
import 'package:rewarding_kids/features/onboarding/widgets/popbutton.dart';
import 'package:rewarding_kids/features/child/widgets/homeAppbar.dart';

class PendingView extends StatefulWidget {
  const PendingView({
    super.key,
    required this.Taskdetails,
    required this.imagePath,
    required this.type,
    this.adventureTaskId,
    this.weeklyAdventureId,
  });
  final dynamic Taskdetails;
  final String? imagePath;
  final SubmitType type;
  final String? adventureTaskId;
  final String? weeklyAdventureId;

  @override
  State<PendingView> createState() => _PendingViewState();
}

class _PendingViewState extends State<PendingView> {
  @override
  final TextEditingController noteController = TextEditingController();
  @override
  void dispose() {
    noteController.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return BlocListener<SubmitTaskCubit, SubmitTaskState>(
      listener: (context, state) {
        if (state.status == SubmitStatus.loading) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (_) => const Center(child: CircularProgressIndicator()),
          );
        }

        if (state.status == SubmitStatus.success) {
          if (Navigator.canPop(context)) {
            Navigator.pop(context); // ✅ اقفلي اللودينج هنا
          }

          if (state.response?.data?.status == "Pending") {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Task sent to parent 👌")),
            );

            context.read<ProgressCubit>().fetchPoints(); // 🔥 أهم سطر

            context.push('/Custombottomnav');
          }
        }

        if (state.status == SubmitStatus.error) {
          if (Navigator.canPop(context)) {
            Navigator.pop(context); // ✅ اقفلي اللودينج هنا
          }

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.error ?? "Something went wrong")),
          );
        }

        if (state.status == SubmitStatus.error) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.error ?? "Something went wrong")),
          );
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.Background,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
            child: Column(
              children: [
                Row(
                  children: [
                    Popbutton(
                      onPressed: () {
                        if (context.canPop()) {
                          context.pop();
                        } else {
                          context.go('/Custombottomnav');
                        }
                      },
                    ),
                    SizedBox(width: 70.w),
                    CustomText(
                      text: widget.Taskdetails.titleEn,
                      iscenter: true,
                      size: 20.sp,
                      color: AppColors.titleColor,
                      weight: FontWeight.w600,
                    ),
                  ],
                ),
                SizedBox(height: 25.h),
                HomeAppbar(),
                SizedBox(height: 30.h),

                /// عرض الصورة
                if (widget.imagePath != null)
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16.r),
                    child: Container(
                      width: double.infinity,
                      height: 255.h,

                      child: Image.file(
                        File(widget.imagePath!),
                        fit: BoxFit.cover,
                        width: double.infinity,
                      ),
                    ),
                  )
                else
                  const Expanded(
                    child: Center(child: Text('No image available')),
                  ),
                SizedBox(height: 30.h),
                SizedBox(
                  width: 129.w,
                  height: 27.h,
                  child: Row(
                    children: [
                      CustomText(
                        text: 'Reward:',
                        iscenter: true,
                        size: 18.sp,
                        weight: FontWeight.w500,
                        color: AppColors.titleColor,
                      ),
                      SizedBox(width: 10.h),
                      CustomText(
                        text:
                            '${widget.type == SubmitType.normal ? widget.Taskdetails.basePoints : widget.Taskdetails.stars}',
                        iscenter: true,
                        size: 18.sp,
                        weight: FontWeight.w500,
                        color: AppColors.titleColor,
                      ),
                      SizedBox(width: 5.h),
                      Coin(),
                    ],
                  ),
                ),
                SizedBox(height: 20.h),
                CustomText(
                  text:
                      'Great job!\nNow let’s wait for your parent to check your\n task . 🕓 ',
                  iscenter: true,
                  size: 18.sp,
                  weight: FontWeight.w500,
                  color: Color(0xff5C5163),
                ),
                SizedBox(height: 20.h),
                NotesToParent(controller: noteController),
                Spacer(),
                Custombutton(
                  onPressed: widget.imagePath == null
                      ? null
                      : () {
                          context.read<SubmitTaskCubit>().submit(
                            type: widget.type, // 🔥 أهم سطر
                            // 🟢 لو task عادية
                            taskId: widget.type == SubmitType.normal
                                ? widget.Taskdetails.id
                                : null,

                            // 🔥 لو adventure
                            adventureTaskId: widget.type == SubmitType.adventure
                                ? widget
                                      .adventureTaskId // أو id الصح بتاعك
                                : null,

                            weeklyAdventureId:
                                widget.type == SubmitType.adventure
                                ? widget
                                      .weeklyAdventureId // ❗ لازم يكون جاي من فوق
                                : null,

                            imagePath: widget.imagePath,
                            comment: noteController.text,
                          );
                        },
                  text: 'Submit Task ',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

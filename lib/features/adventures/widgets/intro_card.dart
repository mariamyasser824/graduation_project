import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:rewarding_kids/Shared/CustomText.dart';
import 'package:rewarding_kids/features/adventures/models/adv_task_model.dart';
import 'package:rewarding_kids/features/adventures/widgets/start_adventure_button.dart';
import 'package:rewarding_kids/features/child/data/models/task_model.dart';

class IntroCard extends StatelessWidget {
  const IntroCard({super.key, required this.task});
  final AdvTaskModel task;
  @override
  void navigateToTask(BuildContext context, AdvTaskModel task) {
    switch (task.type) {
      case AdvTaskType.voice:
        context.push('/adv_voice_task', extra: task);
        break;

      case AdvTaskType.image:
        context.push('/adv_image_task', extra: task);
        break;

      case AdvTaskType.auto:
        context.push('/adv_auto_task', extra: task);
        break;
    }
  }

  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: 415.h,
          left: 32.w,
          right: 32.w,
          child: Container(
            height: 375.h,
            width: 330.w,
            padding: EdgeInsets.fromLTRB(16.w, 60.h, 16.w, 16.h),
            decoration: BoxDecoration(
              color: Color(0xffF7F1FF),
              borderRadius: BorderRadius.circular(16.r),

              boxShadow: [
                BoxShadow(
                  color: Color(0xffA68F8F).withOpacity(0.25),
                  blurRadius: 20,
                  offset: const Offset(0, 8),
                ),
              ],
            ),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 30.h),
                CustomText(
                  text: 'Day ${task.dayNumber}',
                  iscenter: true,
                  color: Color(0xff55425F),
                  size: 24.sp,
                  weight: FontWeight.w700,
                ),
                SizedBox(height: 10.h),
                CustomText(
                  text: "Your Adventure Begins 🚀",
                  iscenter: true,
                  color: Color(0xff7B6C83),
                  size: 18.sp,
                  weight: FontWeight.w700,
                ),
                SizedBox(height: 10.h),
                CustomText(
                  text: task.titleEn,
                  iscenter: true,
                  color: Color(0xff7B6C83),
                  size: 14.sp,
                  weight: FontWeight.w400,
                ),
                SizedBox(height: 15.h),

                CustomText(
                  text: task.storyText ?? "",
                  iscenter: true,
                  color: Color(0xff55425F),
                  size: 14.sp,
                  weight: FontWeight.w400,
                ),

                Spacer(),
                StartAdventureButton(
                  onTap: () {
                    navigateToTask(context, task);
                  },
                  text: 'Let\’s Start',
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

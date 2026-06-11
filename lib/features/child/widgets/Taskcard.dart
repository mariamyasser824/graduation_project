import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:rewarding_kids/Shared/CustomText.dart';
import 'package:rewarding_kids/core/constants/app_colors.dart';
import '../data/models/task_model.dart';

class Taskcard extends StatelessWidget {
  const Taskcard({super.key, required this.task});
  final TaskModel task;

  void _navigate(BuildContext context) {
    if (task.templateType == "VoiceQuestion") {
      GoRouter.of(context).push('/voice_task', extra: task);
    } else if (task.templateType == "EvidenceSubmission") {
      GoRouter.of(context).push('/take_image', extra: task);
    } else {
      GoRouter.of(context).push('/task_view', extra: task);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _navigate(context),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 8.w),
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.cardcolor,
            borderRadius: BorderRadius.circular(16.r),
          ),
          child: Row(
            children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(16.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        text: task.subCategoryNameEn,
                        iscenter: false,
                        size: 14.sp,
                        weight: FontWeight.w500,
                        color: Color(0xff8137E1),
                      ),
                      SizedBox(height: 6.h),
                      CustomText(
                        text: task.titleEn,
                        iscenter: false,
                        size: 16.sp,
                        weight: FontWeight.w600,
                        color: AppColors.titleColor,
                      ),
                      SizedBox(height: 8.h),
                      Row(
                        children: [
                          CustomText(
                            text: 'Reward :',
                            size: 14.sp,
                            weight: FontWeight.w500,
                            iscenter: true,
                            color: Color(0xff6B7280),
                          ),
                          SizedBox(width: 6.w),
                          CustomText(
                            text: '${task.basePoints}',
                            size: 14.sp,
                            weight: FontWeight.w500,
                            iscenter: true,
                            color: AppColors.titleColor,
                          ),
                          SizedBox(width: 6.w),
                          Image.asset(
                            'assets/child/coins.png',
                            width: 16.w,
                            height: 16.h,
                          ),

                          // SizedBox(width: 6.w),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              /// IMAGE
              Padding(
                padding: EdgeInsets.all(12.w),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.r),
                  child: (task.hasIcon)
                      ? Image.network(
                          task.iconUrl!,
                          width: 80.w,
                          height: 80.h,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Image.asset(
                              'assets/child/drawflower.jpg',
                              width: 80.w,
                              height: 80.h,
                            );
                          },
                        )
                      : Image.asset(
                          'assets/child/drawflower.jpg',
                          width: 80.w,
                          height: 80.h,
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

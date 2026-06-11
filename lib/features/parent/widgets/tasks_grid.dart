import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rewarding_kids/Shared/CustomText.dart';
import 'package:rewarding_kids/core/constants/app_colors.dart';
import 'package:rewarding_kids/features/parent/models/statistics_model.dart';

class TasksGrid extends StatelessWidget {
  const TasksGrid({super.key, required this.stats});
  final PeriodStats stats;

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
      children: [
        SmallCard(
          image: 'assets/icons/completed_tasks.svg',
          title: 'Total Task',
          value: stats.totalTasks,
          Col: Color(0xffE3D4EB),
        ),
        SmallCard(
          image: 'assets/icons/regected.svg',
          title: 'Refused',
          value: stats.refusedTasks,
          Col: Color(0xffFFEBF2),
        ),
        SmallCard(
          image: 'assets/icons/time_minutes.svg',
          title: 'Pending!',
          value: stats.inReviewTasks,
          Col: Color(0xffBDE0FE),
        ),
        SmallCard(
          image: 'assets/icons/Completed.svg',
          title: 'Complete',
          value: stats.completedTasksCount,
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

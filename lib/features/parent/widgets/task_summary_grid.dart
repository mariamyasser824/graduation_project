import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rewarding_kids/Shared/CustomText.dart';
import 'package:rewarding_kids/core/constants/app_colors.dart';
import 'package:rewarding_kids/features/parent/models/statistics_model.dart';

class TaskSummaryGrid extends StatelessWidget {
  const TaskSummaryGrid({super.key, required this.stats});
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
        childAspectRatio: 1.71, // ثابت
      ),
      children: [
        Earned_Point(
          image: 'assets/child/coins.png',
          title: 'Earned Point',
          value: stats.earnedPoints,
        ),
        SmallCard(
          image: 'assets/icons/completed_tasks.svg',
          title: 'Completed Task',
          value: stats.completedTasks,
        ),
        SmallCard(
          image: 'assets/icons/time_minutes.svg',
          title: 'Minutes Average Time',
          value: stats.avgMinutes,
        ),
        SmallCard(
          image: 'assets/icons/fire.svg',
          title: 'Consecutive days ',
          value: stats.consecutiveDays,
        ),
      ],
    );
  }
}

class SmallCard extends StatelessWidget {
  final int value;
  final String title;
  final String image;

  const SmallCard({
    super.key,
    required this.title,
    required this.value,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xffE3D4EB),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 20,
            spreadRadius: 0,
            offset: const Offset(0, 4),
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
          ],
        ),
      ),
    );
  }
}

class Earned_Point extends StatelessWidget {
  final int value;
  final String title;
  final String image;

  const Earned_Point({
    super.key,
    required this.title,
    required this.value,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xffE3D4EB),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 20,
            spreadRadius: 0,
            offset: const Offset(0, 4),
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
                Image.asset(image, width: 32.w, height: 32.h),
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
          ],
        ),
      ),
    );
  }
}

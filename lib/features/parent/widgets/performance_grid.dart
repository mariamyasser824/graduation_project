import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rewarding_kids/Shared/CustomText.dart';
import 'package:rewarding_kids/core/constants/app_colors.dart';
import 'package:rewarding_kids/features/parent/models/statistics_model.dart';

class PerformanceGrid extends StatelessWidget {
  final Performance performance;

  const PerformanceGrid({super.key, required this.performance});
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
        childAspectRatio: isTablet ? 1.8 : 1.5, // ثابت
      ),
      children: [
        SmallCard(
          title: 'Current Period',
          value: performance.currentPeriod.completedTasks,
        ),
        SmallCard(
          title: 'Previous Period',
          value: performance.previousPeriod.completedTasks,
        ),
      ],
    );
  }
}

class SmallCard extends StatelessWidget {
  final int value;
  final String title;

  const SmallCard({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xffDCD8D9),
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
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomText(
              text: title,
              iscenter: true,
              size: 12.sp,
              color: AppColors.titleColor,
              weight: FontWeight.w400,
            ),

            CustomText(
              text: "$value",
              iscenter: true,
              size: 20.sp,
              color: AppColors.titleColor,
              weight: FontWeight.w500,
            ),

            CustomText(
              text: 'Task',
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

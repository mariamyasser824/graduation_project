import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rewarding_kids/Shared/CustomText.dart';
import 'package:rewarding_kids/core/constants/app_colors.dart';
import 'package:rewarding_kids/features/Parent_registar/widgets/progress_bar.dart';
import 'package:rewarding_kids/features/parent/models/statistics_model.dart';
import 'package:rewarding_kids/features/parent/widgets/Performance_progress_bar.dart';
import 'package:rewarding_kids/features/parent/widgets/performance_grid.dart';

class PerformanceCard extends StatelessWidget {
  final StatisticsModel data;

  PerformanceCard({super.key, required this.data});

  @override
  late final performance = data.performance;
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 230.h,
      decoration: BoxDecoration(
        color: Color(0xffF8E9FF),
        borderRadius: BorderRadius.all(Radius.circular(20.h)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 20,
            spreadRadius: 0,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 135.w,
              height: 25.h,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(
                    Icons.trending_up_outlined,
                    size: 25,
                    color: Color(0xff7B6C83),
                  ),
                  CustomText(
                    text: 'Performance',
                    iscenter: true,
                    size: 16.sp,
                    color: AppColors.titleColor,
                    weight: FontWeight.w500,
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(
                  text: 'Improvement over the previous period ',
                  iscenter: true,
                  size: 12.sp,
                  color: AppColors.titleColor,
                  weight: FontWeight.w400,
                ),
                SizedBox(
                  width: 45.w,
                  height: 18.h,

                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: CustomText(
                          text:
                              "${performance.improvementPercentage > 0 ? '+' : ''}${performance.improvementPercentage}%",
                          iscenter: true,
                          size: 12.sp,
                          color: Color(0xff00A600),
                          weight: FontWeight.w400,
                        ),
                      ),

                      Flexible(
                        child: Icon(
                          Icons.trending_up_outlined,
                          size: 15,
                          color: Color(0xff00A600),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            PerformanceProgressBar(
              progress: (performance.improvementPercentage / 100).clamp(
                0.0,
                1.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

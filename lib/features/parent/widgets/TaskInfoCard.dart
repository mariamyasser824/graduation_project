import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rewarding_kids/Shared/CustomText.dart';
import 'package:rewarding_kids/core/constants/app_colors.dart';
import 'package:rewarding_kids/features/parent/models/child_task_model.dart';
import 'package:rewarding_kids/features/parent/widgets/helpers/task_status_helper.dart';

class Taskinfocard extends StatelessWidget {
  const Taskinfocard({super.key, required this.task});
  final ChildTask task;

  @override
  Widget build(BuildContext context) {
    final statusEnum = mapStatus(task.status);
    final color = taskStatusColor(statusEnum);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: SizedBox(
        width: double.infinity,
        height: 230.h,
        child: Column(
          children: [
            Container(
              // width: MediaQuery.of(context).size.width * 0.9,
              height: 110.h,

              // margin: EdgeInsets.only(bottom: 16.h),
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
              decoration: BoxDecoration(
                color: Color(0xffDFCEE9),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16.r),
                  topRight: Radius.circular(16.r),
                ),
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
                    ],
                  ),
                  SizedBox(height: 6.h),
                ],
              ),
            ),
            Container(
              height: 100.h,

              margin: EdgeInsets.only(bottom: 16.h),
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
              decoration: BoxDecoration(
                color: Color(0xffF8EAFF),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(16.r),
                  bottomRight: Radius.circular(16.r),
                ),
              ),
              child: Center(
                child: Container(
                  height: 60.h,
                  width: 325.w,

                  padding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 16.h,
                  ),
                  decoration: BoxDecoration(
                    color: Color(0xffFAE588),
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomText(
                        text: "Points",
                        iscenter: true,
                        size: 14.sp,
                        color: Color(0xff6B7280),
                        weight: FontWeight.w500,
                      ),
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
                              color: AppColors.titleColor,
                              weight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:rewarding_kids/Shared/CustomText.dart';
import 'package:rewarding_kids/core/constants/app_colors.dart';
import 'package:rewarding_kids/features/onboarding/widgets/popbutton.dart';

class TaskReviewHeader extends StatelessWidget {
  const TaskReviewHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 270.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(40.r),
          bottomRight: Radius.circular(40.r),
        ),
        gradient: LinearGradient(
          colors: [Color(0xffBADCFC), Color(0xffF4D0FF)],
          begin: Alignment.topLeft,
          end: Alignment.topRight,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.7),
            blurRadius: 20,
            spreadRadius: 4, // ده الـ spread
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Popbutton(
                  onPressed: () {
                    if (context.canPop()) {
                      context.pop();
                    } else {
                      context.push('/Layout');
                    }
                  },
                ),
                SvgPicture.asset(
                  "assets/icons/notification.svg",
                  width: 14.w,
                  height: 16.h,
                ),
              ],
            ),
            SizedBox(height: 40.h),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SvgPicture.asset(
                  'assets/icons/completed_tasks.svg',
                  width: 48.w,
                  height: 48.h,
                ),
                CustomText(
                  text: "Task Review",
                  iscenter: true,
                  size: 24.sp,
                  color: AppColors.titleColor,
                  weight: FontWeight.w500,
                ),
                CustomText(
                  text:
                      "Check Nilly’s achievement and\n take an actionTask Review",
                  iscenter: true,
                  size: 14.sp,
                  color: AppColors.descColor,
                  weight: FontWeight.w400,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

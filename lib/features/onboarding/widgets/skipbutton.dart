import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:rewarding_kids/Shared/CustomText.dart';
import 'package:rewarding_kids/core/constants/app_colors.dart';
import 'package:rewarding_kids/core/utils/pref_helper.dart';

class Skipbutton extends StatelessWidget {
  const Skipbutton({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        await PrefHelper.setOnBoardingSeen();
        context.push('/getstarted');
      },
      child: Container(
        width: 60.w,
        height: 28.h,
        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
        decoration: BoxDecoration(
          color: AppColors.buttonfillColor, // #E8DDEE
          borderRadius: BorderRadius.circular(26.r),
          border: Border.all(
            color: AppColors.buttonborderColor, // #D0C0D8
            width: 1,
          ),
        ),
        child: CustomText(
          text: "Skip",
          iscenter: true,
          size: 13.sp,
          weight: FontWeight.w500,
          color: AppColors.titleColor,
        ),
      ),
    );
  }
}

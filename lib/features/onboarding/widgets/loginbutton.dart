import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:rewarding_kids/Shared/CustomText.dart';
import 'package:rewarding_kids/core/constants/app_colors.dart';

class Loginbutton extends StatelessWidget {
  const Loginbutton({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 48.h,
      // متناسب مع حجم الشاشة
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          padding: EdgeInsets.symmetric(vertical: 14.h),
          foregroundColor: AppColors.Background,
          side: BorderSide(color: AppColors.ActiveColor, width: 1.25.w),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.r),
          ),
        ),
        onPressed: () {
          context.push('/login');
        },
        child: CustomText(
          text: 'Already have an account? Log In',
          iscenter: true,
          color: AppColors.ActiveColor,
          size: 14.sp,
        ),
      ),
    );
  }
}

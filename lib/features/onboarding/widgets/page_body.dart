import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rewarding_kids/Shared/CustomText.dart';
import 'package:rewarding_kids/core/constants/app_colors.dart';

class PageBody extends StatelessWidget {
  final String titletxt;
  final String desctxt;
  final String image;

  const PageBody({
    super.key,
    required this.titletxt,
    required this.desctxt,
    required this.image,
  });
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min, // 👈 مهم
      children: [
        Flexible(
          flex: 6,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.w),
            child: Image.asset(image, fit: BoxFit.contain),
          ),
        ),

        SizedBox(height: 16.h),

        CustomText(
          text: titletxt,
          color: AppColors.titleColor,
          size: 22.sp, // 👈 خفضت شوية عشان الشاشات الصغيرة
          iscenter: true,
          weight: FontWeight.w600,
        ),

        SizedBox(height: 8.h),

        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: CustomText(
            text: desctxt,
            color: AppColors.descobColor,
            size: 13.sp,
            iscenter: true,
          ),
        ),
      ],
    );
  }
}

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
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    // 35% من ارتفاع الشاشة
    final spaceBetweenImageAndTitle =
        screenHeight * 0.02; // 2% من ارتفاع الشاشة
    final spaceBetweenTitleAndDesc = screenHeight * 0.01; // 1% من ارتفاع الشاشة
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.40,
          width: double.infinity,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.w),
            child: Image.asset(image, fit: BoxFit.contain),
          ),
        ),

        SizedBox(height: 20.h),

        CustomText(
          text: titletxt,
          color: AppColors.titleColor,
          size: 25.sp,
          iscenter: true,
          weight: FontWeight.w600,
        ),

        SizedBox(height: 10.h),

        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: CustomText(
            text: desctxt,
            color: AppColors.descobColor,
            size: 14.sp,
            iscenter: true,
          ),
        ),
      ],
    );
  }
}

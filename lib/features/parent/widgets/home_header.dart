import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rewarding_kids/Shared/CustomText.dart';
import 'package:rewarding_kids/core/constants/app_colors.dart';
import 'package:rewarding_kids/features/child/widgets/PointsProgressBar.dart';
import 'package:rewarding_kids/features/child/widgets/coin.dart';

class HomeHeader extends StatelessWidget {
  final String name;
  final int totalPoints;
  final String image;

  const HomeHeader({
    super.key,
    required this.name,
    required this.totalPoints,
    required this.image,
  });
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 300.h,
      child: Stack(
        clipBehavior: Clip.none, // 👈 مهم جدًا
        alignment: Alignment.topCenter,
        children: [
          /// الكونتينر الأساسي
          Positioned(
            top: 40.h,
            left: 16.w,
            right: 16.w,
            child: Container(
              height: 225.h,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFFACD9FE), Color(0xFFF4D0FF)],
                  begin: Alignment.topLeft,
                  end: Alignment.topRight,
                ),
                borderRadius: BorderRadius.circular(32.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.02),
                    blurRadius: 20,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 30.h),
                    child: CustomText(
                      text: name,
                      iscenter: true,
                      size: 24.sp,
                      weight: FontWeight.w600,
                      color: AppColors.titleColor,
                    ),
                  ),
                  SizedBox(height: 10.h),

                  CustomText(
                    text: ' level : Starter 🌱',
                    iscenter: true,
                    size: 18.sp,
                    weight: FontWeight.w500,
                    color: AppColors.titleColor,
                  ),
                  // SizedBox(height: 10.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.w),
                    child: Row(
                      children: [
                        CustomText(
                          text: 'Score',
                          iscenter: true,
                          size: 16.sp,
                          weight: FontWeight.w500,
                          color: AppColors.titleColor,
                        ),
                        SizedBox(width: 8.w),
                        PointsProgressBar(
                          totalPoints: totalPoints,
                          goalPoints: 500, // 👈 مؤقت لحد ما API يديكي goal
                        ),
                        SizedBox(width: 8.w),

                        Coin(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          /// الـ Wave
          Positioned(
            top: 38.h,
            child: SvgPicture.asset(
              'assets/icons/wave.svg',
              height: 65.h,
              width: 317.w,
              fit: BoxFit.cover,
            ),
          ),

          /// دايرة الطفل (راكبة)
          Positioned(
            top: 0, // 👈 نصها فوق
            child: Container(
              width: 100.w,
              height: 90.h,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [Color(0xFFACD9FE), Color(0xFFF4D0FF)],
                  begin: Alignment.topLeft,
                  end: Alignment.topRight,
                ),
              ),
              child: Center(child: SvgPicture.network(image)),
            ),
          ),
        ],
      ),
    );
  }
}

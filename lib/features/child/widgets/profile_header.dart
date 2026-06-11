import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rewarding_kids/Shared/CustomText.dart';
import 'package:rewarding_kids/core/constants/app_colors.dart';
import 'package:rewarding_kids/features/child/cubit/progress_cubit.dart';
import 'package:rewarding_kids/features/child/cubit/progress_state.dart';
import 'package:rewarding_kids/features/child/widgets/PointsProgressBar.dart';
import 'package:rewarding_kids/features/child/widgets/coin.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key});

  @override
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
                    padding: EdgeInsets.only(top: 50.h),
                    child: CustomText(
                      text: 'Nilly Omar',
                      iscenter: true,
                      size: 24.sp,
                      weight: FontWeight.w600,
                      color: AppColors.titleColor,
                    ),
                  ),
                  SizedBox(height: 5.h),

                  CustomText(
                    text: '6 Years',
                    iscenter: true,
                    size: 18.sp,
                    weight: FontWeight.w500,
                    color: AppColors.titleColor,
                  ),
                  SizedBox(height: 5.h),

                  CustomText(
                    text: ' level : Starter 🌱',
                    iscenter: true,
                    size: 18.sp,
                    weight: FontWeight.w500,
                    color: AppColors.titleColor,
                  ),
                  SizedBox(height: 5.h),
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
                        BlocBuilder<ProgressCubit, ProgressState>(
                          builder: (context, state) {
                            return PointsProgressBar(
                              totalPoints: state.totalPoints,
                              goalPoints: state.goalPoints,
                              isLoading: state.status == ProgressStatus.loading,
                              isError: state.status == ProgressStatus.error,
                            );
                          },
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
              child: Center(
                child: SvgPicture.asset(
                  'assets/icons/girl_icon.svg',
                  // width: 50.w,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

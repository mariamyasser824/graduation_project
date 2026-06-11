import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:rewarding_kids/Shared/CustomText.dart';
import 'package:rewarding_kids/core/constants/app_colors.dart';
import 'package:rewarding_kids/features/parent/cubit/reward_cubit/reward_cubit.dart';

class Addgiftsection extends StatelessWidget {
  const Addgiftsection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomText(
            text: 'Gifts',
            iscenter: true,
            color: AppColors.titleColor,
            size: 18.sp,
            weight: FontWeight.w500,
          ),
          GestureDetector(
            onTap: () {
              context.push('/add_gift').then((_) {
                context.read<RewardCubit>().getRewards();
              });
            },
            child: Container(
              width: 125.w,
              height: 40.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.r),
                gradient: LinearGradient(
                  colors: [Color(0xffF462AB), Color(0xff9C6CFE)],
                  begin: AlignmentGeometry.topLeft,
                  end: AlignmentGeometry.topRight,
                ),
              ),
              child: Center(
                child: CustomText(
                  text: 'Add Gift',
                  iscenter: true,
                  color: Color(0xffFAF8FB),
                  size: 14.sp,
                  weight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

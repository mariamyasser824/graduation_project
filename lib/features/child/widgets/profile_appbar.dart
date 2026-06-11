import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:rewarding_kids/Shared/CustomText.dart';
import 'package:rewarding_kids/core/constants/app_colors.dart';
import 'package:rewarding_kids/features/onboarding/widgets/popbutton.dart';
import 'package:rewarding_kids/features/parent/widgets/AddTaskButton.dart';

class ProfileAppbar extends StatelessWidget {
  const ProfileAppbar({super.key});

  @override
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: 16.h,
        left: 16.w,
        right: 16.w,
        bottom: 12.h,
      ),
      color: AppColors.Background,
      child: Row(
        children: [
          Popbutton(
            onPressed: () {
              if (context.canPop()) {
                context.pop();
              } else {
                context.go('/Layout');
              }
            },
          ),
          Expanded(
            child: Center(
              child: CustomText(
                text: "Profile",
                iscenter: true,
                size: 20.sp,
                weight: FontWeight.w500,
                color: AppColors.titleColor,
              ),
            ),
          ),
          SizedBox(width: 48.w), // مسافة عشان التوازن مع الزرار
        ],
      ),
    );
  }
}

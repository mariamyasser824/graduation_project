import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rewarding_kids/Shared/CustomText.dart';
import 'package:rewarding_kids/core/constants/app_colors.dart';

class SettingsItem extends StatelessWidget {
  final Widget icon;
  final String title;
  final VoidCallback onTap;
  final bool isLogout;

  const SettingsItem({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
    this.isLogout = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
        margin: EdgeInsets.only(bottom: 12.h),
        decoration: BoxDecoration(
          color: Color(0xffFAF8FB),
          borderRadius: BorderRadius.circular(12.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            // 🔹 Icon
            SizedBox(
              width: 40.w,
              height: 40.w,

              child: Center(child: icon),
            ),

            SizedBox(width: 12.w),

            // 🔹 Title
            Expanded(
              child: CustomText(
                text: title,
                size: 14.sp,
                weight: FontWeight.w500,
                color: isLogout ? Color(0xffF52930) : AppColors.titleColor,
                iscenter: false,
              ),
            ),

            // 🔹 Arrow (except logout)
            if (!isLogout)
              Icon(
                Icons.arrow_forward_ios,
                size: 14.sp,
                color: AppColors.titleColor,
              ),
          ],
        ),
      ),
    );
  }
}

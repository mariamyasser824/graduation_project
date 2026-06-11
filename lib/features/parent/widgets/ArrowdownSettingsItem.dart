import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rewarding_kids/Shared/CustomText.dart';
import 'package:rewarding_kids/core/constants/app_colors.dart';

class ArrowDownSettingsItem extends StatelessWidget {
  const ArrowDownSettingsItem({
    super.key,
    required this.title,
    this.subtitle,
    this.titleColor,
    this.onTap,
  });

  final String title;
  final String? subtitle;
  final Color? titleColor;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 12.h),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    text: title,
                    size: 14.sp,
                    weight: FontWeight.w500,
                    color: titleColor ?? AppColors.titleColor,
                    iscenter: true,
                  ),
                  if (subtitle != null) ...[
                    SizedBox(height: 4.h),
                    CustomText(
                      text: subtitle!,
                      size: 12.sp,
                      weight: FontWeight.w400,
                      color: AppColors.descColor,
                      iscenter: false,
                    ),
                  ],
                ],
              ),
            ),
            Icon(
              Icons.keyboard_arrow_down_outlined,
              size: 20.sp,
              color: AppColors.titleColor,
            ),
          ],
        ),
      ),
    );
  }
}

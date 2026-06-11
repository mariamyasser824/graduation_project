import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rewarding_kids/core/constants/app_colors.dart';

class AdventureHeader extends StatelessWidget {
  const AdventureHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        /// النص
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Hi Nilly!",
              style: TextStyle(
                fontSize: 22.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.titleColor,
              ),
            ),
            SizedBox(height: 4.h),
            Text(
              "“Let’s complete today’s adventure!”🚀",
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.w400,
                color: Color(0xff4B5563),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

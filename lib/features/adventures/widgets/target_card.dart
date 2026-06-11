import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class TargetCard extends StatelessWidget {
  final int currentLevel;
  final int totalLevels;

  const TargetCard({
    super.key,
    required this.currentLevel,
    required this.totalLevels,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        /// 🎯 الصورة
        Container(
          width: 42.w,
          height: 20.h,
          // padding: EdgeInsets.symmetric(horizontal: 12.w),
          decoration: BoxDecoration(
            color: Color(0xffCA5567),
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: Center(
            child: Text(
              "$currentLevel / $totalLevels",
              style: TextStyle(
                color: Colors.white,
                fontSize: 12.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),

        // SizedBox(height: 6.h),

        /// 🔴 الكارد الأحمر
      ],
    );
  }
}

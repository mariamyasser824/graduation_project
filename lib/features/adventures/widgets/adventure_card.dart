import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rewarding_kids/core/constants/app_colors.dart';

class AdventureCard extends StatelessWidget {
  final bool isLocked;
  final bool isNew;
  final VoidCallback? onLockedTap;
  final VoidCallback? onTap;
  final String? banner;
  final int completedTasksCount;
  final int totalDays;
  final int bonusPoints;
  final String titleEn;
  const AdventureCard({
    super.key,
    required this.isLocked,
    required this.isNew,
    this.onLockedTap,
    this.onTap,
    required this.banner,
    required this.completedTasksCount,
    required this.totalDays,
    required this.bonusPoints,
    required this.titleEn,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (isLocked) {
          onLockedTap?.call();
        } else {
          onTap?.call();

          /// navigation later
        }
      },
      child: Stack(
        children: [
          /// الكارد
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16.r),
              color: Colors.white,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// الصورة
                Expanded(
                  flex: 5,
                  child: Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(16.r),
                        ),
                        child: banner == null
                            ? Image.asset(
                                "assets/child/space_adventures.jpg",
                                width: double.infinity,
                                height: double.infinity,
                                fit: BoxFit.cover,
                              )
                            : Image.network(
                                banner!,
                                width: double.infinity,
                                height: double.infinity,
                                fit: BoxFit.cover,
                              ),
                      ),

                      /// NEW Badge
                      if (!isLocked && isNew)
                        Positioned(
                          top: 8.h,
                          left: 8.w,
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 8.w,
                              vertical: 4.h,
                            ),
                            decoration: BoxDecoration(
                              color: Color(0xff8A38F5),
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                            child: Text(
                              "NEW",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 10.sp,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),

                /// التفاصيل
                Expanded(
                  flex: 3,
                  child: Padding(
                    padding: EdgeInsets.all(10.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                "$titleEn",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13.sp,
                                  color: Color(0xff5C5163),
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Image.asset(
                              "assets/child/adventures.png",
                              width: 14.w,
                              height: 14.h,
                            ),
                          ],
                        ),

                        SizedBox(height: 6.h),

                        /// Progress
                        Row(
                          children: [
                            Text(
                              "Progress",
                              style: TextStyle(
                                fontSize: 11.sp,
                                color: Color(0xff6B7280),
                              ),
                            ),
                            Spacer(),
                            Row(
                              // mainAxisAlignment: MainAxisAlignment.start,
                              children: List.generate(
                                totalDays == 0 ? 1 : totalDays,
                                (index) => Padding(
                                  padding: EdgeInsets.only(right: 3.w),
                                  child: Container(
                                    width: 6.w,
                                    height: 6.h,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: index < completedTasksCount
                                          ? AppColors.ActiveColor
                                          : const Color(0xffD9D9D9),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),

                        Spacer(),

                        /// Reward
                        Row(
                          children: [
                            Text(
                              "Reward",
                              style: TextStyle(
                                fontSize: 11.sp,
                                color: Color(0xff6B7280),
                              ),
                            ),
                            Spacer(),
                            Text(
                              '$bonusPoints',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 12.sp,
                                color: Color(0xff9CA3AF),
                              ),
                            ),
                            SizedBox(width: 4.w),
                            Image.asset(
                              "assets/child/coins.png",
                              width: 12.w,
                              height: 12.h,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          /// 🔒 Lock Overlay
          if (isLocked)
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.4),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Center(
                  child: Icon(Icons.lock, color: Colors.white, size: 30),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rewarding_kids/features/child/widgets/coin.dart';

class AdventureCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String step;
  final VoidCallback onMicTap;
  final IconData icon;

  const AdventureCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.step,
    required this.onMicTap,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: double.infinity, // عرض ثابت نسبي
        child: Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.center,
          children: [
            // 🟣 الطبقة السفلية الأولى (أكبر حاجة)
            Positioned(
              bottom: -40.h,
              child: Container(
                width: 140.w,
                height: 40.h,
                decoration: BoxDecoration(
                  color: const Color(0xffF9D6FF),
                  borderRadius: BorderRadius.circular(36.r),
                ),
              ),
            ),
            Positioned(
              bottom: -25.h,
              child: Container(
                width: 260.w,
                height: 70.h,
                decoration: BoxDecoration(
                  color: const Color(0xffF7B6FF),
                  borderRadius: BorderRadius.circular(72.r),
                ),
              ),
            ),

            // 🟪 الطبقة الثانية (الوسطى)

            // 🟣 الكارد الرئيسي (الخلفية الأساسية)
            Image.asset(
              "assets/child/Subtract.png",
              width: double.infinity,
              height: 285.h,
              fit: BoxFit.fill,
            ),

            // ✍️ المحتوى النصي
            Positioned.fill(
              child: Padding(
                padding: EdgeInsets.fromLTRB(20.w, 35.h, 20.w, 15.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 8.w,
                        vertical: 8.h,
                      ),
                      child: SvgPicture.asset(
                        "assets/child/quotation.svg",
                        width: 18.w,
                        height: 15.h,
                      ),
                    ), //SizedBox(height: 4.h),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 20.w,
                        vertical: 8.h,
                      ),
                      child: Text(
                        title,
                        style: TextStyle(
                          fontSize: 26.sp,
                          height: 1.3,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 20.w,
                        vertical: 8.h,
                      ),
                      child: Row(
                        children: [
                          Text(
                            subtitle,
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 14.sp,
                            ),
                          ),
                          Coin(),
                        ],
                      ),
                    ),
                    const Spacer(),
                    Center(
                      child: Text(
                        step,
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 12.sp,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // ⚪ الدائرة الكبيرة (الخلفية)

            // 🎤 الدائرة الصغيرة + الأيقونة
            Positioned(
              top: -2.h,
              right: 4.w,
              child: GestureDetector(
                onTap: onMicTap,
                child: Container(
                  width: 40.w,
                  height: 40.w,
                  padding: EdgeInsets.all(8.w),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xffD7A3FA),
                  ),
                  child: Icon(icon, color: Colors.white, size: 20.sp),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

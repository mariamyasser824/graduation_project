import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HowItWorksRow extends StatelessWidget {
  const HowItWorksRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: Text(
            "How it Work?",
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: Color(0xff483E62),
              fontSize: 14.sp,
            ),
          ),
        ),

        SizedBox(height: 10.h),

        /// 🔥 الجزء الأساسي
        Stack(
          alignment: Alignment.center,
          children: [
            /// الخط اللي واصل بينهم
            Positioned(
              left: 45.w,
              right: 45.w,
              top: 25.h,

              child: Center(
                child: Container(height: 4.h, color: Color(0xffDEDCEE)),
              ),
            ),

            /// العناصر
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: const [
                  WorkItem(image: "assets/child/daily.svg", label: "Daily"),
                  WorkItem(image: "assets/child/days.svg", label: "7 Days"),
                  WorkItem(image: "assets/child/adv_gift.svg", label: "Gift"),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class WorkItem extends StatelessWidget {
  final String image;
  final String label;

  const WorkItem({super.key, required this.image, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        /// الدائرة بالصورة
        Container(
          width: 48.w,
          height: 48.w,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Color(0xffBBB8DF),
            boxShadow: [
              BoxShadow(
                color: Color(0xf968CFD).withOpacity(0.2),
                blurRadius: 6,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Center(child: SvgPicture.asset(image)),
        ),

        SizedBox(height: 6.h),

        /// النص
        Text(
          label,
          style: TextStyle(
            fontSize: 12.sp,
            fontWeight: FontWeight.w600,
            color: Color(0xff483E62),
          ),
        ),
      ],
    );
  }
}

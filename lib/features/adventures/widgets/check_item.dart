import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rewarding_kids/Shared/CustomText.dart';

class CheckItem extends StatelessWidget {
  final String text;

  const CheckItem({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// علامة الصح
        Container(
          width: 20.w,
          height: 20.h,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Color(0xffA490AF),
          ),
          child: Center(
            child: Icon(Icons.check, size: 14.sp, color: Colors.white),
          ),
        ),

        SizedBox(width: 12.w),

        /// النص
        CustomText(
          text: text,
          iscenter: true,
          color: Color(0xff5C5163),
          size: 14.sp,
          weight: FontWeight.w400,
        ),
      ],
    );
  }
}

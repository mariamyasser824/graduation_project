import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rewarding_kids/Shared/CustomText.dart';
import 'package:rewarding_kids/core/constants/app_colors.dart';

class NotesToParent extends StatelessWidget {
  const NotesToParent({super.key, required this.controller});
  final TextEditingController controller;

  @override
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 115.h,
      decoration: BoxDecoration(
        //color: Color(0xffF8EAFF),
        borderRadius: BorderRadius.circular(16.r),
      ),

      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              SizedBox(
                width: 30.w,
                height: 24.h,
                //padding: EdgeInsets.all(4.w),
                //decoration: BoxDecoration(shape: BoxShape.circle),
                child: SvgPicture.asset('assets/icons/notes.svg'),
              ),
              CustomText(
                text: "Notes To Parent",
                iscenter: true,
                size: 14.sp,
                color: AppColors.titleColor,
                weight: FontWeight.w500,
              ),
            ],
          ),

          SizedBox(height: 8.h),
          Container(
            height: 80.h,
            decoration: BoxDecoration(
              color: Color(0xffAFA7FF).withOpacity(0.2),
              borderRadius: BorderRadius.circular(8.r),
            ),

            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 6.h),

              child: TextField(
                controller: controller,
                // أو true
                maxLines: 3,
                decoration: InputDecoration(
                  hintText: 'Write your note here...',
                  hintStyle: TextStyle(
                    fontSize: 14.sp,
                    color: Color(0xff5C5163),
                    fontWeight: FontWeight.w500,
                  ),
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

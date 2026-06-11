import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rewarding_kids/Shared/CustomText.dart';
import 'package:rewarding_kids/core/constants/app_colors.dart';

class Rejectsectioncard extends StatelessWidget {
  const Rejectsectioncard({super.key, required this.rejectReasonController});
  final TextEditingController rejectReasonController;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Container(
        width: double.infinity,
        height: 170.h,
        decoration: BoxDecoration(
          color: Color(0xffFFF4F4),
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 115.w,
                // height: 22.h,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(8.w),
                      child: SizedBox(
                        width: 30.w,
                        height: 22.h,

                        //decoration: BoxDecoration(shape: BoxShape.circle),
                        child: SvgPicture.asset('assets/icons/regected.svg'),
                      ),
                    ),
                    CustomText(
                      text: "Reason for rejection",
                      iscenter: true,
                      size: 14.sp,
                      color: AppColors.titleColor,
                      weight: FontWeight.w500,
                    ),
                  ],
                ),
              ),

              // SizedBox(height: 8.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.w),
                child: Container(
                  width: 332.w,
                  height: 70.h,
                  decoration: BoxDecoration(
                    color: Color(0xffFFE4E4),
                    borderRadius: BorderRadius.circular(8.r),
                    border: Border.all(color: Color(0xffFFAFCC), width: 0.5),
                  ),

                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 8.w,
                      vertical: 8.w,
                    ),
                    child: TextField(
                      controller: rejectReasonController,
                      // أو true
                      maxLines: 5,
                      decoration: InputDecoration(
                        hintText:
                            'gently explain to the child why the task wasn’taccepted and how it can be improved. .',
                        hintStyle: TextStyle(
                          fontSize: 14.sp,
                          color: Color(0xffABB2BD),
                          fontWeight: FontWeight.w500,
                        ),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
              ),
              CustomText(
                text:
                    "💡 Remember to be gentle and encouraging in your \n feedback",
                iscenter: false,
                size: 12.sp,
                color: Color(0xff868C97),
                weight: FontWeight.w400,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rewarding_kids/Shared/CustomText.dart';
import 'package:rewarding_kids/core/constants/app_colors.dart';

class NotesFromChild extends StatelessWidget {
  final String note;

  const NotesFromChild({super.key, required this.note});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Container(
        width: double.infinity,
        height: 105.h,
        decoration: BoxDecoration(
          color: Color(0xffF8EAFF),
          borderRadius: BorderRadius.circular(8.r),
        ),

        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),

          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 135.w,
                // height: 22.h,
                child: Row(
                  children: [
                    SizedBox(
                      width: 30.w,
                      height: 24.h,
                      //padding: EdgeInsets.all(4.w),
                      //decoration: BoxDecoration(shape: BoxShape.circle),
                      child: SvgPicture.asset('assets/icons/notes.svg'),
                    ),
                    CustomText(
                      text: "Notes From Child",
                      iscenter: true,
                      size: 14.sp,
                      color: AppColors.titleColor,
                      weight: FontWeight.w500,
                    ),
                  ],
                ),
              ),

              SizedBox(height: 8.h),
              Container(
                height: 50.h,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Color(0xffF4DFFF),
                  borderRadius: BorderRadius.circular(8.r),
                  border: Border.all(color: Color(0xff7B6C83), width: 1),
                ),

                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 16.h,
                  ),
                  child: Text(
                    note,
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: AppColors.titleColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

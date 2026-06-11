import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rewarding_kids/Shared/CustomText.dart';
import 'package:rewarding_kids/core/constants/app_colors.dart';

class TaskImagesCard extends StatelessWidget {
  const TaskImagesCard({super.key, this.imageUrl});
  final String? imageUrl;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Container(
        width: double.infinity,
        height: 180.h,
        decoration: BoxDecoration(
          color: Color(0xffF8EAFF),
          borderRadius: BorderRadius.circular(16.r),
        ),

        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 115.w,
                //height: 22.h,
                child: Row(
                  children: [
                    SizedBox(
                      width: 30.w,
                      height: 22.h,
                      //padding: EdgeInsets.all(4.w),
                      // decoration: BoxDecoration(shape: BoxShape.circle),
                      child: SvgPicture.asset('assets/icons/task_image.svg'),
                    ),
                    CustomText(
                      text: "Task Images",
                      iscenter: true,
                      size: 14.sp,
                      color: AppColors.titleColor,
                      weight: FontWeight.w500,
                    ),
                  ],
                ),
              ),
              Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.r),
                  child: imageUrl != null
                      ? Image.network(
                          imageUrl!,
                          height: 120.h,
                          width: 120.w,
                          fit: BoxFit.cover,
                        )
                      : Text("No image"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

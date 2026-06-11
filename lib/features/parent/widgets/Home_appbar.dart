import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rewarding_kids/Shared/CustomText.dart';
import 'package:rewarding_kids/core/constants/app_colors.dart';
import 'package:rewarding_kids/features/parent/widgets/AddTaskButton.dart';

class HomeAppbar extends StatelessWidget {
  const HomeAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 16.h),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.9,
        height: MediaQuery.of(context).size.height * 0.04,
        decoration: BoxDecoration(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: 45.w,
              height: 35.h,
              decoration: BoxDecoration(
                color: Color(0xffF0E8F4),
                borderRadius: BorderRadius.all(Radius.circular(8)),
                border: Border.all(color: Color(0xffD0C0D8)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Image.asset(
                    'assets/child/coins.png',
                    width: 16.w,
                    height: 16.h,
                  ),
                  CustomText(
                    text: "0",
                    iscenter: true,
                    size: 10.sp,
                    color: AppColors.titleColor,
                    weight: FontWeight.w500,
                  ),
                ],
              ),
            ),
            AddTaskButton(onTap: () {}, text: 'Add child'),
            SvgPicture.asset(
              "assets/icons/notification.svg",
              width: 14.w,
              height: 16.h,
            ),
          ],
        ),
      ),
    );
  }
}

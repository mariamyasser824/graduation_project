import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:rewarding_kids/Shared/CustomText.dart';

class TaskHeader extends StatelessWidget {
  const TaskHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50.h,
      width: 265.w,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {
              context.push('/child_profile');
            },
            child: Container(
              width: 48.w,
              height: 48.h,

              decoration: BoxDecoration(shape: BoxShape.circle),
              child: CircleAvatar(
                backgroundImage: AssetImage('assets/child/girlavatar.png'),
                radius: 40.r,
              ),
            ),
          ),
          SizedBox(width: 12.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomText(
                text: 'Hello, Nilly',
                iscenter: true,
                color: Color(0xff5C5163),
                size: 14.sp,
                weight: FontWeight.w400,
              ),
              CustomText(
                text: 'Today’s Magic Mission ',
                iscenter: true,
                color: Color(0xff55425F),
                size: 16.sp,
                weight: FontWeight.w600,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

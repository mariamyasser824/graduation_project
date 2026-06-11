import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rewarding_kids/Shared/CustomText.dart';

class ApprovingButtons extends StatelessWidget {
  const ApprovingButtons({
    super.key,
    required this.onApprove,
    required this.onReject,
  });
  final VoidCallback onApprove;
  final VoidCallback onReject;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: onReject,
            child: Container(
              width: 170.w,
              height: 50.h,
              decoration: BoxDecoration(
                color: const Color(0xffFFE3E2),
                borderRadius: BorderRadius.circular(8.r),
                border: Border.all(color: const Color(0xffE8ACB0)),
              ),
              child: Center(
                child: CustomText(
                  text: 'NO!  Redo the task!',
                  size: 14.sp,
                  color: const Color(0xffF15963),
                  weight: FontWeight.w500,
                  iscenter: true,
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: onApprove,
            child: Container(
              width: 170.w,
              height: 50.h,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xff00C953), Color(0xff00BC7A)],
                ),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Center(
                child: CustomText(
                  text: 'Yes Perfect!',
                  size: 14.sp,
                  color: const Color(0xffFAF8FB),
                  weight: FontWeight.w500,
                  iscenter: true,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

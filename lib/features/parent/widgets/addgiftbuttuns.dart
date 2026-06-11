import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rewarding_kids/Shared/CustomText.dart';

class Addgiftbuttuns extends StatelessWidget {
  const Addgiftbuttuns({
    super.key,
    required this.onApprove,
    required this.onReject,
  });

  final VoidCallback onApprove;
  final VoidCallback onReject;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: onReject,
            child: Container(
              width: 170.w,
              height: 50.h,
              decoration: BoxDecoration(
                color: const Color(0xffCBBFBE),
                borderRadius: BorderRadius.circular(8.r),
                border: Border.all(color: const Color(0xffD5CACB), width: 1.w),
              ),
              child: Center(
                child: CustomText(
                  text: 'Cancel',
                  size: 14.sp,
                  color: const Color(0xff817273),
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
                  colors: [Color(0xffF462AB), Color(0xff9C6CFE)],
                ),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Center(
                child: CustomText(
                  text: 'Add Gift',
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

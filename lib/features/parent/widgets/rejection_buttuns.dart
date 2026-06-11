import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rewarding_kids/Shared/CustomText.dart';

class RejectionButtuns extends StatelessWidget {
  const RejectionButtuns({
    super.key,
    required this.cancel,
    required this.confirmRejection,
  });
  final VoidCallback cancel;
  final VoidCallback confirmRejection;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: cancel,
            child: Container(
              width: 170.w,
              height: 50.h,
              decoration: BoxDecoration(
                color: const Color(0xffC5C7D0),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Center(
                child: CustomText(
                  text: 'Cancel',
                  size: 14.sp,
                  color: const Color(0xff617E99),
                  weight: FontWeight.w500,
                  iscenter: true,
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: confirmRejection,
            child: Container(
              width: 170.w,
              height: 50.h,
              decoration: BoxDecoration(
                color: Color(0xffEA514C),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Center(
                child: CustomText(
                  text: ' Confirm Rejection',
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

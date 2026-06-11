import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rewarding_kids/Shared/CustomText.dart';
import 'package:rewarding_kids/features/parent/cubit/reward_cubit/reward_cubit.dart';

class Giftcard2 extends StatelessWidget {
  const Giftcard2({
    super.key,
    required this.title,
    required this.imageUrl,
    required this.points,
    required this.buttonText,
    required this.onPressed,
    required this.fit,
    required this.id,
  });

  final String title;
  final String imageUrl;
  final int points;
  final String id;
  final String buttonText;
  final VoidCallback onPressed;
  final BoxFit fit;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10.r,
            offset: Offset(0, 4.h),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// 🖼 Image
          SizedBox(
            height: width > 600 ? 120.h : 100.h,
            width: double.infinity,
            child: ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
              child: Image.network(imageUrl, fit: fit),
            ),
          ),

          /// 📦 Content
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(12.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// 🎁 Title
                  Flexible(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomText(
                          text: title,
                          weight: FontWeight.w500,
                          color: Color(0xff5C5163),
                          size: 14.sp,
                          iscenter: true,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,

                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 5.w),
                              child: Container(
                                width: 24.w,
                                height: 24.h,
                                decoration: BoxDecoration(
                                  color: Color(0xffE8F3FD),
                                  border: Border.all(
                                    color: Color(0xffB9DAF9),
                                    width: 1.w,
                                  ),
                                  borderRadius: BorderRadius.circular(4.r),
                                ),
                                child: SvgPicture.asset(
                                  width: 16.w,
                                  height: 16.h,
                                  'assets/icons/edit.svg',
                                ),
                              ),
                            ),

                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 5.w),
                              child: GestureDetector(
                                onTap: () {
                                  context.read<RewardCubit>().deleteReward(id);
                                },
                                child: Container(
                                  width: 24.w,
                                  height: 24.h,
                                  decoration: BoxDecoration(
                                    color: Color(0xffFFE6E6),
                                    border: Border.all(
                                      color: Color(0xffFFB3B3),
                                      width: 1.w,
                                    ),
                                    borderRadius: BorderRadius.circular(4.r),
                                  ),
                                  child: SvgPicture.asset(
                                    'assets/icons/delete.svg',
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20.h),

                  /// 🎯 Target & Points
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SvgPicture.asset(
                            'assets/gifts/target.svg',
                            width: 12.w,
                            height: 12.h,
                          ),
                          SizedBox(width: 6.w),
                          CustomText(
                            text: 'Target',
                            size: 12.sp,
                            color: Color(0xff5C5163),
                            iscenter: true,
                          ),
                        ],
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Image.asset(
                            'assets/child/coins.png',
                            width: 16.w,
                            height: 16.h,
                          ),
                          SizedBox(width: 6.w),
                          CustomText(
                            text: '$points',
                            size: 13.sp,
                            weight: FontWeight.w500,
                            iscenter: true,
                            color: Color(0xff5C5163),
                          ),
                        ],
                      ),
                    ],
                  ),

                  SizedBox(height: 16.h),

                  /// 🔘 Button
                  SizedBox(
                    width: double.infinity,
                    height: 32.h,
                    child: GestureDetector(
                      onTap: onPressed,
                      child: Container(
                        width: 156.w,
                        height: 32.h,
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [Color(0xffF68EC2), Color(0xffA077F1)],
                          ),
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        alignment: Alignment.center,
                        child: CustomText(
                          text: buttonText,
                          color: Colors.white,
                          weight: FontWeight.w600,
                          size: 14.sp,
                          iscenter: true,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

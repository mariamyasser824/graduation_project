import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:rewarding_kids/Shared/CustomText.dart';
import 'package:rewarding_kids/features/adventures/widgets/start_adventure_button.dart';

class IntroCard extends StatelessWidget {
  const IntroCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: 415.h,
          left: 32.w,
          right: 32.w,
          child: Container(
            height: 375.h,
            width: 330.w,
            padding: EdgeInsets.fromLTRB(16.w, 60.h, 16.w, 16.h),
            decoration: BoxDecoration(
              color: Color(0xffF7F1FF),
              borderRadius: BorderRadius.circular(16.r),

              boxShadow: [
                BoxShadow(
                  color: Color(0xffA68F8F).withOpacity(0.25),
                  blurRadius: 20,
                  offset: const Offset(0, 8),
                ),
              ],
            ),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 30.h),
                CustomText(
                  text: 'Day 1',
                  iscenter: true,
                  color: Color(0xff55425F),
                  size: 24.sp,
                  weight: FontWeight.w700,
                ),
                SizedBox(height: 10.h),
                CustomText(
                  text: 'Your Adventure Begins! 🚀 ',
                  iscenter: true,
                  color: Color(0xff7B6C83),
                  size: 18.sp,
                  weight: FontWeight.w700,
                ),
                SizedBox(height: 10.h),
                CustomText(
                  text:
                      'Let\’s start your first mission and light up the\n path!',
                  iscenter: true,
                  color: Color(0xff7B6C83),
                  size: 14.sp,
                  weight: FontWeight.w400,
                ),
                SizedBox(height: 15.h),

                CustomText(
                  text:
                      'Finish your first task to light up the path and \nunlock surprises 🎁”',
                  iscenter: true,
                  color: Color(0xff55425F),
                  size: 14.sp,
                  weight: FontWeight.w400,
                ),

                Spacer(),
                StartAdventureButton(
                  onTap: () {
                    context.push('/adv_voice_task');
                  },
                  text: 'Let\’s Start',
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

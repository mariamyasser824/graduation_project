import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rewarding_kids/Shared/CustomText.dart';
import 'package:rewarding_kids/core/constants/app_colors.dart';

class GiftSuccessDialog extends StatelessWidget {
  const GiftSuccessDialog({super.key, required this.text});
  final String text;
  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 24),
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.topCenter,
        children: [
          /// الكارد الأبيض
          Container(
            width: 272.w,
            height: 250.h,
            //margin: const EdgeInsets.only(top: 60),
            // padding: const EdgeInsets.fromLTRB(20, 70, 20, 24),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    "assets/icons/gift.svg",
                    width: 50.w,
                    height: 50.h,
                  ),
                  CustomText(
                    text: text,
                    iscenter: true,
                    size: 18.sp,
                    color: AppColors.titleColor,
                    weight: FontWeight.w500,
                  ),

                  /// زر
                  /*  SizedBox(
                    width: double.infinity,
                    height: 44,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xffA077F1),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('Done'),
                    ),
                  ),*/
                ],
              ),
            ),
          ),

          /// 🎁 الـ GIF فوق
          Positioned(
            top: -30,
            child: Image.asset(
              'assets/animations/Gift_celebration.gif', // أو png
              width: 220.w,
              height: 290.h,
              fit: BoxFit.fill,
            ),
          ),
        ],
      ),
    );
  }
}

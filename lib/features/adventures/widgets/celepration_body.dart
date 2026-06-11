import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:go_router/go_router.dart';
import 'package:rewarding_kids/Shared/CustomText.dart';
import 'package:rewarding_kids/features/adventures/widgets/start_adventure_button.dart';
import 'package:rewarding_kids/features/child/widgets/homeAppbar.dart';

class CeleprationBody extends StatefulWidget {
  const CeleprationBody({super.key});

  @override
  State<CeleprationBody> createState() => _CeleprationBodyState();
}

class _CeleprationBodyState extends State<CeleprationBody> {
  @override
  final AudioPlayer _audioPlayer = AudioPlayer();
  bool _showCelebration = true;

  @override
  void initState() {
    super.initState();

    // تحميل الـ GIF
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        precacheImage(
          const AssetImage(' assets/child/adv_celeprte_gif.gif'),
          context,
        );
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
              child: HomeAppbar(),
            ),
            SizedBox(height: 60.h),
            CustomText(
              text: "Mission Completed!",
              iscenter: true,
              weight: FontWeight.w600,
              size: 20.sp,
              color: Color(0xff5C5163),
            ),
            SizedBox(height: 10.h),
            CustomText(
              text: "You finished today\’s adventure step ✨",
              iscenter: true,
              weight: FontWeight.w500,
              size: 16.sp,
              color: Color(0xff7B6C83),
            ),
            SizedBox(height: 10.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomText(
                  text: "Earned 40 magic points! ",
                  iscenter: true,
                  weight: FontWeight.w500,
                  size: 18.sp,
                  color: Color(0xff7B6C83),
                ),
                SizedBox(
                  width: 16.w,
                  height: 16.h,
                  child: Image.asset('assets/child/coins.png'),
                ),
              ],
            ),
            Center(
              child: SizedBox(
                width: 280.w,
                height: 280.h,
                child: Image.asset(
                  'assets/child/adv_celeprte.png',
                  fit: BoxFit.cover,
                ),
              ),
            ),

            Spacer(),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
              child: StartAdventureButton(
                onTap: () {
                  context.push('/Custombottomnav');
                },
                text: 'Continue Adventure',
              ),
            ),
          ],
        ),

        Positioned(
          top: 489.h,
          left: -69.w,
          child: Container(
            width: 104.5.w,
            height: 104.5.h,
            child: Image.asset(
              "assets/child/adv_celeprte_gif.gif", // أو أي صورة عندك

              fit: BoxFit.cover,
            ),
          ),
        ),
        Positioned(
          top: 489.h,
          left: 354.5.w,
          child: Transform.rotate(
            angle: -180 * 3.14159 / 180, // -180 درجة
            child: Container(
              width: 104.5.w,
              height: 104.5.h,
              child: Image.asset(
                "assets/child/adv_celeprte_gif.gif", // أو أي صورة عندك

                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

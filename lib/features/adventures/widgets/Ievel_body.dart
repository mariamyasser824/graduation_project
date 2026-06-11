import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:rewarding_kids/features/adventures/models/level_model.dart';
import 'package:rewarding_kids/features/adventures/widgets/level_circle.dart';
import 'package:rewarding_kids/features/adventures/widgets/target_card.dart';
import 'package:rewarding_kids/features/onboarding/widgets/popbutton.dart';

List<LevelModel> levels = [
  LevelModel(number: 1, state: LevelState.completed, stars: 3),
  LevelModel(number: 2, state: LevelState.completed, stars: 2),
  LevelModel(number: 3, state: LevelState.inProgress, stars: 0),
  LevelModel(number: 4, state: LevelState.unlocked, stars: 0),
  LevelModel(number: 5, state: LevelState.locked, stars: 0),
  LevelModel(number: 6, state: LevelState.locked, stars: 0),
  LevelModel(number: 7, state: LevelState.locked, stars: 0),
];

class LevelBody extends StatelessWidget {
  const LevelBody({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Stack(
          children: [
            /// 🌑 Background (Grayscale)
            ColorFiltered(
              colorFilter: const ColorFilter.matrix([
                0.2126,
                0.7152,
                0.0722,
                0,
                0,
                0.2126,
                0.7152,
                0.0722,
                0,
                0,
                0.2126,
                0.7152,
                0.0722,
                0,
                0,
                0,
                0,
                0,
                1,
                0,
              ]),
              child: Image.asset(
                "assets/child/backgound_levels.jpg",
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
              ),
            ),

            /// overlay خفيف
            Container(color: Color(0xff857B8D).withOpacity(0.1)),

            /// 🛤️ Paths
            Positioned(
              top: constraints.maxHeight * 0.25,
              left: constraints.maxWidth * 0.05,
              child: Image.asset("assets/child/path1.png"),
            ),

            Positioned(
              top: constraints.maxHeight * 0.26,
              left: constraints.maxWidth * 0.09,
              child: Image.asset("assets/child/path2.png"),
            ),

            /// 🎯 Target
            Positioned(
              top: constraints.maxHeight * 0.80,
              left: constraints.maxWidth * 0.04,
              child: SvgPicture.asset("assets/child/target_level.svg"),
            ),

            Positioned(
              top: constraints.maxHeight * 0.87,
              left: constraints.maxWidth * 0.07,
              child: TargetCard(currentLevel: 2, totalLevels: 7),
            ),

            /// 🎁 Gift
            Positioned(
              top: constraints.maxHeight * 0.22,
              left: constraints.maxWidth * 0.45,
              child: Container(
                width: 96.w,
                height: 96.h,
                decoration: const BoxDecoration(
                  color: Color(0xffF9F9FB),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Image.asset("assets/child/level_gift.png"),
                ),
              ),
            ),

            /// 🔥 Levels
            Positioned(
              top: constraints.maxHeight * 0.75,
              left: constraints.maxWidth * 0.55,
              child: LevelCircle(
                level: levels[0],
                onTap: () => context.push('/intro_level'),
              ),
            ),

            Positioned(
              top: constraints.maxHeight * 0.70,
              left: constraints.maxWidth * 0.30,
              child: LevelCircle(
                level: levels[1],
                onTap: () => context.push('/intro_level'),
              ),
            ),

            Positioned(
              top: constraints.maxHeight * 0.55,
              left: constraints.maxWidth * 0.78,
              child: LevelCircle(
                level: levels[2],
                onTap: () => context.push('/intro_level'),
              ),
            ),

            Positioned(
              top: constraints.maxHeight * 0.48,
              left: constraints.maxWidth * 0.60,
              child: LevelCircle(
                level: levels[3],
                onTap: () => context.push('/intro_level'),
              ),
            ),

            Positioned(
              top: constraints.maxHeight * 0.55,
              left: constraints.maxWidth * 0.25,
              child: LevelCircle(level: levels[4], onTap: () {}),
            ),

            Positioned(
              top: constraints.maxHeight * 0.40,
              left: constraints.maxWidth * 0.35,
              child: LevelCircle(level: levels[5], onTap: () {}),
            ),

            Positioned(
              top: constraints.maxHeight * 0.28,
              left: constraints.maxWidth * 0.80,
              child: LevelCircle(level: levels[6], onTap: () {}),
            ),

            /// 🧠 Header
            Column(
              children: [
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.w,
                        vertical: 16.h,
                      ),
                      child: Popbutton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),

                    Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: 16.h,
                        horizontal: 50.w,
                      ),
                      child: Column(
                        children: [
                          ShaderMask(
                            shaderCallback: (bounds) => LinearGradient(
                              colors: [Color(0xff87205C), Color(0xff350C25)],
                            ).createShader(bounds),
                            child: Text(
                              "Adventure Name",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),

                          SizedBox(height: 4.h),

                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                "Day 6 of 7 . ",
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  color: Color(0xff483F4D),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 6.w,
                                  vertical: 2.h,
                                ),
                                decoration: BoxDecoration(
                                  color: Color(0xff87205C).withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Text(
                                  "Almost there!💪",
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xff483F4D),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:rewarding_kids/features/adventures/models/adventure_details_model.dart';
import 'package:rewarding_kids/features/adventures/models/level_model.dart';
import 'package:rewarding_kids/features/adventures/widgets/level_circle.dart';
import 'package:rewarding_kids/features/adventures/widgets/target_card.dart';
import 'package:rewarding_kids/features/onboarding/widgets/popbutton.dart';

class LevelBody extends StatelessWidget {
  final AdventureDetailsModel details;

  const LevelBody({super.key, required this.details});

  List<LevelModel> mapTasksToLevels() {
    return details.tasks.map((task) {
      LevelState state;

      switch (task.accessStatus) {
        case "Locked":
          state = LevelState.locked;
          break;
        case "Unlocked":
          state = LevelState.unlocked;
          break;
        case "Done":
          state = LevelState.completed;
          break;
        default:
          state = LevelState.locked;
      }

      return LevelModel(
        number: task.dayNumber ?? 0,
        state: state,
        stars: task.earnedStars ?? 0,
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final levels = mapTasksToLevels();

    /// positions بتتكرر لو الليفلات أكتر
    final positions = [
      Offset(0.55, 0.75),
      Offset(0.30, 0.70),
      Offset(0.78, 0.55),
      Offset(0.60, 0.48),
      Offset(0.25, 0.55),
      Offset(0.35, 0.40),
      Offset(0.80, 0.28),
    ];

    return LayoutBuilder(
      builder: (context, constraints) {
        return Stack(
          children: [
            /// 🌑 Background
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

            Container(color: const Color(0xff857B8D).withOpacity(0.1)),

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
              child: TargetCard(
                currentLevel: details.currentDay ?? 1,
                totalLevels: details.totalDays ?? levels.length,
              ),
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

            /// 🔥 Levels Dynamic
            ...levels.asMap().entries.map((entry) {
              int index = entry.key;
              LevelModel level = entry.value;

              final pos = positions[index % positions.length];

              return Positioned(
                top: constraints.maxHeight * pos.dy,
                left: constraints.maxWidth * pos.dx,
                child: LevelCircle(
                  level: level,
                  onTap: level.state == LevelState.locked
                      ? null
                      : () {
                          context.push(
                            '/intro_level',
                            extra: details.tasks[index],
                          );
                        },
                ),
              );
            }).toList(),

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
                        horizontal: 30.w,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ShaderMask(
                            shaderCallback: (bounds) => const LinearGradient(
                              colors: [Color(0xff87205C), Color(0xff350C25)],
                            ).createShader(bounds),
                            child: Text(
                              details.titleEn ?? "Adventure",
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
                                "Day ${details.currentDay ?? 1} of ${details.totalDays ?? levels.length} . ",
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  color: const Color(0xff483F4D),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 6.w,
                                  vertical: 2.h,
                                ),
                                decoration: BoxDecoration(
                                  color: const Color(
                                    0xff87205C,
                                  ).withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Text(
                                  "Keep going 💪",
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w500,
                                    color: const Color(0xff483F4D),
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

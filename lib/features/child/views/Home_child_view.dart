import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rewarding_kids/core/constants/app_colors.dart';
import 'package:rewarding_kids/features/adventures/widgets/adventure_grid.dart';
import 'package:rewarding_kids/features/adventures/widgets/adventure_header.dart';
import 'package:rewarding_kids/features/child/widgets/homeAppbar.dart';
import 'package:rewarding_kids/features/child/widgets/taskstabs.dart';
import '../widgets/taskslist.dart';

class HomeChildView extends StatefulWidget {
  const HomeChildView({super.key});

  @override
  State<HomeChildView> createState() => _HomeChildViewState();
}

class _HomeChildViewState extends State<HomeChildView> {
  bool showComingSoon = false;

  void triggerComingSoon() {
    setState(() => showComingSoon = true);

    Future.delayed(const Duration(seconds: 5), () {
      if (mounted) {
        setState(() => showComingSoon = false);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.Background,
      body: Stack(
        children: [
          SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
              child: Column(
                children: [
                  HomeAppbar(),

                  Expanded(
                    child: Taskstabs(
                      widget1: Taskslist(),
                      widget2: Taskslist(),
                      widget3: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: AdventureHeader(),
                          ),
                          Expanded(
                            child: AdventureGrid(
                              onLockedTap: triggerComingSoon,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          /// 🔥 FULL SCREEN OVERLAY
          if (showComingSoon)
            Positioned.fill(
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 300),
                opacity: showComingSoon ? 1 : 0,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    /// 🟣 Overlay خفيف جدًا (مش أبيض تقيل)
                    Container(color: Colors.white.withOpacity(0.10)),

                    /// 💎 Glass Card (هو اللي فيه البلور الحقيقي)
                    Center(
                      child: TweenAnimationBuilder(
                        duration: const Duration(milliseconds: 350),
                        tween: Tween(begin: 0.96, end: 1.0),
                        curve: Curves.easeOut,
                        builder: (context, value, child) =>
                            Transform.scale(scale: value, child: child),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(22),
                          child: BackdropFilter(
                            /// 👈 البلور هنا مش في الخلفية
                            filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.78,
                              height: 122.h,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 22,
                                vertical: 18,
                              ),
                              decoration: BoxDecoration(
                                /// 👈 أهم سطر: لون جلاس فاتح جدًا
                                color: Colors.white.withOpacity(0.25),

                                borderRadius: BorderRadius.circular(22),

                                /// Glow خفيف
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.white.withOpacity(0.25),
                                    blurRadius: 20,
                                    spreadRadius: 1,
                                  ),
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.08),
                                    blurRadius: 25,
                                    offset: const Offset(0, 10),
                                  ),
                                ],
                              ),

                              /// ✨ المحتوى (أبيض زي الصورة)
                              child: Stack(
                                children: [
                                  Center(
                                    child: Icon(
                                      Icons.lock,
                                      size: 30,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      /// 🔒 أيقونة بيضا

                                      /// 🔥 عنوان أبيض
                                      Center(
                                        child: Text(
                                          "Coming Soon ✨",
                                          style: TextStyle(
                                            fontSize: 20.sp,
                                            fontWeight: FontWeight.w700,
                                            color: AppColors.titleColor,
                                          ),
                                        ),
                                      ),

                                      const SizedBox(height: 6),

                                      /// 📝 subtitle أبيض شفاف شوية
                                      Center(
                                        child: Text(
                                          "New adventures unlock next week!",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: 16.sp,
                                            color: AppColors.titleColor,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
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

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:rewarding_kids/core/constants/app_colors.dart';
import 'package:rewarding_kids/core/utils/pref_helper.dart';
import 'package:rewarding_kids/features/auth/data/services/auth_service.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    checkLoginStatus();
  }

  /// نفحص هل فيه توكن محفوظ
  ///
  void checkLoginStatus() async {
    await Future.delayed(const Duration(seconds: 2));

    final seenOnboarding = await PrefHelper.getOnBoardingSeen();
    final token = await PrefHelper.getAccessToken();
    final userType = await PrefHelper.getUserType();

    /// لو اول مرة
    if (!seenOnboarding) {
      context.push('/onboarding');
      return;
    }

    /// لو فيه توكن
    if (token != null && token.isNotEmpty) {
      if (userType == "Child") {
        context.go('/Custombottomnav');
        return;
      }
      final childId = await PrefHelper.getChildId();

      if (childId != null && childId.isNotEmpty) {
        context.go('/Layout');
      } else {
        context.push('/getstarted');
      }
    }
    /// لو مفيش توكن
    else {
      context.push('/getstarted');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.Background,
      body: Center(
        child: Text(
          "GoKid!",
          style: TextStyle(
            fontSize: 40.sp,
            fontWeight: FontWeight.bold,
            color: AppColors.ActiveColor,
            letterSpacing: 2.w,
          ),
        ),
      ),
    );
  }
}

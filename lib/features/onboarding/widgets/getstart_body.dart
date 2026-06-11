import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rewarding_kids/Shared/Custombutton.dart';
import 'package:rewarding_kids/features/onboarding/widgets/loginbutton.dart';
import 'package:rewarding_kids/features/onboarding/widgets/page_body.dart';
import 'package:rewarding_kids/features/onboarding/widgets/popbutton.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GetstartBody extends StatelessWidget {
  const GetstartBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: MediaQuery.of(context).size.height,
          ),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 120.h),
              // // بدل MediaQuery
              Flexible(
                flex: 5,
                child: PageBody(
                  titletxt: '\nWelcome to GoKid!👋',
                  desctxt:
                      'Create fun, meaningful tasks that help kids learn,\n  grow, and stay motivated! 💪🎁',
                  image: 'assets/onboarding/onboarding4.png',
                ),
              ),
              const Spacer(), // 👈 دي السحر

              Custombutton(
                onPressed: () {
                  context.push('/signup');
                },
                text: 'Sign Up',
              ),
              SizedBox(height: 12.h),

              Loginbutton(),
              SizedBox(height: 20.h),
            ],
          ),
        ),
      ),
    );
  }
}

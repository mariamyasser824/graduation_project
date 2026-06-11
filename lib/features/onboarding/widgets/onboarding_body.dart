import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rewarding_kids/features/onboarding/data/onboardingdata.dart';
import 'package:rewarding_kids/features/onboarding/widgets/onboarding_slider.dart';
import 'package:rewarding_kids/features/onboarding/widgets/popbutton.dart';
import 'package:rewarding_kids/features/onboarding/widgets/skipbutton.dart';

class OnboardingBody extends StatefulWidget {
  const OnboardingBody({super.key});

  @override
  State<OnboardingBody> createState() => _OnboardingBodyState();
}

class _OnboardingBodyState extends State<OnboardingBody> {
  final PageController _controller = PageController();
  int currentPage = 0;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 12.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                currentPage == 0
                    ? SizedBox()
                    : Popbutton(
                        onPressed: () {
                          if (currentPage > 0) {
                            _controller.previousPage(
                              duration: const Duration(milliseconds: 200),
                              curve: Curves.easeInOut,
                            );
                          }
                        },
                      ),
                if (currentPage != onboardingData.length - 1)
                  const Skipbutton(),
              ],
            ),
          ),

          // ---- Spacer for top gap ----
          SizedBox(height: 0.05.sh), // 5% of screen height
          // ---- Slider ----
          Expanded(
            child: OnboardingSlider(
              controller: _controller,
              onPageChanged: (index) {
                setState(() => currentPage = index);
              },
            ),
          ),

          // ---- Bottom Spacer ----
          SizedBox(height: 0.05.sh), // 5% of screen height
        ],
      ),
    );
  }
}

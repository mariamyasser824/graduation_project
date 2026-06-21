import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:rewarding_kids/Shared/CustomText.dart';
import 'package:rewarding_kids/Shared/Custombutton.dart';
import 'package:rewarding_kids/core/constants/app_colors.dart';
import 'package:rewarding_kids/features/child/cubit/SubmitTaskCubit.dart';
import 'package:rewarding_kids/features/child/data/models/task_model.dart';
import 'package:rewarding_kids/features/child/widgets/coin.dart';
import 'package:rewarding_kids/features/child/widgets/homeAppbar.dart';
import 'package:rewarding_kids/features/onboarding/widgets/popbutton.dart';

class VoiceTaskView extends StatelessWidget {
  const VoiceTaskView({super.key, required this.Taskdetails});
  final TaskModel Taskdetails;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.Background,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
          child: Column(
            children: [
              Row(
                children: [
                  Popbutton(
                    onPressed: () {
                      if (context.canPop()) {
                        context.pop();
                      } else {
                        context.go('/Custombottomnav');
                      }
                    },
                  ),
                  SizedBox(width: 70.w),
                  Expanded(
                    child: CustomText(
                      text: Taskdetails.titleEn,
                      iscenter: true,
                      size: 20.sp,
                      color: AppColors.titleColor,
                      weight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 25.h),
              HomeAppbar(),
              SizedBox(height: 30.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 13.h),
                child: SizedBox(
                  width: double.infinity,
                  height: 375.h,
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 8.h),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15.r),
                          child: Container(
                            width: 278.w,
                            height: 210.h,

                            child: (Taskdetails.hasIcon)
                                ? Image.network(
                                    Taskdetails.iconUrl!,
                                    width: 80.w,
                                    height: 80.h,
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) {
                                      return Image.asset(
                                        'assets/child/drawflower.jpg',
                                        width: 80.w,
                                        height: 80.h,
                                      );
                                    },
                                  )
                                : Image.asset(
                                    'assets/child/drawflower.jpg',
                                    width: 80.w,
                                    height: 80.h,
                                  ),
                          ),
                        ),
                      ),
                      SizedBox(height: 30.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CustomText(
                            text: "${Taskdetails.descriptionEn}",
                            iscenter: true,
                            size: 14.sp,
                            color: AppColors.descColor,
                            weight: FontWeight.w400,
                          ),
                        ],
                      ),
                      SizedBox(height: 50.h),
                      SizedBox(
                        width: 129.w,
                        height: 27.h,
                        child: Row(
                          children: [
                            CustomText(
                              text: 'Reward:',
                              iscenter: true,
                              size: 18.sp,
                              weight: FontWeight.w500,
                              color: AppColors.titleColor,
                            ),
                            SizedBox(width: 10.h),

                            CustomText(
                              text: '${Taskdetails.basePoints}',
                              iscenter: true,
                              size: 18.sp,
                              weight: FontWeight.w500,
                              color: AppColors.titleColor,
                            ),

                            SizedBox(width: 5.h),
                            Coin(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Spacer(),
              Custombutton(
                onPressed: () {
                  context.push(
                    '/record_task',
                    extra: {"type": SubmitType.normal, "task": Taskdetails},
                  );
                },
                text: 'Start',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

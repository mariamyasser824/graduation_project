import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:rewarding_kids/core/constants/app_colors.dart';
import 'package:rewarding_kids/Shared/CustomText.dart';
import 'package:rewarding_kids/features/child/cubit/SubmitTaskCubit.dart';
import 'package:rewarding_kids/features/child/cubit/SubmitTaskState%20.dart';
import 'package:rewarding_kids/features/child/data/models/task_model.dart';
import 'package:rewarding_kids/features/child/widgets/Uploadimage.dart';
import 'package:rewarding_kids/features/child/widgets/homeAppbar.dart';
import 'package:rewarding_kids/features/onboarding/widgets/popbutton.dart';

class UploadImageView extends StatelessWidget {
  const UploadImageView({
    super.key,
    required this.Taskdetails,
    this.imagePath,
    required this.type,
    this.adventureTaskId,
    this.weeklyAdventureId,
  });
  final dynamic Taskdetails;
  final String? imagePath;
  final SubmitType type;
  final String? adventureTaskId;
  final String? weeklyAdventureId;

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
                  CustomText(
                    text: Taskdetails.titleEn,
                    iscenter: true,
                    size: 20.sp,
                    color: AppColors.titleColor,
                    weight: FontWeight.w600,
                  ),
                ],
              ),
              SizedBox(height: 25.h),
              HomeAppbar(),
              SizedBox(height: 20.h),

              Expanded(
                child: Uploadimage(
                  Taskdetails: Taskdetails,
                  imagePath: imagePath,
                  type: type,
                  adventureTaskId: adventureTaskId,
                  weeklyAdventureId: weeklyAdventureId,
                ),
              ),
              SizedBox(height: 30.h),
            ],
          ),
        ),
      ),
    );
  }
}

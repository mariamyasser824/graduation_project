import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:rewarding_kids/Shared/CustomText.dart';
import 'package:rewarding_kids/Shared/Custombutton.dart';
import 'package:rewarding_kids/core/constants/app_colors.dart';
import 'package:rewarding_kids/features/Parent_registar/cubit/child_cubit.dart';
import 'package:rewarding_kids/features/Parent_registar/cubit/child_state.dart';
import 'package:rewarding_kids/features/Parent_registar/widgets/gendercard.dart';
import 'package:rewarding_kids/features/Parent_registar/widgets/progress_bar.dart';
import 'package:rewarding_kids/features/onboarding/widgets/popbutton.dart';

class ChildGenderView extends StatelessWidget {
  const ChildGenderView({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final w = size.width;
    final h = size.height;

    return Scaffold(
      backgroundColor: AppColors.Background,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: w * 0.07,
            vertical: h * 0.03,
          ),
          child: Column(
            children: [
              // ========== Back Button ==========
              Align(
                alignment: Alignment.centerLeft,
                child: Popbutton(onPressed: () => context.pop()),
              ),

              SizedBox(height: h * 0.02),

              // ========== Progress Bar ==========
              BlocBuilder<ChildRegistrationCubit, ChildRegistrationState>(
                builder: (context, state) {
                  return AnimatedGradientProgress(progress: state.progress);
                },
              ),

              SizedBox(height: h * 0.06),

              // ========== Title ==========
              CustomText(
                text: "What's Your Child's Gender?",
                color: AppColors.titleColor,
                size: w * 0.055,
                weight: FontWeight.w600,
                iscenter: true,
              ),

              SizedBox(height: h * 0.01),

              CustomText(
                text:
                    "We will use this information to personalize the experience.",
                color: AppColors.descobColor,
                size: w * 0.035,
                iscenter: true,
              ),

              SizedBox(height: h * 0.05),
              BlocBuilder<ChildRegistrationCubit, ChildRegistrationState>(
                builder: (context, state) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GenderCard(
                        title: "Boy",
                        iconPath: "assets/icons/gender_boy.svg",
                        isSelected: state.gender == "male",
                        onTap: () {
                          context.read<ChildRegistrationCubit>().setGender(
                            "male",
                          );
                        },
                        gendercolor: AppColors.boycardcolor,
                      ),
                      GenderCard(
                        title: "Girl",
                        iconPath: "assets/icons/gender_girl.svg",
                        isSelected: state.gender == "female",
                        onTap: () {
                          context.read<ChildRegistrationCubit>().setGender(
                            "female",
                          );
                        },
                        gendercolor: AppColors.girlcardcolor,
                      ),
                    ],
                  );
                },
              ),

              SizedBox(height: h * 0.05),

              Custombutton(
                text: "Continue",
                onPressed: () {
                  final cubit = context.read<ChildRegistrationCubit>();

                  if (cubit.state.gender == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Please select gender")),
                    );
                    return;
                  }

                  context.push('/age');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

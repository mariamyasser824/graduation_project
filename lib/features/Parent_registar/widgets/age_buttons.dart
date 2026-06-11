import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rewarding_kids/Shared/CustomText.dart';
import 'package:rewarding_kids/core/constants/app_colors.dart';
import 'package:rewarding_kids/features/Parent_registar/cubit/child_cubit.dart';
import 'package:rewarding_kids/features/Parent_registar/cubit/child_state.dart';

class AgeButtons extends StatelessWidget {
  final double spacingWidth;
  final double spacingHeight;

  AgeButtons({
    super.key,
    required this.spacingWidth,
    required this.spacingHeight,
  });

  // القيمة الابتدائية
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return BlocBuilder<ChildRegistrationCubit, ChildRegistrationState>(
      builder: (context, state) {
        final cubit = context.read<ChildRegistrationCubit>();
        int age = cubit.state.age ?? 6;
        return Wrap(
          spacing: spacingWidth,
          runSpacing: spacingHeight,
          children: [
            Container(
              width: size.width * 0.7,
              height: size.width * 0.12,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(99),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // زر -
                    GestureDetector(
                      onTap: () {
                        if (age > 1) {
                          context.read<ChildRegistrationCubit>().setAge(
                            age - 1,
                          );
                        }
                      },
                      child: Container(
                        width: size.width * 0.1,
                        height: size.width * 0.1,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.Countercolor,
                        ),
                        alignment: Alignment.center,
                        child: Icon(Icons.remove, color: Colors.white),
                      ),
                    ),

                    // الرقم في المنتصف
                    CustomText(
                      text: '$age',
                      iscenter: true,
                      color: AppColors.titleColor,
                      size: 22.sp,
                      weight: FontWeight.w500,
                    ),

                    // زر +
                    GestureDetector(
                      onTap: () {
                        if (age < 18) {
                          context.read<ChildRegistrationCubit>().setAge(
                            age + 1,
                          );
                        }
                      },
                      child: Container(
                        width: size.width * 0.1,
                        height: size.width * 0.1,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.Countercolor,
                        ),
                        alignment: Alignment.center,
                        child: Icon(Icons.add, color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

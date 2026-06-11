import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:rewarding_kids/Shared/CustomText.dart';
import 'package:rewarding_kids/Shared/Custombutton.dart';
import 'package:rewarding_kids/Shared/Customtextformfiled.dart';
import 'package:rewarding_kids/core/constants/app_colors.dart';
import 'package:rewarding_kids/features/auth/cubit/forget_password_cubit.dart';
import 'package:rewarding_kids/features/auth/cubit/forget_password_state.dart';
import 'package:rewarding_kids/features/onboarding/widgets/popbutton.dart';

String? emailValidator(String? value) {
  if (value == null || value.isEmpty) return 'Please fill Email';
  if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value))
    return 'Please enter a valid email';
  return null;
}

class ForgetpassView extends StatelessWidget {
  const ForgetpassView({super.key});

  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();

    return BlocListener<ForgetPasswordCubit, ForgetPasswordState>(
      listener: (context, state) {
        if (state is ForgetPasswordLoading) {
          showDialog(
            context: context,
            builder: (_) => const Center(child: CircularProgressIndicator()),
          );
        } else {
          // نغلق الـ Loading لأي حالة مش Loading
          Navigator.of(context, rootNavigator: true).pop();
        }

        if (state is ForgetPasswordSuccess) {
          Navigator.pop(context);

          context.push(
            '/otp1',
            extra: {
              "email": emailController.text.trim(),
              "userId": state.userId,
              "flow": "reset",
            },
          );
        }

        if (state is ForgetPasswordError) {
          Navigator.pop(context);
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.error)));
        }
      },
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          backgroundColor: AppColors.Background,
          body: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 14.w),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(height: 20.h),
                    Row(
                      children: [
                        Popbutton(
                          onPressed: () {
                            context.pop();
                          },
                        ),
                      ],
                    ),
                    SizedBox(height: 40.h),
                    SvgPicture.asset(
                      'assets/icons/lock.svg',
                      width: 60.w,
                      height: 60.w,
                    ),
                    SizedBox(height: 25.h),
                    CustomText(
                      text: 'Forget Password',
                      iscenter: true,
                      color: AppColors.titleColor,
                      weight: FontWeight.w600,
                      size: 20.sp,
                    ),
                    SizedBox(height: 15.h),
                    CustomText(
                      text:
                          'Please enter your email to receive confirmation\ncode to set new password.',
                      iscenter: true,
                      color: AppColors.titleColor,
                      weight: FontWeight.w400,
                      size: 14.sp,
                    ),
                    SizedBox(height: 25.h),
                    Customtextformfiled(
                      hint: 'example@gmail.com',
                      isPassword: false,
                      controller: emailController,
                      label: 'Email',
                      icon: Icons.email_outlined,
                      validator: (v) => emailValidator(v),
                    ),
                    SizedBox(height: 25.h),
                    Custombutton(
                      onPressed: () {
                        context.read<ForgetPasswordCubit>().forgotPassword(
                          emailController.text,
                        );
                      },

                      text: 'Confirm',
                    ),
                    SizedBox(height: 40.h),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:rewarding_kids/Shared/CustomText.dart';
import 'package:rewarding_kids/Shared/Custombutton.dart';
import 'package:rewarding_kids/Shared/Customtextformfiled.dart';
import 'package:rewarding_kids/core/constants/app_colors.dart';
import 'package:rewarding_kids/features/auth/cubit/reset_password_cubit.dart';
import 'package:rewarding_kids/features/auth/cubit/reset_password_state.dart';
import 'package:rewarding_kids/features/onboarding/widgets/popbutton.dart';

String? passwordValidator(String? value) {
  if (value == null || value.isEmpty) return 'Please fill Password';
  if (value.length < 6) return 'Password must be at least 6 characters';
  if (!RegExp(r'[!@#\$&*~]').hasMatch(value))
    return 'Password must contain a special character';
  return null;
}

String? confirmPasswordValidator(String? value, String password) {
  if (value == null || value.isEmpty) return 'Please fill Confirm Password';
  if (value != password) return 'Passwords do not match';
  return null;
}

class Resetpass1View extends StatefulWidget {
  final String email;
  final String userId;
  final String otp;

  const Resetpass1View({
    super.key,
    required this.email,
    required this.userId,
    required this.otp,
  });

  @override
  State<Resetpass1View> createState() => _Resetpass1ViewState();
}

class _Resetpass1ViewState extends State<Resetpass1View> {
  final newpassController = TextEditingController();
  final confirmnewpassController = TextEditingController();

  @override
  void dispose() {
    newpassController.dispose();
    confirmnewpassController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ResetPasswordCubit, ResetPasswordState>(
      listener: (context, state) {
        if (state is ResetPasswordLoading) {
          showDialog(
            context: context,
            builder: (_) => const Center(child: CircularProgressIndicator()),
          );
        } else {
          // نغلق الـ Loading لأي حالة مش Loading
          Navigator.of(context, rootNavigator: true).pop();
        }

        if (state is ResetPasswordSuccess) {
          Navigator.pop(context);

          context.push('/resetpass2');
        }

        if (state is ResetPasswordError) {
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
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 12.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Popbutton(
                        onPressed: () {
                          if (context.canPop()) {
                            context.pop();
                          } else {
                            context.push('/otp1');
                          }
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 30.h),
                  Center(
                    child: SvgPicture.asset(
                      'assets/icons/lock.svg',
                      width: 56.w,
                      height: 56.h,
                    ),
                  ),
                  SizedBox(height: 20.h),
                  CustomText(
                    text: 'Reset Password',
                    iscenter: true,
                    color: AppColors.titleColor,
                    weight: FontWeight.w600,
                    size: 18.sp,
                  ),
                  SizedBox(height: 20.h),
                  Customtextformfiled(
                    hint: '********',
                    isPassword: true,
                    controller: newpassController,
                    label: 'New Password',
                    icon: Icons.lock_outline_rounded,
                    validator: passwordValidator,
                  ),
                  SizedBox(height: 10.h),
                  Customtextformfiled(
                    hint: '********',
                    isPassword: true,
                    controller: confirmnewpassController,
                    label: 'Confirm New Password',
                    icon: Icons.lock_outline_rounded,
                    validator: (v) =>
                        confirmPasswordValidator(v, newpassController.text),
                  ),
                  SizedBox(height: 15.h),
                  Row(
                    children: [
                      SizedBox(width: 20.w),
                      Icon(
                        Icons.check_circle,
                        color: AppColors.descColor,
                        size: 18.sp,
                      ),
                      SizedBox(width: 10.w),
                      Expanded(
                        child: CustomText(
                          text: 'Must Be At Least 8 Characters',
                          iscenter: false,
                          color: AppColors.descColor,
                          weight: FontWeight.w500,
                          size: 14.sp,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 15.h),
                  Row(
                    children: [
                      SizedBox(width: 20.w),
                      Icon(
                        Icons.check_circle,
                        color: AppColors.descColor,
                        size: 18.sp,
                      ),
                      SizedBox(width: 10.w),
                      Expanded(
                        child: CustomText(
                          text: 'Must Contain One Special Character',
                          iscenter: false,
                          color: AppColors.descColor,
                          weight: FontWeight.w500,
                          size: 14.sp,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 25.h),
                  Custombutton(
                    onPressed: () {
                      final newPass = newpassController.text;
                      final confirmPass = confirmnewpassController.text;

                      context.read<ResetPasswordCubit>().resetPassword(
                        userId: widget.userId,
                        otp: widget.otp,
                        token: "null",
                        newPassword: newPass,
                        confirmPassword: confirmPass,
                      );
                    },
                    text: 'Reset',
                  ),

                  SizedBox(
                    height: 30.h,
                  ), // مساحة إضافية لتجنب overflow مع الكيبورد
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

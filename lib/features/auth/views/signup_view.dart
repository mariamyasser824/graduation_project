import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:rewarding_kids/Shared/CustomText.dart';
import 'package:rewarding_kids/core/constants/app_colors.dart';
import 'package:rewarding_kids/features/auth/cubit/signup_cubit.dart';
import 'package:rewarding_kids/features/auth/cubit/signup_state.dart';
import 'package:rewarding_kids/features/auth/widgets/signup_form.dart';
import 'package:rewarding_kids/features/auth/widgets/usertabs.dart';
import 'package:rewarding_kids/features/child/widgets/child_login.dart';
import 'package:rewarding_kids/features/onboarding/widgets/popbutton.dart';

class SignupView extends StatelessWidget {
  const SignupView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignupCubit, SignupState>(
      listener: (context, state) {
        // Loading
        if (state is SignupLoading) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (_) => const Center(child: CircularProgressIndicator()),
          );
        } else {
          // نغلق الـ Loading لأي حالة مش Loading
          Navigator.of(context, rootNavigator: true).pop();
        }
        // Success
        if (state is SignupSuccess) {
          // Navigator.of(context, rootNavigator: true).pop(); // close loading
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
          context.push(
            '/otp1',
            extra: {"email": state.email, "flow": "activate"},
          ); // مثال
        }

        // Error
        if (state is SignupError) {
          //  Navigator.of(context, rootNavigator: true).pop(); // close loading
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.error)));
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.Background,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 12.h),
            child: Column(
              children: [
                // Pop button row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Popbutton(
                      onPressed: () {
                        if (context.canPop()) {
                          context.pop();
                        } else {
                          context.go('/getstarted');
                        }
                      },
                    ),
                  ],
                ),
                SizedBox(height: 16.h),
                CustomText(
                  text: 'Create new account',
                  iscenter: true,
                  size: 18.sp,
                  weight: FontWeight.w500,
                  color: AppColors.titleColor,
                ),
                SizedBox(height: 16.h),
                // Tabs & Forms
                Expanded(
                  child: UserTypeTabs(
                    widget1: Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.h),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            CustomText(
                              text: 'Please, Fill Parent Info',
                              iscenter: true,
                              size: 16.sp,
                              weight: FontWeight.w400,
                              color: AppColors.titleColor,
                            ),
                            SizedBox(height: 10.h),
                            SignupForm(),
                            SizedBox(height: 20.h),
                          ],
                        ),
                      ),
                    ),
                    widget2: ChildLogin(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

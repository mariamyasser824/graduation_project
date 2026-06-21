import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:rewarding_kids/Shared/CustomText.dart';
import 'package:rewarding_kids/core/constants/app_colors.dart';
import 'package:rewarding_kids/core/utils/dialog_helper.dart';
import 'package:rewarding_kids/features/auth/cubit/signup_cubit.dart';
import 'package:rewarding_kids/features/auth/cubit/signup_state.dart';
import 'package:rewarding_kids/features/auth/widgets/signup_form.dart';
import 'package:rewarding_kids/features/auth/widgets/usertabs.dart';
import 'package:rewarding_kids/features/child/widgets/child_login.dart';
import 'package:rewarding_kids/features/onboarding/widgets/popbutton.dart';

class SignupView extends StatelessWidget {
  SignupView({super.key});
  bool _isDialogShowing = false;
  @override
  Widget build(BuildContext context) {
    return BlocListener<SignupCubit, SignupState>(
      listener: (context, state) {
        if (state is SignupLoading) {
          _isDialogShowing = true;
          DialogHelper.showLoading(context);
        } else {
          if (_isDialogShowing) {
            _isDialogShowing = false;
            DialogHelper.hideLoading(context);
          }
        }

        if (state is SignupSuccess) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
          context.push(
            '/otp1',
            extra: {"email": state.email, "flow": "activate"},
          );
        }

        if (state is SignupError) {
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
                          context.push('/getstarted');
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
                SizedBox(height: 8.h),
                CustomText(
                  text: 'Please, Fill Parent Info',
                  iscenter: true,
                  size: 14.sp,
                  weight: FontWeight.w400,
                  color: Color(0xff9CA3B0),
                ),
                SizedBox(height: 10.h),
                // Tabs & Forms
                Expanded(
                  child: UserTypeTabs(
                    widget1: Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.h),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
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

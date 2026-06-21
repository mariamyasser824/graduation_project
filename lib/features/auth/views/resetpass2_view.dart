import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:rewarding_kids/Shared/CustomText.dart';
import 'package:rewarding_kids/Shared/Custombutton.dart';
import 'package:rewarding_kids/core/constants/app_colors.dart';
import 'package:rewarding_kids/core/utils/pref_helper.dart';
import 'package:rewarding_kids/core/utils/dialog_helper.dart';
import 'package:rewarding_kids/features/auth/cubit/login_cubit.dart';
import 'package:rewarding_kids/features/auth/cubit/login_state.dart';

class Resetpass2View extends StatefulWidget {
  final String email;
  final String password;

  const Resetpass2View({
    super.key,
    required this.email,
    required this.password,
  });

  @override
  State<Resetpass2View> createState() => _Resetpass2ViewState();
}

class _Resetpass2ViewState extends State<Resetpass2View> {
  bool _isDialogShowing = false;

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
      listener: (context, state) async {
        if (state is LoginLoading) {
          _isDialogShowing = true;
          DialogHelper.showLoading(context);
        } else {
          if (_isDialogShowing) {
            _isDialogShowing = false;
            DialogHelper.hideLoading(context);
          }
        }

        if (state is LoginSuccess) {
          final childId = await PrefHelper.getChildId();
          if (childId != null && childId.isNotEmpty) {
            context.go('/Layout');
          } else {
            context.go('/child_flow');
          }
        }

        if (state is LoginError) {
          context.go('/login');
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.Background,
        body: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: 120.h),

                Center(
                  child: Image.asset(
                    'assets/icons/security.png',
                    width: 56.w,
                    height: 56.w,
                  ),
                ),

                SizedBox(height: 24.h),

                CustomText(
                  text: 'Password Reset',
                  iscenter: true,
                  color: AppColors.titleColor,
                  weight: FontWeight.w600,
                  size: 20.sp,
                ),

                SizedBox(height: 12.h),

                CustomText(
                  text:
                      'Your password has been successfully reset\nclick below to log in magically.',
                  iscenter: true,
                  color: AppColors.titleColor,
                  weight: FontWeight.w400,
                  size: 14.sp,
                ),

                SizedBox(height: 40.h),

                Custombutton(
                  text: 'Sign in',
                  onPressed: () {
                    context.read<LoginCubit>().login(
                      identifier: widget.email,
                      password: widget.password,
                      loginAs: "Parent",
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

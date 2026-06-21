import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:rewarding_kids/Shared/CustomText.dart';
import 'package:rewarding_kids/core/constants/app_colors.dart';
import 'package:rewarding_kids/core/utils/dialog_helper.dart';
import 'package:rewarding_kids/core/utils/pref_helper.dart';
import 'package:rewarding_kids/features/auth/cubit/login_cubit.dart';
import 'package:rewarding_kids/features/auth/cubit/login_state.dart';
import 'package:rewarding_kids/features/auth/widgets/loginform.dart';
import 'package:rewarding_kids/features/auth/widgets/usertabs.dart';
import 'package:rewarding_kids/features/child/widgets/child_login.dart';
import 'package:rewarding_kids/features/onboarding/widgets/popbutton.dart';
import 'package:rewarding_kids/features/parent/views/layout_view.dart';
import 'package:rewarding_kids/main.dart';

class LoginView extends StatelessWidget {
  LoginView({super.key});
  bool _isDialogShowing = false;
  @override
  Widget build(BuildContext context) {
    /*   void checkChild(BuildContext context) async {
      final hasChild = await PrefHelper.getHasChild();
            if (hasChild == true) {
        context.go('/home');
      } else {
        context.go('/child_flow');
      }
    }
*/
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
          final type = await PrefHelper.getUserType();
          if (type == "Child") {
            context.go('/Custombottomnav');
            return;
          }
          final childId = await PrefHelper.getChildId();
          if (childId != null && childId.isNotEmpty) {
            context.go('/Layout');
          } else {
            context.go('/child_flow');
          }
        }

        if (state is LoginError) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.error)));
        }
      },

      child: Scaffold(
        backgroundColor: AppColors.Background,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
            child: Column(
              children: [
                /// Back Button
                Row(
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

                SizedBox(height: 10.h),

                /// Title
                CustomText(
                  text: 'Welcome back!',
                  iscenter: true,
                  size: 20.sp,
                  weight: FontWeight.w600,
                  color: AppColors.titleColor,
                ),

                SizedBox(height: 16.h),

                /// Tabs + Forms
                Expanded(
                  child: UserTypeTabs(
                    widget1: SingleChildScrollView(
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 8.h),
                        child: Column(
                          children: [
                            Loginform(),
                            SizedBox(height: 20.h),
                          ],
                        ),
                      ),
                    ),
                    widget2: const ChildLogin(),
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

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:rewarding_kids/Shared/CustomText.dart';
import 'package:rewarding_kids/core/constants/app_colors.dart';
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
  const LoginView({super.key});

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
        debugPrint('📦 LOGIN STATE => $state');

        if (state is LoginLoading) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (_) => const Center(child: CircularProgressIndicator()),
          );
        } else {
          // نغلق الـ Loading لأي حالة مش Loading
          Navigator.of(context, rootNavigator: true).pop();
        }
        if (state is LoginSuccess) {
          //  Navigator.of(context, rootNavigator: true).pop();

          final type = await PrefHelper.getUserType();

          /// لو طفل
          if (type == "Child") {
            context.go('/Custombottomnav');
            return;
          }

          /// لو ولي أمر
          final childId = await PrefHelper.getChildId();

          if (childId != null && childId.isNotEmpty) {
            context.go('/Layout'); // عنده طفل
          } else {
            context.go('/child_flow'); // معندوش طفل
          }
        }
        if (state is LoginError) {
          debugPrint('❌ STATE: Error');
          debugPrint('ERROR => ${state.error}');

          // Navigator.of(context, rootNavigator: true).pop();

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
                          context.go('/getstarted');
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
                            CustomText(
                              text: 'Sign in to Parent account',
                              iscenter: true,
                              size: 16.sp,
                              weight: FontWeight.w400,
                              color: AppColors.titleColor,
                            ),
                            SizedBox(height: 10.h),
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

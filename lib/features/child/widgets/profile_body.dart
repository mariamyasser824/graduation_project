import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:rewarding_kids/Shared/CustomText.dart';
import 'package:rewarding_kids/features/auth/cubit/logout_cubit.dart';
import 'package:rewarding_kids/features/auth/cubit/logout_state.dart';
import 'package:rewarding_kids/features/child/widgets/profile_appbar.dart';
import 'package:rewarding_kids/features/child/widgets/profile_header.dart';
import 'package:rewarding_kids/features/parent/widgets/Performance_card.dart';
import 'package:rewarding_kids/features/parent/widgets/home_tabs.dart';
import 'package:rewarding_kids/features/parent/widgets/tasks_card.dart';
import 'package:rewarding_kids/features/parent/widgets/tasks_summary_card.dart';

class ProfileBody extends StatelessWidget {
  const ProfileBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<LogoutCubit, LogoutState>(
      listener: (context, state) {
        if (state is LogoutLoading) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (_) => const Center(child: CircularProgressIndicator()),
          );
        }

        if (state is LogoutSuccess) {
          Navigator.of(context, rootNavigator: true).pop(); // يقفل اللودينج
          context.go('/getstarted'); // روحي لبداية الأبلكيشن
        }

        if (state is LogoutError) {
          Navigator.pop(context);
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.error)));
        }
      },
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          children: [
            ProfileAppbar(),
            SizedBox(height: 10.h),
            ProfileHeader(),
            SizedBox(height: 8.h),

            /// 👇 الحل هنا
            /*Expanded(
              child: CustomTabsSection(
                widget1: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(height: 16.h),
                      //  TasksSummaryCard(),
                      SizedBox(height: 16.h),
                      // TasksCard(),
                      SizedBox(height: 16.h),
                      // PerformanceCard(),
                      SizedBox(height: 20.h),
                      GestureDetector(
                        onTap: () {
                          debugPrint("Logout pressed");
                          context.read<LogoutCubit>().logout();
                        },
                        child: Container(
                          width: double.infinity,
                          height: 50.h,
                          decoration: BoxDecoration(
                            color: const Color(0xffF0E8F4),
                            borderRadius: BorderRadius.circular(8.r),
                            border: Border.all(
                              color: const Color(0xffFF9D9D),
                              width: 1.w,
                            ),
                          ),
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SvgPicture.asset(
                                  'assets/icons/logout.svg',
                                  width: 20.w,
                                  height: 20.w,
                                  color: const Color(0xffF52930),
                                ),
                                SizedBox(width: 5.w),
                                CustomText(
                                  text: 'Logout',
                                  size: 14.sp,
                                  color: const Color(0xffF30000),
                                  weight: FontWeight.w500,
                                  iscenter: true,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                widget2: const Center(child: Text('This Month')),
                widget3: const Center(child: Text('All')),
              ),
            ),*/
          ],
        ),
      ),
    );
  }
}

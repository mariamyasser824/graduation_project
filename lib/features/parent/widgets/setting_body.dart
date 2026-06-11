import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:rewarding_kids/Shared/CustomText.dart';
import 'package:rewarding_kids/core/constants/app_colors.dart';
import 'package:rewarding_kids/core/utils/pref_helper.dart';
import 'package:rewarding_kids/features/auth/cubit/logout_cubit.dart';
import 'package:rewarding_kids/features/auth/cubit/logout_state.dart';
import 'package:rewarding_kids/features/parent/widgets/profile_image_picker.dart';
import 'package:rewarding_kids/features/parent/widgets/settings_item.dart';

class SettingBody extends StatelessWidget {
  const SettingBody({super.key});

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
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 50.h),
              ProfileImagePicker(),
              CustomText(
                text: 'Amira Reda',
                iscenter: true,
                size: 16.sp,
                weight: FontWeight.w600,
                color: Color(0xff4B5563),
              ),
              SizedBox(height: 8.h),
              CustomText(
                text: 'amirareda223@gmail.com',
                iscenter: true,
                size: 16.sp,
                weight: FontWeight.w600,
                color: Color(0xff6B6E80),
              ),
              SizedBox(height: 20.h),
              SettingsItem(
                icon: Icon(
                  Icons.person_outline_rounded,
                  size: 20.sp,
                  color: AppColors.titleColor,
                ),
                title: 'Personal Info',
                onTap: () {
                  context.push('/personal_info');
                },
              ),

              SettingsItem(
                icon: SvgPicture.asset(
                  'assets/icons/child_info.svg', // 👶👩
                  width: 20.w,
                  height: 20.w,
                  color: AppColors.titleColor,
                ),
                title: 'Child Info',
                onTap: () {
                  context.push('/child_info');
                },
              ),

              SettingsItem(
                icon: Icon(
                  Icons.notifications_none,
                  size: 20.sp,
                  color: AppColors.titleColor,
                ),
                title: 'Notification',
                onTap: () {
                  context.push('/notification');
                },
              ),

              SettingsItem(
                icon: Icon(
                  Icons.privacy_tip_outlined,
                  size: 20.sp,
                  color: AppColors.titleColor,
                ),
                title: 'Privacy & Safety',
                onTap: () {
                  context.push('/privacy');
                },
              ),

              SettingsItem(
                icon: Icon(
                  Icons.help_outline_rounded,
                  size: 20.sp,
                  color: AppColors.titleColor,
                ),

                title: 'Help & Support',
                onTap: () {
                  context.push('/help');
                },
              ),

              SettingsItem(
                icon: SvgPicture.asset(
                  'assets/icons/logout.svg',
                  width: 20.w,
                  height: 20.w,
                  color: const Color(0xffF52930),
                ),
                title: 'Logout',
                isLogout: true,
                onTap: () {
                  debugPrint("Logout pressed");
                  context.read<LogoutCubit>().logout();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

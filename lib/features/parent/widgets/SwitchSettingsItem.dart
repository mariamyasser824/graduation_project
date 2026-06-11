import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rewarding_kids/Shared/CustomText.dart';
import 'package:rewarding_kids/core/constants/app_colors.dart';

class SwitchSettingsItem extends StatelessWidget {
  const SwitchSettingsItem({
    super.key,
    required this.title,
    required this.value,
    required this.onChanged,
  });

  final String title;
  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 3.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomText(
            text: title,
            size: 14.sp,
            weight: FontWeight.w400,
            iscenter: true,
            color: AppColors.titleColor,
          ),
          Transform.scale(
            scale: 0.9,
            child: Switch(
              value: value,
              onChanged: onChanged,
              trackOutlineColor: WidgetStateProperty.resolveWith((states) {
                if (states.contains(WidgetState.selected)) {
                  return Colors.transparent;
                }
                return Colors.transparent;
              }),

              activeTrackColor: Color(0xff984CFB),
              activeColor: Colors.white,
              inactiveThumbColor: Colors.white,
              inactiveTrackColor: Color(0xffD9D9D9),
            ),
          ),
        ],
      ),
    );
  }
}

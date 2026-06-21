import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rewarding_kids/Shared/CustomText.dart';
import 'package:rewarding_kids/core/constants/app_colors.dart';

class Customtextformfiled extends StatefulWidget {
  const Customtextformfiled({
    super.key,
    required this.hint,
    required this.isPassword,
    required this.controller,
    required this.label,
    required this.icon,
    this.validator,
  });

  final String hint;
  final String label;
  final bool isPassword;
  final IconData icon;
  final TextEditingController controller;
  final String? Function(String?)? validator;

  @override
  State<Customtextformfiled> createState() => _CustomtextformfiledState();
}

class _CustomtextformfiledState extends State<Customtextformfiled> {
  late bool _obscureText;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.isPassword;
  }

  void _togglePassword() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            text: widget.label,
            iscenter: false,
            size: 14.sp,
            weight: FontWeight.w500,
            color: AppColors.titleColor,
          ),

          SizedBox(height: 6.h),

          // ✅ شيلنا الـ SizedBox بـ height ثابتة
          TextFormField(
            controller: widget.controller,
            cursorColor: AppColors.ActiveColor,
            obscureText: _obscureText,
            validator: widget.validator ??
                (v) {
                  if (v == null || v.isEmpty) {
                    return 'Please fill ${widget.label}';
                  }
                  return null;
                },
            decoration: InputDecoration(
              hintText: widget.hint,
              hintStyle: TextStyle(
                color: AppColors.descColor,
                fontSize: 13.sp,
              ),
              // ✅ contentPadding بدل height ثابتة
              contentPadding: EdgeInsets.symmetric(
                horizontal: 12.w,
                vertical: 13.h,
              ),
              prefixIcon: Icon(
                widget.icon,
                color: AppColors.descColor,
                size: 20.sp,
              ),
              // ✅ suffixIcon بدل suffix - ده اللي بيخلي التوجل يشتغل
              suffixIcon: widget.isPassword
                  ? GestureDetector(
                      onTap: _togglePassword,
                      child: Icon(
                        _obscureText
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined,
                        size: 20.sp,
                        color: AppColors.descColor,
                      ),
                    )
                  : null,
              filled: true,
              fillColor: Colors.white,
              // ✅ errorStyle صغير ومحدد
              errorStyle: TextStyle(
                fontSize: 11.sp,
                height: 1.2,
              ),
              // ✅ errorBorder بدون gapPadding غلط
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.r),
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.r),
                borderSide: BorderSide(
                  color: AppColors.ActiveColor,
                  width: 1.w,
                ),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.r),
                borderSide: const BorderSide(color: Colors.red, width: 1),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.r),
                borderSide: const BorderSide(color: Colors.red, width: 1),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
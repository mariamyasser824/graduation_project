import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:rewarding_kids/Shared/CustomText.dart';
import 'package:rewarding_kids/Shared/Custombutton.dart';
import 'package:rewarding_kids/Shared/Customtextformfiled.dart';
import 'package:rewarding_kids/core/constants/app_colors.dart';
import 'package:rewarding_kids/features/auth/cubit/login_cubit.dart';
import 'package:rewarding_kids/features/auth/cubit/login_state.dart';

class ChildLogin extends StatefulWidget {
  const ChildLogin({super.key});

  @override
  State<ChildLogin> createState() => _ChildLoginState();
}

class _ChildLoginState extends State<ChildLogin> {
  late final TextEditingController code;

  @override
  void initState() {
    super.initState();
    code = TextEditingController();
  }

  @override
  void dispose() {
    code.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return BlocListener<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is LoginLoading) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (_) => const Center(child: CircularProgressIndicator()),
          );
        }

        if (state is LoginSuccess) {
          Navigator.of(context, rootNavigator: true).pop(); // اغلق الـ loader
          context.push('/Custombottomnav'); // واجهة الطفل
        }

        if (state is LoginError) {
          Navigator.of(context, rootNavigator: true).pop();
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.error)));
        }
      },
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.w),
          child: Column(
            children: [
              /// Image
              SizedBox(
                height: screenHeight * 0.45,
                width: screenWidth * 0.95,
                child: Image.asset(
                  'assets/child/child_login.png',
                  fit: BoxFit.contain,
                ),
              ),

              SizedBox(height: 10.h),

              /// Text + Field
              Padding(
                padding: EdgeInsets.symmetric(vertical: 8.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      text: "Enter Child Code Manually or Scan QR",
                      iscenter: false,
                      size: 16.sp,
                      weight: FontWeight.w500,
                      color: AppColors.titleColor,
                    ),

                    SizedBox(height: 8.h),

                    SizedBox(
                      width: double.infinity,
                      height: screenHeight * 0.056,
                      child: TextFormField(
                        controller: code,
                        cursorColor: AppColors.ActiveColor,
                        cursorHeight: 20.h,
                        validator: (v) {
                          if (v == null || v.isEmpty) {
                            return 'please fill Enter Child Code Manually or Scan QR';
                          }
                          return null;
                        },

                        decoration: InputDecoration(
                          hintText: 'Enter child code ',
                          hintStyle: TextStyle(
                            color: AppColors.descColor,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400,
                          ),
                          prefixIcon: Icon(
                            Icons.person_outline_rounded,
                            color: AppColors.descColor,
                            size: 24.sp,
                          ),
                          suffixIcon: SizedBox(
                            width: 14.w,
                            height: 14.h,
                            child: GestureDetector(
                              onTap: () async {
                                final result = await context.push('/qrcode');
                                if (result != null && result is String) {
                                  code.text = result; // نحط الكود في الفيلد
                                }
                              },
                              child: Icon(
                                Icons.qr_code_scanner,
                                color: Color(0xff9CA3AF),
                              ),
                            ),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.r),
                            borderSide: BorderSide(
                              color: Colors.white,
                              width: 0.4.w,
                            ),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.r),
                            borderSide: BorderSide(color: Colors.redAccent),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 30.h),

              /// Button
              Custombutton(
                onPressed: () {
                  if (code.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Enter child code")),
                    );
                    return;
                  }

                  context.read<LoginCubit>().login(
                    identifier: code.text.trim(),
                    password: "", // مؤقت
                    loginAs: "Child",
                  );
                },
                text: 'Link Child',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

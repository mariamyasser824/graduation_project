import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:rewarding_kids/Shared/CustomText.dart';
import 'package:rewarding_kids/Shared/Custombutton.dart';
import 'package:rewarding_kids/core/constants/app_colors.dart';
import 'package:rewarding_kids/core/utils/pref_helper.dart';
import 'package:rewarding_kids/features/Parent_registar/views/Child_name_view.dart';
import 'package:rewarding_kids/features/auth/cubit/otpcubit.dart';
import 'package:rewarding_kids/features/auth/cubit/otpstate.dart';
import 'package:rewarding_kids/features/auth/widgets/otpwidget.dart';
import 'package:rewarding_kids/features/auth/widgets/underlinetext.dart';
import 'package:rewarding_kids/features/onboarding/widgets/popbutton.dart';

class Otp1View extends StatefulWidget {
  final String email;
  final String? userId;
  final String flow;
  const Otp1View({
    super.key,
    required this.email,
    this.userId,
    required this.flow,
  });

  @override
  State<Otp1View> createState() => _Otp1ViewState();
}

class _Otp1ViewState extends State<Otp1View> {
  String code = "";
  int _secondsRemaining = 30;
  bool _enableResend = false;
  Timer? _timer;
  final List<TextEditingController> _otpControllers = List.generate(
    6,
    (_) => TextEditingController(),
  );
  @override
  void initState() {
    super.initState();
    startTimer();
    // checkToken();
  }

  void startTimer() {
    _secondsRemaining = 30;
    _enableResend = false;
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secondsRemaining == 0) {
        setState(() {
          _enableResend = true;
        });
        timer.cancel();
      } else {
        setState(() {
          _secondsRemaining--;
        });
      }
    });
  }

  void resendCode() async {
    if (!_enableResend) return; // نتأكد ان الزر مفعل
    startTimer(); // يرجع يعمل التايمر من جديد

    try {
      await context.read<OtpCubit>().resendOtp(
        email: widget.email,
        userId: widget.userId,
        flow: widget.flow,
      );

      // لو عايزين نطلع رسالة نجاح صغيرة
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Verification code sent successfully!"),
          duration: Duration(seconds: 2),
        ),
      );
    } catch (e) {
      // لو فيه خطأ
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Failed to resend OTP: ${e.toString()}"),
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }

  void verifyCode() {
    code = _otpControllers.map((c) => c.text).join();

    if (code.length != 6) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Please enter full code")));
      return;
    }

    if (widget.flow == "activate") {
      // Signup flow - بيتحقق من الـ OTP عشان يفعّل الأكاونت
      context.read<OtpCubit>().verifyOtp(email: widget.email, otp: code);
    } else if (widget.flow == "reset") {
      // Reset flow - الـ OTP بيتبعت مع الـ reset-password مباشرة
      // مش محتاج verify هنا
      context.push(
        '/resetpass1',
        extra: {"email": widget.email, "userId": widget.userId, "otp": code},
      );
    }
  }

  @override
  void dispose() {
    for (var c in _otpControllers) {
      c.dispose();
    }
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<OtpCubit, OtpState>(
      listener: (context, state) async {
        if (state is OtpLoading) {
          debugPrint('⏳ STATE: Loading');
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (_) => const Center(child: CircularProgressIndicator()),
          );
        } else {
          // نغلق الـ Loading لأي حالة مش Loading
          Navigator.of(context, rootNavigator: true).pop();
        }
        if (state is OtpSuccess) {
          if (widget.flow == "activate") {
            context.push('/login');
          } else if (widget.flow == "reset") {
            // 👈 دلوقتي بس نروح reset بعد ما الـ OTP اتتحقق
            context.push(
              '/resetpass1',
              extra: {
                "email": widget.email,
                "userId": widget.userId,
                "otp": code, // الكود الصح
              },
            );
          }
        }

        if (state is OtpError) {
          Navigator.pop(context);
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.error)));
        }
      },
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          backgroundColor: AppColors.Background,
          body: SafeArea(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 12.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
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

                  SizedBox(height: 80.h),
                  Center(
                    child: Image.asset(
                      'assets/icons/emaiil.png',
                      width: 30.w,
                      height: 40.h,
                    ),
                  ),
                  SizedBox(height: 20.h),
                  CustomText(
                    text: 'Verify email address',
                    iscenter: true,
                    color: AppColors.titleColor,
                    weight: FontWeight.w600,
                    size: 18.sp,
                  ),
                  SizedBox(height: 20.h),
                  CustomText(
                    text: 'Enter verification code sent to',
                    iscenter: true,
                    color: AppColors.titleColor,
                    weight: FontWeight.w400,
                    size: 14.sp,
                  ),
                  CustomText(
                    text: '${widget.email}',
                    iscenter: true,
                    color: Color(0xffA490AF),
                    weight: FontWeight.w400,
                    size: 14.sp,
                  ),
                  SizedBox(height: 20.h),
                  Otpwidget(
                    secondsRemaining: _secondsRemaining,
                    enableResend: _enableResend,
                    otpControllers: _otpControllers,
                  ),
                  SizedBox(height: 20.h),

                  Custombutton(onPressed: verifyCode, text: "Verify"),
                  SizedBox(height: 20.h),
                  Center(
                    child: Underlinetext(
                      text: 'OTP not received ?',
                      underlinetext: 'send again',
                      onPressed: _enableResend ? resendCode : null,
                    ),
                  ),
                  SizedBox(
                    height: 30.h,
                  ), // مسافة إضافية لتجنب overflow مع الكيبورد
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

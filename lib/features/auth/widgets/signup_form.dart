import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:rewarding_kids/Shared/CustomText.dart';
import 'package:rewarding_kids/Shared/Custombutton.dart';
import 'package:rewarding_kids/Shared/Customtextformfiled.dart';
import 'package:rewarding_kids/core/constants/app_colors.dart';
import 'package:rewarding_kids/features/auth/cubit/signup_cubit.dart';

import 'package:rewarding_kids/features/auth/cubit/signup_state.dart';
import 'package:rewarding_kids/features/auth/widgets/OrDivider.dart';
import 'package:rewarding_kids/features/auth/widgets/applebutton.dart';
import 'package:rewarding_kids/features/auth/widgets/googlebutton.dart';
import 'package:rewarding_kids/features/auth/widgets/underlinetext.dart';

String? passwordValidator(String? value) {
  if (value == null || value.isEmpty) return 'Please fill Password';
  if (value.length < 6) return 'Password must be at least 6 characters';
  if (!RegExp(r'[!@#\$&*~]').hasMatch(value))
    return 'Password must contain a special character';
  return null;
}

String? confirmPasswordValidator(String? value, String password) {
  if (value == null || value.isEmpty) return 'Please fill Confirm Password';
  if (value != password) return 'Passwords do not match';
  return null;
}

String? emailValidator(String? value) {
  if (value == null || value.isEmpty) return 'Please fill Email';
  if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value))
    return 'Please enter a valid email';
  return null;
}

class SignupForm extends StatefulWidget {
  const SignupForm({super.key});

  @override
  State<SignupForm> createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passController = TextEditingController();
  final confirmController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passController.dispose();
    confirmController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: SingleChildScrollView(
        child: Column(
          //  mainAxisSize: MainAxisSize.min,
          children: [
            Customtextformfiled(
              hint: 'amira reda',
              isPassword: false,
              controller: nameController,
              label: 'Full Name',
              icon: Icons.person_2_outlined,
            ),

            Customtextformfiled(
              hint: 'example@gmail.com',
              isPassword: false,
              controller: emailController,
              label: 'Email',
              icon: Icons.email_outlined,
              validator: (v) => emailValidator(v),
            ),

            Customtextformfiled(
              hint: '********',
              isPassword: true,
              controller: passController,
              label: 'Password',
              icon: Icons.lock_outline_rounded,
              validator: passwordValidator,
            ),

            Customtextformfiled(
              hint: '********',
              isPassword: true,
              controller: confirmController,
              label: 'Confirm Password',
              icon: Icons.lock_outline_rounded,
              validator: (v) =>
                  confirmPasswordValidator(v, passController.text),
            ),

            SizedBox(height: 20.h),
            Custombutton(
              text: 'Continue',
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  context.read<SignupCubit>().signup(
                    email: emailController.text.trim(),
                    password: passController.text.trim(),
                    confirmPassword: confirmController.text.trim(),
                    fullName: nameController.text.trim(),
                  );
                }
              },
            ),
            SizedBox(height: 20.h),
            Ordivider(),
            SizedBox(height: 20.h),
            Googlebutton(text: 'Sign up with Google'),
            SizedBox(height: 12.h),
            Applebutton(text: 'Sign up with Apple'),
            SizedBox(height: 20.h),
            Underlinetext(
              text: 'Already have an account?',
              underlinetext: 'Sign in',
              onPressed: () => context.push('/login'),
            ),
          ],
        ),
      ),
    );
  }
}

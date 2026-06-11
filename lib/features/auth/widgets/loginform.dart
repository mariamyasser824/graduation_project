import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:rewarding_kids/Shared/Custombutton.dart';
import 'package:rewarding_kids/Shared/Customtextformfiled.dart';
import 'package:rewarding_kids/features/auth/cubit/login_cubit.dart';
import 'package:rewarding_kids/features/auth/cubit/login_state.dart';
import 'package:rewarding_kids/features/auth/widgets/OrDivider.dart';
import 'package:rewarding_kids/features/auth/widgets/applebutton.dart';
import 'package:rewarding_kids/features/auth/widgets/forgetbutton.dart';
import 'package:rewarding_kids/features/auth/widgets/googlebutton.dart';
import 'package:rewarding_kids/features/auth/widgets/underlinetext.dart';

String? passwordValidator(String? value) {
  if (value == null || value.isEmpty) return 'Please fill Password';
  if (value.length < 6) return 'Password must be at least 6 characters';
  if (!RegExp(r'[!@#\$&*~]').hasMatch(value))
    return 'Password must contain a special character';
  return null;
}

String? emailValidator(String? value) {
  if (value == null || value.isEmpty) return 'Please fill Email';
  if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value))
    return 'Please enter a valid email';
  return null;
}

class Loginform extends StatefulWidget {
  const Loginform({super.key});

  @override
  State<Loginform> createState() => _LoginformState();
}

class _LoginformState extends State<Loginform> {
  final formKey = GlobalKey<FormState>();
  late TextEditingController emailController;
  final passController = TextEditingController();

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
  }

  @override
  void dispose() {
    emailController.dispose();
    passController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
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
          SizedBox(height: 15.h),
          Forgetbutton(),
          SizedBox(height: 20.h),
          Custombutton(
            text: 'Sign in',
            onPressed: () {
              if (formKey.currentState!.validate()) {
                context.read<LoginCubit>().login(
                  identifier: emailController.text.trim(),
                  password: passController.text.trim(),
                  loginAs: "Parent",
                );
              }
            },
          ),
          SizedBox(height: 25.h),
          Ordivider(),
          SizedBox(height: 20.h),
          Googlebutton(text: 'Sign in with Google'),
          SizedBox(height: 10.h),
          Applebutton(text: 'Sign in with Apple'),
          SizedBox(height: 20.h),
          Underlinetext(
            text: 'Don’t have an account ?',
            underlinetext: 'sign Up',
            onPressed: () => context.push('/signup'),
          ),
        ],
      ),
    );
  }
}

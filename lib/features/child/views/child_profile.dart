import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rewarding_kids/core/constants/app_colors.dart';
import 'package:rewarding_kids/features/auth/cubit/logout_cubit.dart';
import 'package:rewarding_kids/features/child/widgets/profile_body.dart';

class ChildProfile extends StatelessWidget {
  const ChildProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.Background,

        body: BlocProvider(create: (_) => LogoutCubit(), child: ProfileBody()),
      ),
    );
  }
}

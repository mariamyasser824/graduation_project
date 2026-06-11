import 'package:flutter/material.dart';
import 'package:rewarding_kids/features/parent/widgets/setting_body.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rewarding_kids/features/auth/cubit/logout_cubit.dart';

class SettingView extends StatelessWidget {
  const SettingView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => LogoutCubit(),
      child: const SettingBody(),
    );
  }
}

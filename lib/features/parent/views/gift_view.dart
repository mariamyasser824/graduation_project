import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rewarding_kids/core/constants/app_colors.dart';
import 'package:rewarding_kids/core/network/dio_client.dart';
import 'package:rewarding_kids/features/parent/cubit/reward_cubit/reward_cubit.dart';
import 'package:rewarding_kids/features/parent/repos/Reward_repo.dart';
import 'package:rewarding_kids/features/parent/widgets/gifts_body.dart';

class GiftsView extends StatelessWidget {
  const GiftsView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          RewardCubit(RewardRepository(DioClient().dio))
            ..getRewards(), // 🔥 أول ما الصفحة تفتح يجيب الداتا
      child: Scaffold(backgroundColor: AppColors.Background, body: GiftsBody()),
    );
  }
}

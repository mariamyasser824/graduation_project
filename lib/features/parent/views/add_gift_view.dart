import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rewarding_kids/core/constants/app_colors.dart';
import 'package:rewarding_kids/core/network/dio_client.dart';
import 'package:rewarding_kids/features/parent/cubit/reward_cubit/reward_cubit.dart';
import 'package:rewarding_kids/features/parent/repos/Reward_repo.dart';
import 'package:rewarding_kids/features/parent/widgets/add_gift_body.dart';

class AddGiftView extends StatelessWidget {
  const AddGiftView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RewardCubit(RewardRepository(DioClient().dio)),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: AppColors.Background,
          body: AddGiftBody(),
        ),
      ),
    );
  }
}

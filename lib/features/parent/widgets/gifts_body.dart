import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rewarding_kids/features/parent/cubit/reward_cubit/reward_cubit.dart';
import 'package:rewarding_kids/features/parent/cubit/reward_cubit/reward_state.dart';
import 'package:rewarding_kids/features/parent/widgets/GiftSuccessDialog.dart';
import 'package:rewarding_kids/features/parent/widgets/addgiftsection.dart';
import 'package:rewarding_kids/features/parent/widgets/giftgrid2.dart';
import 'package:rewarding_kids/features/parent/widgets/gifts_header.dart';

class GiftsBody extends StatefulWidget {
  const GiftsBody({super.key});

  @override
  State<GiftsBody> createState() => _GiftsBodyState();
}

class _GiftsBodyState extends State<GiftsBody> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocListener<RewardCubit, RewardState>(
        listener: (BuildContext context, RewardState state) {
          if (state is GiveRewardSuccess) {
            showDialog(
              context: context,
              builder: (_) =>
                  const GiftSuccessDialog(text: 'Perfect! Gift Claimed 🎁'),
            );
          }

          if (state is GiveRewardError) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text("Error giving gift")));
          }
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GiftsHeader(),
            Addgiftsection(),
            Expanded(
              child: BlocBuilder<RewardCubit, RewardState>(
                builder: (context, state) {
                  if (state is RewardLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (state is RewardSuccess) {
                    return Giftgrid2(gifts: state.rewards);
                  }
                  if (state is RewardError) {
                    return Center(child: Text(state.message));
                  }

                  return const SizedBox();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

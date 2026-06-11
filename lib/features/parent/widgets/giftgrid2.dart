import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rewarding_kids/features/child/data/models/gift_model.dart';
import 'package:rewarding_kids/features/parent/cubit/reward_cubit/reward_cubit.dart';
import 'package:rewarding_kids/features/parent/models/reward_model.dart';

import 'package:rewarding_kids/features/parent/widgets/GiftSuccessDialog.dart';
import 'package:rewarding_kids/features/parent/widgets/giftcard2.dart';

class Giftgrid2 extends StatelessWidget {
  const Giftgrid2({super.key, required this.gifts});

  final List<RewardModel> gifts;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(16),

      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 0.75,
      ),
      itemCount: gifts.length,
      itemBuilder: (context, index) {
        final gift = gifts[index];

        return Giftcard2(
          title: gift.nameEn,
          imageUrl: gift.image,
          points: gift.targetPoints,
          buttonText: 'Give Gift',
          onPressed: gift.targetReached
              ? () {
                  context.read<RewardCubit>().giveReward(gift.id);
                }
              : () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Not enough points ❌")),
                  );
                },
          fit: BoxFit.fill,
          id: gift.id,
        );
      },
    );
  }
}

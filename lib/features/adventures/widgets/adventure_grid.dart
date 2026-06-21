import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:rewarding_kids/features/adventures/cubits/adventure_cubit/adventure_cubit.dart';
import 'package:rewarding_kids/features/adventures/cubits/adventure_cubit/adventure_state.dart';
import 'package:rewarding_kids/features/adventures/widgets/adventure_card.dart';

class AdventureGrid extends StatelessWidget {
  final VoidCallback onLockedTap;

  const AdventureGrid({super.key, required this.onLockedTap});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AdventureCubit, AdventureState>(
      builder: (context, state) {
        if (state is AdventureLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is AdventureSuccess) {
          final adventures = state.adventures;

          return GridView.builder(
            itemCount: adventures.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 14,
              mainAxisSpacing: 13,
              childAspectRatio: 0.70,
            ),
            itemBuilder: (context, index) {
              final adv = adventures[index];

              return AdventureCard(
                banner: adv.bannerImageUrl,
                completedTasksCount: adv.completedTasksCount,

                isLocked:adv.status == "InActive", // بعدين نربطها بالـ accessStatus
                isNew: adv.status == 'Active' && index == 0,
                onLockedTap: onLockedTap,
                onTap: () {
                  context.push(
                    '/adventure_details',
                    extra: adv.weeklyAdventureId, // 🔥 نبعت الـ ID
                  );
                },
                totalDays: adv.totalDays,
                bonusPoints: adv.bonusPoints,
                titleEn: adv.titleEn,
              );
            },
          );
        }

        if (state is AdventureError) {
          return Center(child: Text(state.message));
        }

        return const SizedBox();
      },
    );
  }
}

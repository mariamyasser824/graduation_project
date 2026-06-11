import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rewarding_kids/features/child/cubit/gift_bloc.dart';
import 'package:rewarding_kids/features/child/cubit/gift_state.dart';
import 'package:rewarding_kids/features/child/cubit/progress_cubit.dart';
import 'package:rewarding_kids/features/child/widgets/GiftsGrid.dart';
import 'package:rewarding_kids/features/child/widgets/TabItem.dart';

class GiftsTabs extends StatefulWidget {
  const GiftsTabs({super.key});

  @override
  State<GiftsTabs> createState() => _GiftsTabsState();
}

class _GiftsTabsState extends State<GiftsTabs> {
  int selectedIndex = 0;

  @override
  @override
  void initState() {
    super.initState();
    context.read<GiftsBloc>().add(GetRewardsEvent()); // default tab 0
  }

  void _onTabChanged(int i) {
    setState(() {
      selectedIndex = i;
    });

    if (i == 0) {
      context.read<GiftsBloc>().add(GetRewardsEvent());
    } else {
      context.read<GiftsBloc>().add(GetGiftsEvent());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        /// 🔹 Tabs
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: const Color(0XFFF8F4FA),
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: Row(
              children: [
                TabItem(
                  title: "Gifts from Parent",
                  index: 0,
                  selectedIndex: selectedIndex,
                  onTap: _onTabChanged,
                ),
                TabItem(
                  title: "Store",
                  index: 1,
                  selectedIndex: selectedIndex,
                  onTap: _onTabChanged,
                ),
              ],
            ),
          ),
        ),

        /// 🔥 Listener (أهم جزء)
        BlocListener<GiftsBloc, GiftsState>(
          listener: (context, state) {
            /// ✅ نجاح الشراء
            if (state is GiftPurchaseSuccess) {
              /// 🔥 refresh points
              context.read<ProgressCubit>().fetchPoints();

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    "Gift Purchased 🎉 | Remaining: ${state.remainingPoints}",
                  ),
                ),
              );
            }

            /// ❌ مش كفاية points
            if (state is NotEnoughPoints) {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text("Oops 😢"),
                    content: Text(state.message),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text("OK"),
                      ),
                    ],
                  );
                },
              );
            }

            /// ❌ Error
            if (state is GiftsError) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(state.message)));
            }
          },

          /// 🔹 UI
          child: Expanded(
            child: BlocBuilder<GiftsBloc, GiftsState>(
              builder: (context, state) {
                if (state is GiftsLoading) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (state is GiftsLoaded) {
                  final isMyRewards = state.mode == GiftsMode.rewards;

                  return GiftsGrid(
                    gifts: state.gifts,
                    buttonText: isMyRewards ? 'Get Gift' : 'Buy',
                    fit: BoxFit.contain,
                  );
                }
                return const SizedBox();
              },
            ),
          ),
        ),

        SizedBox(height: 50.h),
      ],
    );
  }
}

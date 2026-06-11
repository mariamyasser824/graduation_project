import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rewarding_kids/core/constants/app_colors.dart';
import 'package:rewarding_kids/core/network/api_service.dart';
import 'package:rewarding_kids/features/child/cubit/gift_bloc.dart';
import 'package:rewarding_kids/features/child/cubit/progress_cubit.dart';
import 'package:rewarding_kids/features/child/data/repos/gift_repo.dart';
import 'package:rewarding_kids/features/child/data/repos/points_repo.dart';
import 'package:rewarding_kids/features/child/widgets/GiftsTabs.dart';
import 'package:rewarding_kids/features/child/widgets/homeAppbar.dart';

class Giftscreen extends StatelessWidget {
  const Giftscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => GiftsBloc(GiftsRepository(ApiService())),
        ),
        BlocProvider(
          create: (context) => ProgressCubit(PointsRepo())..fetchPoints(),
        ),
      ],
      child: Scaffold(
        backgroundColor: AppColors.Background,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 16.h),
            child: Column(
              children: [
                HomeAppbar(),
                SizedBox(height: 10.h),
                Expanded(child: GiftsTabs()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

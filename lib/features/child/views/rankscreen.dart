import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rewarding_kids/core/constants/app_colors.dart';
import 'package:rewarding_kids/core/network/api_service.dart';
import 'package:rewarding_kids/features/adventures/cubits/rank_cubit/ranking_bloc.dart';
import 'package:rewarding_kids/features/adventures/cubits/rank_cubit/ranking_states.dart';
import 'package:rewarding_kids/features/adventures/repos/ranking_repo.dart';
import 'package:rewarding_kids/features/adventures/widgets/rank_body.dart';
import 'package:rewarding_kids/features/child/widgets/homeAppbar.dart';

class RankScreen extends StatelessWidget {
  const RankScreen({super.key});
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          RankingBloc(RankingRepo(ApiService()))..add(GetGlobalRanking()),
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: AppColors.Background,
            title: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
              child: Text("Leaderboard"),
            ),
            titleTextStyle: TextStyle(
              fontSize: 26.sp,
              fontWeight: FontWeight.w600,
              color: Color(0xff55425F),
            ),

            centerTitle: false, // عشان يبقى شمال زي التصميم
          ),

          backgroundColor: AppColors.Background,
          body: RankBody(),
        ),
      ),
    );
  }
}

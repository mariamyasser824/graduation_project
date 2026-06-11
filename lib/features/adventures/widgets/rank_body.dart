import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rewarding_kids/core/constants/app_colors.dart';
import 'package:rewarding_kids/features/adventures/cubits/rank_cubit/ranking_bloc.dart';
import 'package:rewarding_kids/features/adventures/cubits/rank_cubit/ranking_states.dart';
import 'package:rewarding_kids/features/adventures/models/ranking_model.dart';
import 'package:rewarding_kids/features/adventures/widgets/GradientTabs.dart';
import 'package:rewarding_kids/features/adventures/widgets/LeaderboardItem.dart';
import 'package:rewarding_kids/features/adventures/widgets/PodiumWidge.dart';
import 'package:rewarding_kids/features/adventures/widgets/TopThreeWidget.dart';

class RankBody extends StatefulWidget {
  const RankBody({super.key});

  @override
  State<RankBody> createState() => _RankBodyState();
}

class _RankBodyState extends State<RankBody> {
  bool isCollapsed = false;
  final ScrollController _scrollController = ScrollController();

  int selectedTab = 0; // 👈 0 = Global | 1 = School

  @override
  void initState() {
    super.initState();
    context.read<RankingBloc>().add(GetGlobalRanking());
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: (scroll) {
        if (scroll.metrics.pixels > 120 && !isCollapsed) {
          setState(() => isCollapsed = true);
        } else if (scroll.metrics.pixels <= 120 && isCollapsed) {
          setState(() => isCollapsed = false);
        }
        return false;
      },
      child: BlocBuilder<RankingBloc, RankingState>(
        builder: (context, state) {
          /// 👇 هنتعامل مع كل الحالات هنا
          List<RankingUser> users = [];

          if (state is RankingSuccess) {
            users = state.data.topRanking;
          }

          /// ❗ لو error (زي institution) → نسيب users فاضية
          /// وهنعرض UI عادي بس بدون data

          return CustomScrollView(
            controller: _scrollController,
            physics: const AlwaysScrollableScrollPhysics(),
            slivers: [
              /// 🔝 Tabs
              SliverAppBar(
                backgroundColor: AppColors.Background,
                pinned: true,
                toolbarHeight: 100,
                elevation: 0,
                flexibleSpace: Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: GradientTabs(
                    onTabChanged: (index) {
                      selectedTab = index;

                      _scrollController.animateTo(
                        0,
                        duration: const Duration(milliseconds: 400),
                        curve: Curves.easeInOut,
                      );

                      setState(() => isCollapsed = false);

                      /// 🔁 call API
                      if (index == 0) {
                        context.read<RankingBloc>().add(GetGlobalRanking());
                      } else {
                        context.read<RankingBloc>().add(
                          GetInstitutionRanking(),
                        );
                      }
                    },
                  ),
                ),
              ),

              /// 🏆 Podium
              SliverAppBar(
                backgroundColor: AppColors.Background,
                expandedHeight: 320,
                pinned: false,
                elevation: 0,
                flexibleSpace: FlexibleSpaceBar(
                  collapseMode: CollapseMode.parallax,
                  background: _buildPodium(users),
                ),
              ),

              /// 📋 List
              SliverToBoxAdapter(
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: _buildList(users),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  /// 🏆 Podium Dynamic
  Widget _buildPodium(List<RankingUser> users) {
    if (users.length < 3) {
      /// 👇 fallback (نفس الشكل القديم)
      return PodiumWidget(
        topUsers: [
          PodiumUser(
            name: "-",
            image: "assets/child/rank1.png",
            points: "0 XP",
          ),
          PodiumUser(
            name: "-",
            image: "assets/child/rank2.png",
            points: "0 XP",
          ),
          PodiumUser(
            name: "-",
            image: "assets/child/rank3.png",
            points: "0 XP",
          ),
        ],
      );
    }

    final top3 = users.take(3).toList();

    return PodiumWidget(
      topUsers: [
        PodiumUser(
          name: top3[1].childName,
          image: top3[0].avatarUrl ?? "assets/child/rank2.png",
          points: "${top3[1].highestPoints} XP",
        ),
        PodiumUser(
          name: top3[0].childName,
          image: top3[0].avatarUrl ?? "assets/child/rank1.png",
          points: "${top3[0].highestPoints} XP",
        ),
        PodiumUser(
          name: top3[2].childName,
          image: top3[0].avatarUrl ?? "assets/child/rank3.png",
          points: "${top3[2].highestPoints} XP",
        ),
      ],
    );
  }

  /// 📋 List Dynamic
  Widget _buildList(List<RankingUser> users) {
    if (users.isEmpty) {
      /// 👇 مفيش data → نعرض UI فاضي بنفس الشكل
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Text("No ranking data yet"),
        ),
      );
    }

    /// 👇 لو collapsed نشيل top 3
    final list = isCollapsed ? users : users.skip(3).toList();

    return Column(
      children: List.generate(list.length, (index) {
        final user = list[index];

        return LeaderboardItem(
          name: user.childName,
          rank: user.rank,
          avatarUrl: user.avatarUrl,
          points: user.highestPoints,
          isTopThree: user.rank <= 3,
          isLast: index == list.length - 1,
        );
      }),
    );
  }
}

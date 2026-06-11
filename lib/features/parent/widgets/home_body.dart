import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rewarding_kids/features/parent/cubit/statistics_cubit/statistics_cubit.dart';
import 'package:rewarding_kids/features/parent/cubit/statistics_cubit/statistics_state.dart';
import 'package:rewarding_kids/features/parent/models/statistics_model.dart';
import 'package:rewarding_kids/features/parent/widgets/Home_appbar.dart';
import 'package:rewarding_kids/features/parent/widgets/Performance_card.dart';
import 'package:rewarding_kids/features/parent/widgets/home_header.dart';
import 'package:rewarding_kids/features/parent/widgets/home_tabs.dart';
import 'package:rewarding_kids/features/parent/widgets/tasks_card.dart';
import 'package:rewarding_kids/features/parent/widgets/tasks_summary_card.dart';

class HomeBody extends StatefulWidget {
  const HomeBody({super.key});

  @override
  State<HomeBody> createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  String currentFilter = "ThisWeek";

  @override
  void initState() {
    super.initState();

    _tabController = TabController(length: 3, vsync: this);

    Future.microtask(() {
      context.read<StatisticsCubit>().getStatistics(currentFilter);
    });
  }

  void _onTabChanged(int index) {
    setState(() {
      _tabController.index = index;

      if (index == 0) {
        currentFilter = "ThisWeek";
      } else if (index == 1) {
        currentFilter = "ThisMonth";
      } else {
        currentFilter = "AllTime";
      }
    });

    context.read<StatisticsCubit>().getStatistics(currentFilter);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        children: [
          const HomeAppbar(),
          SizedBox(height: 10.h),

          BlocBuilder<StatisticsCubit, StatisticsState>(
            builder: (context, state) {
              if (state is StatisticsSuccess) {
                final data = state.data;

                return HomeHeader(
                  name: data.childName,
                  totalPoints: data.totalPoints,
                  image: data.avatarUrl ?? "",
                );
              }

              return const SizedBox();
            },
          ),

          Expanded(
            child: BlocBuilder<StatisticsCubit, StatisticsState>(
              builder: (context, state) {
                if (state is StatisticsLoading) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (state is StatisticsError) {
                  return Center(child: Text(state.message));
                }

                if (state is StatisticsSuccess) {
                  final data = state.data;

                  return CustomTabsSection(
                    controller: _tabController,
                    onTabChanged: _onTabChanged,
                    widget1: buildContent(data),
                    widget2: buildContent(data),
                    widget3: buildContent(data),
                  );
                }

                return const SizedBox();
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget buildContent(StatisticsModel data) {
    final stats = data.getStatsByType(currentFilter);

    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: 16),
          TasksSummaryCard(stats: stats),
          SizedBox(height: 16),
          TasksCard(stats: stats),
          SizedBox(height: 16),
          PerformanceCard(data: data),
        ],
      ),
    );
  }
}

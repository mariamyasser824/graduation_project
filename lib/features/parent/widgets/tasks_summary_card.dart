import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rewarding_kids/features/parent/models/statistics_model.dart';
import 'package:rewarding_kids/features/parent/widgets/task_summary_grid.dart';

class TasksSummaryCard extends StatelessWidget {
  const TasksSummaryCard({super.key, required this.stats});
  final PeriodStats stats;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 220.h,
      child: TaskSummaryGrid(stats: stats),
    );
  }
}

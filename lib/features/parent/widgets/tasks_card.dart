import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rewarding_kids/features/parent/models/statistics_model.dart';
import 'package:rewarding_kids/features/parent/widgets/tasks_grid.dart';

class TasksCard extends StatelessWidget {
  final PeriodStats stats;

  const TasksCard({super.key, required this.stats});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 230.h,
      decoration: BoxDecoration(
        color: Color(0xffF8E9FF),
        borderRadius: BorderRadius.all(Radius.circular(20.h)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 20,
            spreadRadius: 0,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
        child: TasksGrid(stats: stats),
      ),
    );
  }
}

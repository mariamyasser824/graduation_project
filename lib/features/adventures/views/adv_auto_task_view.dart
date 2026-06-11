import 'package:flutter/material.dart';
import 'package:rewarding_kids/core/constants/app_colors.dart';
import 'package:rewarding_kids/features/adventures/widgets/auto_task_body.dart';

class AdvAutoTaskView extends StatelessWidget {
  const AdvAutoTaskView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.Background,
      body: AutoTaskBody(),
    );
  }
}

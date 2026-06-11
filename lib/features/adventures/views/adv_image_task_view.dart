import 'package:flutter/material.dart';
import 'package:rewarding_kids/core/constants/app_colors.dart';
import 'package:rewarding_kids/features/adventures/widgets/image_task_body.dart';

class AdvImageTaskView extends StatelessWidget {
  const AdvImageTaskView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.Background,
      body: ImageTaskBody(),
    );
  }
}

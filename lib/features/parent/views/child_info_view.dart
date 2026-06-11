import 'package:flutter/material.dart';
import 'package:rewarding_kids/core/constants/app_colors.dart';
import 'package:rewarding_kids/features/parent/widgets/child_info_body.dart';

class ChildInfoView extends StatelessWidget {
  const ChildInfoView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.Background,
        body: ChildInfoBody(),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:rewarding_kids/core/constants/app_colors.dart';
import 'package:rewarding_kids/features/adventures/widgets/celepration_body.dart';

class CeleprationView extends StatelessWidget {
  const CeleprationView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.Background,
        body: CeleprationBody(),
      ),
    );
  }
}

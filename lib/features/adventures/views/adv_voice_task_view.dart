import 'package:flutter/material.dart';
import 'package:rewarding_kids/core/constants/app_colors.dart';
import 'package:rewarding_kids/features/adventures/widgets/voice_task_body.dart';

class AdvVoiceTaskView extends StatelessWidget {
  const AdvVoiceTaskView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.Background,
      body: VoiceTaskBody(),
    );
  }
}

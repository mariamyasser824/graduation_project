import 'package:flutter/material.dart';
import 'package:rewarding_kids/core/constants/app_colors.dart';
import 'package:rewarding_kids/features/adventures/models/adv_task_model.dart';
import 'package:rewarding_kids/features/adventures/models/basetask_model.dart';
import 'package:rewarding_kids/features/adventures/widgets/voice_task_body.dart';

class AdvVoiceTaskView extends StatelessWidget {
  final AdvTaskModel task;

  const AdvVoiceTaskView({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: VoiceTaskBody(task: task));
  }
}

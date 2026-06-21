import 'package:flutter/material.dart';
import 'package:rewarding_kids/core/constants/app_colors.dart';
import 'package:rewarding_kids/features/adventures/models/adv_task_model.dart';
import 'package:rewarding_kids/features/adventures/widgets/image_task_body.dart';

class AdvImageTaskView extends StatelessWidget {
  final AdvTaskModel task;

  const AdvImageTaskView({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: ImageTaskBody(task: task));
  }
}

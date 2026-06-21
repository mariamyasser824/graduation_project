import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:rewarding_kids/features/adventures/models/adv_task_model.dart';
import 'package:rewarding_kids/features/adventures/models/basetask_model.dart';
import 'package:rewarding_kids/features/adventures/widgets/StackedAdventureCard.dart';
import 'package:rewarding_kids/features/adventures/widgets/check_item.dart';
import 'package:rewarding_kids/features/adventures/widgets/start_adventure_button.dart';
import 'package:rewarding_kids/features/adventures/widgets/task_header.dart';
import 'package:rewarding_kids/features/child/cubit/SubmitTaskCubit.dart';

class ImageTaskBody extends StatelessWidget {
  final AdvTaskModel task;
  const ImageTaskBody({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 25.h),
            child: TaskHeader(),
          ),
          SizedBox(height: 30.h),
          AdventureCard(
            title: task.titleEn,
            subtitle: "Win ${task.stars} points",
            step: "Step ${task.dayNumber} of 7",
            icon: Icons.image_outlined,
            onMicTap: () {},
          ),
          SizedBox(height: 70.h),
          CheckItem(text: 'Look at your work carefully 🌟'),
          SizedBox(height: 10.h),
          CheckItem(text: 'Take a clear photo 📸'),

          SizedBox(height: 10.h),
          CheckItem(text: 'Make sure we can see your answer ⭐'),
          Spacer(),
          StartAdventureButton(
            onTap: () {
              GoRouter.of(context).push(
                '/take_image',
                extra: {
                  "task": task,
                  "type": SubmitType.adventure, // أو adventure
                  // لو adventure بس
                  "adventureTaskId": task.adventureTaskId,
                  "weeklyAdventureId": task.weeklyAdventureId,
                },
              );
            },
            text: 'Take a Photo',
          ),
        ],
      ),
    );
  }
}

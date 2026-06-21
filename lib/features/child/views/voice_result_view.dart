import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:rewarding_kids/Shared/Custombutton.dart';
import 'package:rewarding_kids/Shared/CustomText.dart';
import 'package:rewarding_kids/core/constants/app_colors.dart';
import 'package:rewarding_kids/features/child/cubit/SubmitTaskCubit.dart';
import 'package:rewarding_kids/features/child/data/models/SubmitTaskResponseModel.dart';
import 'package:rewarding_kids/features/child/data/models/task_model.dart';
import 'package:rewarding_kids/features/child/widgets/RecordedVoiceBubble.dart';
import 'package:rewarding_kids/features/child/widgets/homeAppbar.dart';
import 'package:rewarding_kids/features/onboarding/widgets/popbutton.dart';

class VoiceResultView extends StatefulWidget {
  final dynamic task;
  final String audioPath;
  final SubmitTaskResponse response;
  final SubmitType type;

  const VoiceResultView({
    super.key,
    required this.task,
    required this.audioPath,
    required this.response,
    required this.type,
  });

  @override
  State<VoiceResultView> createState() => _VoiceResultViewState();
}

class _VoiceResultViewState extends State<VoiceResultView> {
  int attempts = 1;

  Color getColor(String color) {
    switch (color.toLowerCase()) {
      case "green":
        return Colors.green;

      case "red":
        return Colors.red;
      case "yellow":
        return Colors.orangeAccent;

      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    final result = widget.response.data?.shadowingResult;

    final words = result?.words ?? [];

    final scoreStatus = result?.scoreStatus ?? "Poor";

    bool success = scoreStatus == "Good" || scoreStatus == "Excellent";

    return Scaffold(
      backgroundColor: AppColors.Background,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
          child: Column(
            children: [
              Row(
                children: [
                  Popbutton(onPressed: () => context.pop()),

                  SizedBox(width: 70.w),

                  Expanded(
                    child: CustomText(
                      text: widget.task.titleEn,
                      iscenter: true,
                      size: 20.sp,
                      color: AppColors.titleColor,
                      weight: FontWeight.w600,
                    ),
                  ),
                ],
              ),

              SizedBox(height: 25.h),

              HomeAppbar(),

              SizedBox(height: 40.h),

              RecordedVoiceBubble(audioPath: widget.audioPath),

              SizedBox(height: 30.h),

              /// الكلما
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: words.map((word) {
                  return Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 14.w,
                      vertical: 8.h,
                    ),
                    decoration: BoxDecoration(
                      color: getColor(word.color).withOpacity(.2),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      word.word,
                      style: TextStyle(
                        color: getColor(word.color),
                        fontWeight: FontWeight.bold,
                        fontSize: 16.sp,
                      ),
                    ),
                  );
                }).toList(),
              ),

              SizedBox(height: 30.h),

              CustomText(
                text: widget.response.data?.message ?? "",
                size: 18.sp,
                color: AppColors.titleColor,
                weight: FontWeight.w500,
                iscenter: true,
              ),
              SizedBox(height: 10.h),
              CustomText(
                text: widget.response.data?.message ?? "",
                size: 18.sp,
                color: AppColors.titleColor,
                weight: FontWeight.w500,
                iscenter: true,
              ),
              Spacer(),

              Custombutton(
                text: success ? "Submit" : "Try Again",
                onPressed: () {
                  if (success) {
                    if (widget.type == SubmitType.normal) {
                      context.push(
                        '/record_completed',
                        extra: {
                          "task": widget.task,
                          "audio_path": widget.audioPath,
                        },
                      );
                    } else {
                      context.push('/adv_celepration'); // 🔥 هنا الفرق
                    }
                  } else {
                    context.push(
                      '/record_task',
                      extra: {
                        "task": widget.task,
                        "type": widget.type,
                        "adventureTaskId": widget.type == SubmitType.adventure
                            ? widget.task.adventureTaskId
                            : null,
                        "weeklyAdventureId": widget.type == SubmitType.adventure
                            ? widget.task.weeklyAdventureId
                            : null,
                      },
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

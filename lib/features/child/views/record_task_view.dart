import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_sound/public/flutter_sound_player.dart';
import 'package:flutter_sound/public/flutter_sound_recorder.dart';
import 'package:go_router/go_router.dart';
import 'package:rewarding_kids/Shared/CustomText.dart';
import 'package:rewarding_kids/core/constants/app_colors.dart';
import 'package:rewarding_kids/features/child/cubit/SubmitTaskCubit.dart';
import 'package:rewarding_kids/features/child/cubit/SubmitTaskState%20.dart';
import 'package:rewarding_kids/features/child/data/models/task_model.dart';
import 'package:rewarding_kids/features/child/widgets/Recoder.dart';
import 'package:rewarding_kids/features/onboarding/widgets/popbutton.dart';
import 'package:rewarding_kids/features/child/widgets/homeAppbar.dart';

class RecordTaskView extends StatefulWidget {
  final TaskModel Taskdetails;

  const RecordTaskView({super.key, required this.Taskdetails});

  @override
  State<RecordTaskView> createState() => _RecordTaskViewState();
}

class _RecordTaskViewState extends State<RecordTaskView> {
  final FlutterSoundRecorder recorder = FlutterSoundRecorder();
  final FlutterSoundPlayer player = FlutterSoundPlayer();
  bool isRecorderInitialized = false;
  String? recordedFilePath;
  int attempts = 0;

  void submitVoice() {
    if (recordedFilePath == null) return;

    context.read<SubmitTaskCubit>().submit(
      taskId: widget.Taskdetails.id,
      voicePath: recordedFilePath,
    );
  }

  @override
  void initState() {
    super.initState();
    initRecorder();
    player.openPlayer();
  }

  Future initRecorder() async {
    await recorder.openRecorder();
    setState(() => isRecorderInitialized = true);
  }

  Future<String?> stopRecordingIfNeeded() async {
    if (recorder.isRecording || recorder.isPaused) {
      final path = await recorder.stopRecorder();
      setState(() => recordedFilePath = path);
      return path;
    }
    return recordedFilePath;
  }

  @override
  void dispose() {
    recorder.closeRecorder();
    player.closePlayer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SubmitTaskCubit, SubmitTaskState>(
      listener: (context, state) {
        if (state.status == SubmitStatus.loading) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (_) => const Center(child: CircularProgressIndicator()),
          );
        }

        if (state.status == SubmitStatus.success) {
          if (Navigator.canPop(context)) {
            Navigator.pop(context); // يقفل اللودينج هنا بس
          }
          if (recordedFilePath == null) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(const SnackBar(content: Text("Audio not found")));
          } else {
            context.push(
              '/voice_result',
              extra: {
                "response": state.response,
                "audioPath": recordedFilePath, // ✅ الصح
                "task": widget.Taskdetails,
              },
            );
          }
        }
        if (state.status == SubmitStatus.error) {
          if (Navigator.canPop(context)) {
            Navigator.pop(context); // يقفل اللودينج هنا بس
          }
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.error ?? "Error")));
        }
      },

      child: Scaffold(
        backgroundColor: AppColors.Background,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
            child: Column(
              children: [
                Row(
                  children: [
                    Popbutton(
                      onPressed: () {
                        if (context.canPop()) {
                          context.pop();
                        } else {
                          context.go('/home_child');
                        }
                      },
                    ),
                    SizedBox(width: 70.w),
                    Expanded(
                      child: CustomText(
                        text: widget.Taskdetails.titleEn,
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
                SizedBox(height: 180.h),
                Expanded(
                  child: SimpleRecorder(
                    Taskdetails: widget.Taskdetails,
                    onSubmit: (path) {
                      recordedFilePath = path; // ✅ خزني الباث هنا

                      context.read<SubmitTaskCubit>().submit(
                        taskId: widget.Taskdetails.id,
                        voicePath: path,
                      );
                    },
                  ),
                ),

                /*  Custombutton(
                  text: 'Submit',
                  onPressed: () async {
                    final filePath = await stopRecordingIfNeeded();
      
                    context.read<ProgressCubit>().completeTask(
                          widget.Taskdetails.point,
                        );
      
                    GoRouter.of(context).push(
                      '/record_completed',
                      extra: {
                        "task": widget.Taskdetails,
                        "audio_path": filePath,
                      },
                    );
                  },
                ),*/
              ],
            ),
          ),
        ),
      ),
    );
  }
}

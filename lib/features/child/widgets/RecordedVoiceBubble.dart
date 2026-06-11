import 'dart:io';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_sound/public/flutter_sound_player.dart';
import 'package:voice_message_package/voice_message_package.dart';
import 'package:rewarding_kids/core/constants/app_colors.dart';

class RecordedVoiceBubble extends StatefulWidget {
  final String audioPath;

  const RecordedVoiceBubble({super.key, required this.audioPath});

  @override
  State<RecordedVoiceBubble> createState() => _RecordedVoiceBubbleState();
}

class _RecordedVoiceBubbleState extends State<RecordedVoiceBubble> {
  Duration? _audioDuration;
  final AudioPlayer _durationPlayer = AudioPlayer();

  @override
  void initState() {
    super.initState();
    _loadDuration();
  }

  Future<void> _loadDuration() async {
    if (!File(widget.audioPath).existsSync()) return;

    try {
      await _durationPlayer.setSourceDeviceFile(widget.audioPath);
      final duration = await _durationPlayer.getDuration();

      if (mounted) {
        setState(() {
          _audioDuration = duration;
        });
      }
    } catch (e) {
      debugPrint('Error loading duration: $e');
    }
  }

  String _formatDuration(Duration d) {
    final minutes = d.inMinutes.remainder(60).toString().padLeft(2, '0');
    final seconds = d.inSeconds.remainder(60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  @override
  void dispose() {
    _durationPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Safety check
    if (!File(widget.audioPath).existsSync()) {
      return Container(
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          color: AppColors.Background,
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: const Text(
          'Audio file not found',
          style: TextStyle(color: Colors.red),
        ),
      );
    }
    /*
Container(
      width: 300.w,
      height: 62.h,
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: const Color(0xffB9A2C5),
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.7),
            blurRadius: 8,
            spreadRadius: 0,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child:
     */

    return Column(
      children: [
        Container(
          width: 310.w,
          height: 95.h,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(16.r)),
          child: VoiceMessageView(
            controller: VoiceController(
              audioSrc: widget.audioPath,
              isFile: true,
              maxDuration: _audioDuration ?? const Duration(seconds: 60),
              onComplete: () {},
              onPause: () {},
              onPlaying: () {},
            ),

            backgroundColor: Color(0xffB9A2C5),
            playPauseButtonLoadingColor: Colors.white,
            circlesColor: Color(0xff7B6C83).withOpacity(0.4),
            counterTextStyle: TextStyle(
              color: Color(0xff7B6C83),
              fontSize: 12.sp,
            ),
            activeSliderColor: Colors.white,
            //size: 50,
            // innerPadding: 12,
            cornerRadius: 20,
          ),
        ),

        SizedBox(height: 6.h),
      ],
    );
  }
}

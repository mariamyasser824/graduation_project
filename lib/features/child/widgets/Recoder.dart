import 'dart:io';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path_provider/path_provider.dart';
import 'package:rewarding_kids/features/child/widgets/DashedBubble.dart';
import 'package:rewarding_kids/core/constants/app_colors.dart';

class SimpleRecorder extends StatefulWidget {
  const SimpleRecorder({
    super.key,
    required this.Taskdetails,
    required this.onSubmit,
    // ✅ باث الصورة بتاعت الكاركتر
  });

  final dynamic Taskdetails;
  final Function(String path) onSubmit;

  @override
  State<SimpleRecorder> createState() => _SimpleRecorderState();
}

class _SimpleRecorderState extends State<SimpleRecorder>
    with TickerProviderStateMixin {
  final FlutterSoundRecorder _recorder = FlutterSoundRecorder();
  final FlutterSoundPlayer _player = FlutterSoundPlayer();
  bool isRecorderReady = false;
  String? recordedFilePath;

  // Waveform animation
  late AnimationController _waveController;
  final int _barCount = 9;

  @override
  void initState() {
    super.initState();
    _initRecorder();
    _player.openPlayer();

    _waveController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
  }

  Future<void> _initRecorder() async {
    final status = await Permission.microphone.request();
    if (status != PermissionStatus.granted) return;
    await _recorder.openRecorder();
    await _player.openPlayer();
    setState(() => isRecorderReady = true);
  }

  Future<void> _startRecording() async {
    if (!isRecorderReady) return;
    final dir = await getApplicationDocumentsDirectory();
    recordedFilePath =
        '${dir.path}/record_${DateTime.now().millisecondsSinceEpoch}.aac';
    await _recorder.startRecorder(
      toFile: recordedFilePath,
      codec: Codec.aacADTS,
    );
    _waveController.repeat(reverse: true);
    setState(() {});
  }

  Future<void> _stopRecording() async {
    if (!_recorder.isRecording) return;
    final path = await _recorder.stopRecorder();
    if (path != null && File(path).existsSync()) {
      recordedFilePath = path;
    } else {
      recordedFilePath = null;
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Recording failed, try again')),
        );
      }
    }
    _waveController.stop();
    setState(() {});
  }

  Future<void> _submitVoice() async {
    if (recordedFilePath == null) return;
    widget.onSubmit(recordedFilePath!);
  }

  @override
  void dispose() {
    _recorder.closeRecorder();
    _player.closePlayer();
    _waveController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool isRecording = _recorder.isRecording;
    final bool hasRecording = recordedFilePath != null && !isRecording;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ── NEW WORDS badge ──
        Row(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
              decoration: BoxDecoration(
                color: const Color(0xffF3EEFF),
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.auto_awesome,
                    size: 14.sp,
                    color: const Color(0xff9B59B6),
                  ),
                  SizedBox(width: 4.w),
                  Text(
                    'NEW WORDS',
                    style: TextStyle(
                      fontSize: 11.sp,
                      color: const Color(0xff9B59B6),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),

        SizedBox(height: 12.h),

        // ── Title ──
        Text(
          'Speak this in English',
          style: TextStyle(
            fontSize: 22.sp,
            fontWeight: FontWeight.bold,
            color: AppColors.titleColor,
          ),
        ),

        SizedBox(height: 20.h),

        // ── Character + Speech bubble ──
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Character image
            Image.asset(
              "assets/child/record_character1.png",
              width: 90.w,
              height: 110.h,
              fit: BoxFit.contain,
            ),

            SizedBox(width: 12.w),

            // Speech bubble
            Expanded(
              child: Container(
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(4.r),
                    topRight: Radius.circular(16.r),
                    bottomLeft: Radius.circular(16.r),
                    bottomRight: Radius.circular(16.r),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.06),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: DashedBubble(text: widget.Taskdetails.titleEn ?? ''),
              ),
            ),
          ],
        ),

        SizedBox(height: 30.h),

        // ── Tap to speak / Waveform ──
        if (!isRecording && !hasRecording)
          // State 1: idle → "Tap to speak" outlined button
          GestureDetector(
            onTap: _startRecording,
            child: Container(
              width: double.infinity,
              height: 54.h,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14.r),
                border: Border.all(color: const Color(0xffD1C4E9), width: 1.5),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.mic_none,
                    color: const Color(0xff9B59B6),
                    size: 20.sp,
                  ),
                  SizedBox(width: 8.w),
                  Text(
                    'Tap to speak',
                    style: TextStyle(
                      fontSize: 15.sp,
                      color: const Color(0xff6B7280),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          )
        else if (isRecording)
          // State 2: recording → waveform animation
          GestureDetector(
            onTap: _stopRecording,
            child: Container(
              width: double.infinity,
              height: 54.h,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14.r),
                border: Border.all(color: const Color(0xffD1C4E9), width: 1.5),
              ),
              child: Center(
                child: AnimatedBuilder(
                  animation: _waveController,
                  builder: (context, _) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: List.generate(_barCount, (i) {
                        final phase = (i / _barCount) * math.pi;
                        final height =
                            8 +
                            18 *
                                math
                                    .sin(
                                      _waveController.value * math.pi + phase,
                                    )
                                    .abs();
                        return Padding(
                          padding: EdgeInsets.symmetric(horizontal: 2.5.w),
                          child: Container(
                            width: 4.w,
                            height: height.h,
                            decoration: BoxDecoration(
                              color: const Color(0xff9B59B6),
                              borderRadius: BorderRadius.circular(4.r),
                            ),
                          ),
                        );
                      }),
                    );
                  },
                ),
              ),
            ),
          )
        else
          // State 3: has recording → show re-record option
          GestureDetector(
            onTap: () {
              setState(() => recordedFilePath = null);
            },
            child: Container(
              width: double.infinity,
              height: 54.h,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14.r),
                border: Border.all(color: const Color(0xffD1C4E9), width: 1.5),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.check_circle, color: Colors.green, size: 20.sp),
                  SizedBox(width: 8.w),
                  Text(
                    'Recorded – tap to redo',
                    style: TextStyle(
                      fontSize: 15.sp,
                      color: const Color(0xff6B7280),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),

        const Spacer(),

        // ── Check Answers button ──
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: hasRecording ? _submitVoice : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xff2D2D3A),
              disabledBackgroundColor: const Color(0xff2D2D3A).withOpacity(0.4),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14.r),
              ),
              padding: EdgeInsets.symmetric(vertical: 16.h),
            ),
            child: Text(
              'Check Answers',
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),
        ),

        SizedBox(height: 8.h),
      ],
    );
  }
}

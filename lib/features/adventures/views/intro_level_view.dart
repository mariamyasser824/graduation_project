import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:rewarding_kids/features/adventures/models/adv_task_model.dart';
import 'package:rewarding_kids/features/adventures/widgets/adventure_header_image.dart';
import 'package:rewarding_kids/features/adventures/widgets/intro_card.dart';

class IntroLevelView extends StatefulWidget {
  final AdvTaskModel task;

  const IntroLevelView({super.key, required this.task});

  @override
  State<IntroLevelView> createState() => _IntroLevelViewState();
}

class _IntroLevelViewState extends State<IntroLevelView> {
  final AudioPlayer _player = AudioPlayer();

  @override
  void initState() {
    super.initState();
    playAudio();
  }

  Future<void> playAudio() async {
    try {
      final url = widget.task.storyVoiceUrl;

      if (url == null || url.isEmpty) return;

      await _player.setUrl(url);
      await _player.play();
    } catch (e) {
      print("Audio Error: $e");
    }
  }

  // 👇 مهم: لما تخرجي من الصفحة (push لصفحة جديدة)
  @override
  void deactivate() {
    _player.stop(); // يوقف الصوت فورًا
    super.deactivate();
  }

  // 👇 لما الصفحة تتقفل نهائي
  @override
  void dispose() {
    _player.stop();
    _player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF7E6EF),
      body: Stack(
        children: [
          AdventureHeaderImage(image: 'assets/child/intro_level.png'),
          IntroCard(task: widget.task),
        ],
      ),
    );
  }
}

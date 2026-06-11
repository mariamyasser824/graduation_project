import 'package:flutter/material.dart';
import 'package:rewarding_kids/features/adventures/widgets/adventure_header_image.dart';
import 'package:rewarding_kids/features/adventures/widgets/intro_card.dart';

class IntroLevelView extends StatelessWidget {
  const IntroLevelView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF7E6EF),

      body: Stack(
        children: [
          /// 🔥 الصورة
          AdventureHeaderImage(image: 'assets/child/intro_level.png'),

          /// 📄 الكارد
          IntroCard(),
        ],
      ),
    );
  }
}

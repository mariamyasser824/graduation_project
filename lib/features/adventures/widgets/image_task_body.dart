import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:rewarding_kids/features/adventures/widgets/StackedAdventureCard.dart';
import 'package:rewarding_kids/features/adventures/widgets/check_item.dart';
import 'package:rewarding_kids/features/adventures/widgets/start_adventure_button.dart';
import 'package:rewarding_kids/features/adventures/widgets/task_header.dart';

class ImageTaskBody extends StatelessWidget {
  const ImageTaskBody({super.key});

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
            title: "Show the stars you counted",
            subtitle: "Win 40 points ",
            step: "Step 2 of 7",
            icon: Icons.image_outlined,
            onMicTap: () {
              //  print("Mic clicked");
            },
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
              context.push('/adv_auto_task');
            },
            text: 'Take a Photo',
          ),
        ],
      ),
    );
  }
}

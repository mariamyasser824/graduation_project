import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:rewarding_kids/features/adventures/widgets/StackedAdventureCard.dart';
import 'package:rewarding_kids/features/adventures/widgets/check_item.dart';
import 'package:rewarding_kids/features/adventures/widgets/start_adventure_button.dart';
import 'package:rewarding_kids/features/adventures/widgets/task_header.dart';

class AutoTaskBody extends StatelessWidget {
  const AutoTaskBody({super.key});

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
            step: "Step 3 of 7",
            icon: Icons.check,
            onMicTap: () {
              //  print("Mic clicked");
            },
          ),
          SizedBox(height: 70.h),
          CheckItem(text: ' Look at your work carefully 🌟'),
          SizedBox(height: 10.h),
          CheckItem(text: 'Tap “Done” when finished 🌟'),

          Spacer(),
          StartAdventureButton(
            onTap: () {
              context.push('/adv_celepration');
            },
            text: 'Mission Complete',
          ),
        ],
      ),
    );
  }
}

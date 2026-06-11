import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class ChildAvatar extends StatelessWidget {
  const ChildAvatar({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.push('/child_profile');
      },
      child: Container(
        width: 32.w,
        height: 32.h,

        decoration: BoxDecoration(shape: BoxShape.circle),
        child: CircleAvatar(
          backgroundImage: AssetImage('assets/child/girlavatar.png'),
          radius: 30.r,
        ),
      ),
    );
  }
}

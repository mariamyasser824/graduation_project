import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../models/level_model.dart';

class LevelCircle extends StatelessWidget {
  final LevelModel level;
  final VoidCallback? onTap;

  const LevelCircle({super.key, required this.level, this.onTap});

  @override
  Color getLevelColor() {
    switch (level.state) {
      case LevelState.locked:
        return Colors.grey.shade300;

      case LevelState.unlocked:
        return Colors.purple;

      case LevelState.inProgress:
        return Colors.orange;

      case LevelState.completed:
        return Colors.purple;
    }
  }

  BoxDecoration getDecoration() {
    if (level.state == LevelState.locked) {
      return BoxDecoration(
        shape: BoxShape.circle,
        color: Color(0xffB5B5B5),
        border: Border.all(width: 4.w, color: Color(0xffD6D3E8)),
      );
    }
    if (level.state == LevelState.unlocked) {
      return BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          colors: [Color(0xffD8B4FE), Color(0xff9333EA)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        border: Border.all(width: 4.w, color: Color(0xffFFFCF2)),
      );
    }

    return BoxDecoration(
      shape: BoxShape.circle,
      gradient: LinearGradient(
        colors: [Color(0xffD8B4FE), Color(0xff9333EA)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      border: Border.all(width: 4.w, color: Color(0xffFFCC00)),
    );
  }

  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          /// ⭐ النجوم
          Row(
            mainAxisSize: MainAxisSize.min,
            children: List.generate(3, (index) {
              final isFilled = index < level.stars;

              IconData icon;
              Color color;

              switch (level.state) {
                case LevelState.locked:
                case LevelState.unlocked:
                  icon = Icons.star_outline_rounded;
                  color = Color(0xff9CA3AF);

                  break;

                case LevelState.inProgress:
                case LevelState.completed:
                  icon = isFilled ? Icons.star : Icons.star_outline;
                  color = isFilled ? Color(0xffFFC100) : Color(0xff9CA3AF);
                  break;
              }

              return Icon(icon, size: 20.sp, weight: 4, color: color);
            }),
          ),

          SizedBox(height: 4.h),

          /// 🔵 الدايرة
          Container(
            width: 60.w,
            height: 60.w,
            decoration: getDecoration(),
            child: Center(
              child: () {
                switch (level.state) {
                  case LevelState.locked:
                    return Icon(Icons.lock_outlined, color: Colors.white);

                  case LevelState.unlocked:
                    return Text(
                      "${level.number}",
                      style: TextStyle(
                        color: Color(0xffFFFCF2),
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    );

                  case LevelState.inProgress:
                    return Text(
                      "${level.number}",
                      style: TextStyle(
                        color: Color(0xffFFCC00),
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    );

                  case LevelState.completed:
                    return Text(
                      "${level.number}",
                      style: TextStyle(
                        color: Color(0xffFFCC00),
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    );
                }
              }(),
            ),
          ),
        ],
      ),
    );
  }
}

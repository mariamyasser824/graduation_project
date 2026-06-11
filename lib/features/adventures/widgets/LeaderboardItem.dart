import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class LeaderboardItem extends StatelessWidget {
  final String name;
  final int rank;
  final bool isTopThree;
  final bool isLast;
  final String? avatarUrl;
  final int? points;

  const LeaderboardItem({
    super.key,
    required this.name,
    required this.rank,
    this.isTopThree = false,
    this.isLast = false,
    this.avatarUrl,
    this.points,
  });
  String? getBadge() {
    if (rank == 1) return "assets/child/gold_badge.svg";
    if (rank == 2) return "assets/child/silver_badge.svg";
    if (rank == 3) return "assets/child/bronze_badge.svg";
    return null;
  }

  Color getTextColor() {
    if (rank == 1) return const Color(0xFFB894CB);
    return const Color(0xFF55425F);
  }

  Color getPointsColor() {
    if (rank == 1) return const Color(0xFFB894CB);
    return const Color(0xFF6B5B73);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        border: isLast
            ? null
            : const Border(
                bottom: BorderSide(color: Color(0xFFF3F4F6), width: 1),
              ),
      ),
      child: Row(
        children: [
          /// 🔢 Rank
          SizedBox(
            width: 30,
            child: getBadge() != null
                ? SvgPicture.asset(getBadge()!, fit: BoxFit.contain, width: 24)
                : Text(
                    "$rank",
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF716974),
                    ),
                  ),
          ),

          const SizedBox(width: 12),

          /// 👤 Avatar + Badge
          SizedBox(
            width: 64,
            height: 64,
            child: ClipOval(
              child: (avatarUrl != null && avatarUrl!.isNotEmpty)
                  ? SvgPicture.network(
                      avatarUrl!,
                      fit: BoxFit.cover,
                      placeholderBuilder: (context) => Container(
                        color: Colors.grey.shade200,
                        child: const Center(child: CircularProgressIndicator()),
                      ),
                    )
                  : Image.asset(
                      "assets/child/rank${rank}.png",
                      fit: BoxFit.cover,
                    ),
            ),
          ),

          const SizedBox(width: 16),

          /// 📝 Name
          Expanded(
            child: Text(
              name,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: getTextColor(),
              ),
            ),
          ),

          /// ⭐ Points
          Text(
            "${points ?? 9} XP",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: getPointsColor(),
            ),
          ),
        ],
      ),
    );
  }
}

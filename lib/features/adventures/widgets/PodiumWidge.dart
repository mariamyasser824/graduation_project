import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PodiumUser {
  final String name;
  final String image;
  final String points;

  PodiumUser({required this.name, required this.image, required this.points});
}

class PodiumWidget extends StatelessWidget {
  final List<PodiumUser> topUsers;

  const PodiumWidget({super.key, required this.topUsers});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          /// 🥈 الثاني
          _buildItem(
            rank: 2,
            height: 108,
            color: const Color(0xFFB9A2C5),
            topImage: "assets/child/silve_top.png",
            badgeImage: "assets/child/silver_badge.svg",
          ),

          _buildItem(
            rank: 1,
            height: 155,
            gradient: const LinearGradient(
              colors: [Color(0xFFB992CD), Color(0xFFC7AAD7)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            topImage: "assets/child/gold_top.png",
            badgeImage: "assets/child/gold_badge.svg",
          ),

          _buildItem(
            rank: 3,
            height: 82,
            color: const Color(0xFFB9A2C5),
            topImage: "assets/child/bronze_top.png",
            badgeImage: "assets/child/bronze_badge.svg",
          ),
        ],
      ),
    );
  }

  Widget _buildItem({
    required int rank,
    required double height,
    required String topImage,
    required String badgeImage,
    Color? color,
    Gradient? gradient,
  }) {
    final user = topUsers[rank - 1];

    double fontSize = rank == 1
        ? 28
        : rank == 2
        ? 22
        : 20;

    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        /// 👤 Avatar + Badge
        SizedBox(
          width: 70.w,
          height: 75.h,
          child: Stack(
            children: [
              SizedBox(
                width: 65.w,
                height: 65.h,
                child: ClipOval(
                  child: user.image.startsWith("http")
                      ? SvgPicture.network(
                          user.image,
                          fit: BoxFit.cover,
                          placeholderBuilder: (context) =>
                              Container(color: Colors.grey.shade200),
                        )
                      : Image.asset(user.image, fit: BoxFit.cover),
                ),
              ),

              /// 🏅 Badge SVG
              Align(
                alignment: AlignmentGeometry.bottomCenter,
                child: SvgPicture.asset(
                  badgeImage,
                  fit: BoxFit.cover,
                  width: 24.w,
                  height: 24.h,
                ),
              ),
            ],
          ),
        ),

        SizedBox(height: 6.h),

        /// الاسم
        Text(user.name, style: const TextStyle(fontWeight: FontWeight.w600)),

        SizedBox(height: 4.h),

        /// points
        Container(
          width: 58.w, // قريبة من 57.81
          height: 23.h,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.white, // نفس #FFFFFF01
            borderRadius: BorderRadius.circular(999), // pill shape
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                offset: const Offset(0, 2),
                blurRadius: 4,
                spreadRadius: -2,
              ),
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                offset: const Offset(0, 4),
                blurRadius: 6,
                spreadRadius: -1,
              ),
            ],
          ),
          child: Text(user.points, style: const TextStyle(fontSize: 10)),
        ),

        SizedBox(height: 8.h),

        /// العمود + التوب
        Column(
          children: [
            /// 🔝 Top Image
            Image.asset(topImage, width: 120.w, fit: BoxFit.cover),

            /// 🧱 العمود
            Container(
              width: 120.w,
              height: height.h,
              decoration: BoxDecoration(
                color: gradient == null ? color : null,
                gradient: gradient,
              ),
              alignment: Alignment.center,
              child: Text(
                "$rank",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: fontSize.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

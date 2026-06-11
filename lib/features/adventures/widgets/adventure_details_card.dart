import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:rewarding_kids/features/adventures/models/adventure_details_model.dart';
import 'package:rewarding_kids/features/adventures/widgets/How%20_it_works.dart';
import 'package:rewarding_kids/features/adventures/widgets/adventure_description.dart';
import 'package:rewarding_kids/features/adventures/widgets/adventure_title_row.dart';
import 'package:rewarding_kids/features/adventures/widgets/start_adventure_button.dart';

class AdventureDetailsCard extends StatelessWidget {
  final AdventureDetailsModel details;

  const AdventureDetailsCard({super.key, required this.details});
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        /// 🔥 الكارد بالـ curve + notch
        Positioned(
          top: 280.h,
          left: 16.w,
          right: 16.w,
          child: ClipPath(
            clipper: SlantedRoundedCardClipper(),
            child: Container(
              height: 540.h,
              padding: EdgeInsets.fromLTRB(16.w, 60.h, 16.w, 16.h),
              decoration: BoxDecoration(
                color: Color(0xffF7F1FF),
                borderRadius: BorderRadius.circular(24.r),

                boxShadow: [
                  BoxShadow(
                    color: Color(0xffA68F8F).withOpacity(0.25),
                    blurRadius: 20,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  AdventureTitleRow(title: details.titleEn),
                  const SizedBox(height: 15),

                  AdventureDescription(description: details.descriptionEn),
                  const Spacer(),
                  const HowItWorksRow(),
                  const Spacer(),
                  StartAdventureButton(
                    onTap: () {
                      
                      context.push(
                        '/adv_levels',
                        extra: details.weeklyAdventureId,
                      );
                    },
                    text: "Start Adventure",
                  ),
                ],
              ),
            ),
          ),
        ),
        Positioned(
          top: 316.h,
          left: 275.w,

          child: Container(
            height: 50.h,
            width: 50.w,
            decoration: BoxDecoration(
              shape: BoxShape.circle,

              color: Color(0xffF7F1FF),
              boxShadow: [
                BoxShadow(
                  color: Color(0xffC9BFDB).withOpacity(0.40),
                  blurRadius: 20,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Icon(
              Icons.play_arrow,
              size: 30.sp,
              color: Color(0xff6550A4),
            ),
          ),
        ),
      ],
    );
  }
}

class SlantedRoundedCardClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final radius = 30.0;

    final path = Path();

    /// start من فوق شمال (مدور)
    path.moveTo(radius, 0);

    /// الخط العلوي المائل (العكس اللي انتي عايزاه)
    path.lineTo(size.width - radius, 60);

    /// corner top right
    path.quadraticBezierTo(size.width, 60, size.width, 60 + radius);

    /// يمين تحت
    path.lineTo(size.width, size.height - radius);

    /// corner bottom right
    path.quadraticBezierTo(
      size.width,
      size.height,
      size.width - radius,
      size.height,
    );

    /// تحت شمال
    path.lineTo(radius, size.height);

    /// corner bottom left
    path.quadraticBezierTo(0, size.height, 0, size.height - radius);

    /// طالع لفوق شمال
    path.lineTo(0, radius);

    /// corner top left
    path.quadraticBezierTo(0, 0, radius, 0);

    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
// Mariam part
// Mariam mobile part